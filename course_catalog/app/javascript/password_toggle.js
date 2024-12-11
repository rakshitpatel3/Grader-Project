function togglePassword() {
  const passwordInput = document.querySelector('#password'); 
  const showPasswordText = document.querySelector('.show-password');
  if (passwordInput.type === 'password') {
    passwordInput.type = 'text';
    showPasswordText.textContent = 'Hide';
  } else {
    passwordInput.type = 'password';
    showPasswordText.textContent = 'Show';
  }
}

function togglePasswordConfirmation() {
  // Select the confirmation input and its corresponding "Show/Hide" span
  const passwordConfirmationInput = document.querySelector('.password-confirmation-input');
  const showPasswordConfirmationText = document.querySelector('.show-password-confirmation');
  
  // Toggle the input type and the span text
  if (passwordConfirmationInput.type === 'password') {
    passwordConfirmationInput.type = 'text';
    showPasswordConfirmationText.textContent = 'Hide';
  } else {
    passwordConfirmationInput.type = 'password';
    showPasswordConfirmationText.textContent = 'Show';
  }
}


window.togglePassword = togglePassword;
window.togglePasswordConfirmation = togglePasswordConfirmation;
