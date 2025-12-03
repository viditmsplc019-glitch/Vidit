import { LightningElement } from 'lwc';

export default class ParentChildARRAYOBJ extends LightningElement {
    userDetails = [
        {
            name: 'John Doe',
            title: 'CEO & Founder',
            company: 'Harvard University, example',
            buttontext: 'Contact',
            imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg'
        },
        {
            name: 'Steve Smith',
            title: 'CEO & Founder',
            company: 'Stanford University, example',
            buttontext: 'Contact',
            imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg'
        },
        {
            name: 'David Warner',
            title: 'CEO & Founder',
            company: 'Sydney University, example',
            buttontext: 'Contact',
            imageUrl: 'https://randomuser.me/api/portraits/men/78.jpg'
        },
        {
            name: 'Peter Parker',
            title: 'CEO & Founder',
            company: 'Melbourne University, example',
            buttontext: 'Contact',
            imageUrl: 'https://randomuser.me/api/portraits/men/66.jpg'
        }
    ];
}