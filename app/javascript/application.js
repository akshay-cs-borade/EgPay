// Entry point for the build script in your package.json
import "./controllers"
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"

document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll('.remove_fields').forEach((button) => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      let field = this.closest('.nested-fields');
      field.querySelector("input[type='hidden']").value = 1;
      field.style.display = 'none';
    });
  });

  document.querySelectorAll('.add_fields').forEach((button) => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      let id = new Date().getTime();
      this.dataset.id = id;
      this.insertAdjacentHTML('beforebegin', this.dataset.fields);
    });
  });

  document.querySelectorAll('.add_fields').forEach((button) => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      
    });
  });
});
