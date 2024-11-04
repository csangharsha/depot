import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment"
export default class extends Controller {
  static targets = ["selection", "additionalFields"]
  connect() {
  }

  initialize() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    let selection = this.selectionTarget.value

    for (let field of this.additionalFieldsTargets) {
      field.disabled = field.hidden = (field.dataset.type != selection)
      console.log(field.disabled, field.hidden, field.dataset.type != selection)
    }
  }

}
