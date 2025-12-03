import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getSchools from '@salesforce/apex/StudentController.getSchools';
import getClasses from '@salesforce/apex/StudentController.getClasses';
import getStudents from '@salesforce/apex/StudentController.getStudents';
import deleteStudents from '@salesforce/apex/StudentController.deleteStudents';

export default class StudentInformation extends LightningElement {
@track schoolOptions = [];
@track classOptions = [];
@track selectedSchool;
@track selectedClass;
@track selectedRows = [];
@track isModalOpen = false;
@track modalTitle = "New Student";
@track studentRecord = {};

studentData = [];
wiredStudentsResult;

columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Class', fieldName: 'Class__c.Name' },
    { label: 'Age', fieldName: 'Age__c' },
    { label: 'Email', fieldName: 'Email__c' },
    {
        type: 'button',
        typeAttributes: { 
        label: 'Edit',
        name: 'edit',
        title: 'Edit',
        variant: 'brand'
            
        }
    }
];

connectedCallback() {
    this.loadSchools();
}

loadSchools() {
    getSchools().then(result => {
        this.schoolOptions = result.map(s => ({
            label: s.Name,
            value: s.Id
        }));
    });
}

handleSchoolChange(event) {
    this.selectedSchool = event.detail.value;
    this.selectedClass = null;
    this.classOptions = [];
    this.studentData = [];

    getClasses({ schoolId: this.selectedSchool }).then(result => {
        this.classOptions = result.map(c => ({
            label: c.Name,
            value: c.Id
        }));
    });
}

handleClassChange(event) {
    this.selectedClass = event.detail.value;
    
}

@wire(getStudents, { classId: '$selectedClass' })
wiredStudents(result) {
    this.wiredStudentsResult = result;
    if (result.data) {
        this.studentData = result.data;
    } else if (result.error) {
        console.error('Error fetching students:', result.error);
    }
}

handleRowAction(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;
    if (actionName === 'edit') {
        this.modalTitle = "Edit Student";
        this.studentRecord = { ...row };
        this.isModalOpen = true;
    }
}

handleRowSelection(event) {
    this.selectedRows = event.detail.selectedRows.map(r => r.Id);
}

handleNew() {
    this.modalTitle = "New Student";
    this.studentRecord = {};
    this.isModalOpen = true;
}

handleSuccess(event) {
    this.closeModal();
    this.refreshStudents();
}

handleError(event) {
    console.error('Error saving student:', event.detail);
}

handleDelete() {
    if (this.selectedRows.length > 0) {
        deleteStudents({ studentIds: this.selectedRows })
            .then(() => {
                this.selectedRows = [];
                this.refreshStudents();
            })
            .catch(error => {
                console.error('Delete error:', error);
            });
    }
}

refreshStudents() {
    refreshApex(this.wiredStudentsResult);
}

closeModal() {
    this.isModalOpen = false;
}
}