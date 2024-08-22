import { api, LightningElement } from "lwc";

export default class ButtonBasic extends LightningElement {
  @api message;
  clickedButtonLabel;

  handleClick(event) {
    this.clickedButtonLabel = event.target.label;
  }
}
