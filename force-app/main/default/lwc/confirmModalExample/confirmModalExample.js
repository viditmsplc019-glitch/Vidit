import { LightningElement } from 'lwc';
import LightningConfirm from "lightning/confirm";
 
export default class ConfirmModalExample extends LightningElement {
  async handleConfirmClick() {
    const result = await LightningConfirm.open({
      message: "This is the confirmation message.",
      variant: "headerless",


      label: "This is the aria-label value",
    });
  }
}