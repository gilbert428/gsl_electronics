// app/javascript/controllers/stripe_checkout_controller.js
import { Controller } from "stimulus";
import { loadStripe } from "@stripe/stripe-js";

export default class extends Controller {
  static targets = ["form"];
  static values = { publicKey: String, sessionId: String }

  async connect() {
    this.stripe = await loadStripe(this.publicKeyValue);

    this.stripe.redirectToCheckout({
      sessionId: this.sessionIdValue
    }).then((result) => {
      if (result.error) {
        alert(result.error.message);
      }
    });
  }

  disconnect() {
    this.formTarget.removeEventListener("submit", this.submitForm.bind(this));
  }

  async submitForm(event) {
    event.preventDefault();

    const response = await fetch(this.formTarget.action, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    });

    const data = await response.json();

    if (data.url && data.sessionId) {
      const stripe = await loadStripe(this.publicKeyValue);
      stripe.redirectToCheckout({ sessionId: data.sessionId }).then((result) => {
        if (result.error) {
          alert(result.error.message);
        }
      });
    } else {
      alert("Error creating Stripe session.");
    }
  }
}
