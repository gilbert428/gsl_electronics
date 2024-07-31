// app/javascript/controllers/stripe_checkout_controller.js
import { Controller } from "stimulus";
import { loadStripe } from "@stripe/stripe-js";

export default class extends Controller {
  static targets = ["form"];
  static values = { publicKey: String, sessionId: String }

  async connect() {
    this.stripe = await loadStripe(this.publicKeyValue);

    // Add event listener for province change
    document.getElementById('province-select').addEventListener('change', this.updateTaxRates.bind(this));
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

  async updateTaxRates(event) {
    const province = event.target.value;

    // Fetch customer details and tax rates from the server based on the selected province
    const response = await fetch(`/tax_rates?province=${province}`);
    const data = await response.json();

    document.getElementById('gst-rate').textContent = data.gst_rate;
    document.getElementById('pst-rate').textContent = data.pst_rate;
    document.getElementById('hst-rate').textContent = data.hst_rate;
    document.getElementById('qst-rate').textContent = data.qst_rate;

    document.getElementById('hidden-gst-rate').value = data.gst_rate;
    document.getElementById('hidden-pst-rate').value = data.pst_rate;
    document.getElementById('hidden-hst-rate').value = data.hst_rate;
    document.getElementById('hidden-qst-rate').value = data.qst_rate;

    // If customer details are also fetched, update the form fields
    if (data.customer) {
      document.getElementById('email').value = data.customer.email;
      document.getElementById('name').value = data.customer.name;
      document.getElementById('address').value = data.customer.address;
    }
  }
}
