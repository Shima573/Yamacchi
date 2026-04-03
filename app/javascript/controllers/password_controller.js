import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password"
export default class extends Controller {
  static targets = [ "input", "button" ]

  connect() {
    
  }

  // ボタンクリック時に発火するメソッド
  toggle() {
    if (this.inputTarget.type === "password") {
      this.showPassword()
    } else {
      this.hidePassword()
    }
  }

  showPassword() {
    this.inputTarget.type = "text"
    this.buttonTarget.textContent = "非表示"
  }

  hidePassword() {
    this.inputTarget.type = "password"
    this.buttonTarget.textContent = "表示"
  }
}
