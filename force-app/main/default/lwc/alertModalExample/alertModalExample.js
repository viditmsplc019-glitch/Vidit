import { LightningElement } from 'lwc';
import LightningAlert from "lightning/alert";
 
export default class AlertModalExample extends LightningElement {
  async showAlert() {
    await LightningAlert.open({
      message: "This is the alert message.",
      theme: "error",
      label: "Error!",
    });
  }
}