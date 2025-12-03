import { LightningElement, track } from "lwc";

export default class TwoWayDataBinding extends LightningElement {
  @track fullname = "Vidit Gupta";
  @track title = "Salesforce developer";

  changeHandler(event) {
    this[event.target.name] = event.target.value;
  }
}