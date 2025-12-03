import { LightningElement, track } from 'lwc';
import getActiveStudents from '@salesforce/apex/StudentController1.getActiveStudents';

const columns = [
{ label: 'Name', fieldName: 'Name', type: 'text' },
{ label: 'Course', fieldName: 'Course__c', type: 'text' },
{ label: 'College', fieldName: 'College__c', type: 'text' },
{ label: 'Active', fieldName: 'Active__c', type: 'boolean' }
];

export default class StudentSearch extends LightningElement {
@track numberOfActiveStudent = 0;
@track students = [];
@track errorMessage = '';
@track columns = columns;
@track searched = false;

handleInputChange(event) {
    this.numberOfActiveStudent = event.target.value;
    this.errorMessage = '';
    this.students = [];
    this.searched = false;
}

handleSearch() {
    this.errorMessage = '';
    this.students = [];
    this.searched = false;

    const count = parseInt(this.numberOfActiveStudent, 10);

    if (isNaN(count) || count < 0) {
        this.errorMessage = 'Please enter a valid positive number';
        return;
    }

    if (count === 0) {
        this.errorMessage = 'Number of active students cannot be zero';
        return;
    }

    getActiveStudents({ limitSize: count })
        .then(result => {
            this.searched = true;
            this.students = result;

            if (result.length === 0) {
                this.errorMessage = 'No active student records found.';
            } else if (result.length < count) {
                this.errorMessage = `Only ${result.length} active records found.`;
            }
        })
        .catch(error => {
            this.errorMessage = error.body ? error.body.message : error.message;
        });
}
get showNoRecords() {
    return this.searched && this.students.length === 0 && !this.errorMessage;
}
}