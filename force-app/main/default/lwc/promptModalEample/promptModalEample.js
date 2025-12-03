import { LightningElement } from 'lwc';
import LightningPrompt from "lightning/prompt";
 
export default class PromptModalExample extends LightningElement {
handlePromptClick() {
    LightningPrompt.open({
      message: "Please enter your feedback:",
    
      label: "Please Respond!",  
      defaultValue: "Optional initial input value ...!!",
    }).then((result) => {
    });
  }
}