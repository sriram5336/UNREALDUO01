// js/login.js
import { supabase } from './supabaseClient.js';

document.addEventListener('DOMContentLoaded', () => {
  initRoleTabs();
  initLoginForm();
  initForgotPasswordModal();
});

// ---------------------------------------------------------------------
// Role tabs (Student / Staff / Admin)
// ---------------------------------------------------------------------
function initRoleTabs() {
  const tabs = document.querySelectorAll('.login-tab');
  const roleInput = document.getElementById('login-role');
  const usernameLabel = document.getElementById('username-label');
  const usernameInput = document.getElementById('login-username');

  const labelByRole = {
    student: 'Student ID',
    staff: 'Staff ID',
    admin: 'Admin ID'
  };
  const placeholderByRole = {
    student: 'e.g. student1',
    staff: 'e.g. STF001',
    admin: 'e.g. ADM001'
  };

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      tabs.forEach((t) => t.classList.remove('active'));
      tab.classList.add('active');

      const role = tab.dataset.role;
      roleInput.value = role;
      usernameLabel.textContent = labelByRole[role] || 'Username';
      usernameInput.placeholder = placeholderByRole[role] || '';

      clearError();
    });
  });
}

// ---------------------------------------------------------------------
// Login form submit
// ---------------------------------------------------------------------
function initLoginForm() {
  const form = document.getElementById('login-form');
  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    clearError();

    const role = document.getElementById('login-role').value;
    const username = document.getElementById('login-username').value.trim();
    const password = document.getElementById('login-password').value;
    const submitBtn = form.querySelector('.form-submit-btn');

    if (!username || !password) {
      showError('Please fill in both fields.');
      return;
    }

    setLoading(submitBtn, true);

    try {
      if (role === 'student') {
        const { data, error } = await supabase.rpc('verify_student_login', {
          p_username: username,
          p_password: password
        });

        if (error) {
          console.error('Login RPC error:', error);
          showError('Something went wrong. Please try again.');
          return;
        }

        const row = data && data[0];
        if (!row || !row.success) {
          showError('Invalid Student ID or Password.');
          return;
        }

        sessionStorage.setItem('student_id', row.student_id);
        sessionStorage.setItem('student_username', row.username);
        window.location.href = 'dashboard.html';
      } else {
        // Staff/Admin login not wired up yet — plug in their own
        // verify_staff_login / verify_admin_login RPCs the same way.
        showError('Staff/Admin login is not available yet.');
      }
    } finally {
      setLoading(submitBtn, false);
    }
  });
}

function showError(message) {
  const box = document.getElementById('login-error-msg');
  if (!box) return;
  box.textContent = message;
  box.style.display = 'block';
}

function clearError() {
  const box = document.getElementById('login-error-msg');
  if (!box) return;
  box.style.display = 'none';
  box.textContent = '';
}

function setLoading(btn, isLoading) {
  if (!btn) return;
  btn.disabled = isLoading;
  btn.style.opacity = isLoading ? '0.6' : '1';
}

// ---------------------------------------------------------------------
// Forgot Password modal
// ---------------------------------------------------------------------
function initForgotPasswordModal() {
  const link = document.getElementById('forgot-pw-link');
  const modal = document.getElementById('forgot-pw-modal');
  const closeBtn = document.getElementById('modal-close-btn');
  const form = document.getElementById('forgot-pw-form');
  const statusMsg = document.getElementById('forgot-status-msg');

  if (!link || !modal) return;

  link.addEventListener('click', (e) => {
    e.preventDefault();
    modal.style.display = 'flex';
  });

  closeBtn?.addEventListener('click', () => {
    modal.style.display = 'none';
    resetModalStatus();
  });

  modal.addEventListener('click', (e) => {
    // Close when clicking the dark overlay itself, not the card
    if (e.target === modal) {
      modal.style.display = 'none';
      resetModalStatus();
    }
  });

  form?.addEventListener('submit', async (e) => {
    e.preventDefault();
    resetModalStatus();

    const roll = document.getElementById('forgot-roll').value.trim();
    const email = document.getElementById('forgot-email').value.trim();
    const submitBtn = form.querySelector('.form-submit-btn');

    setLoading(submitBtn, true);

    try {
      const { data, error } = await supabase.rpc('reset_student_password', {
        p_username: roll,
        p_email: email
      });

      if (error) {
        console.error('Reset RPC error:', error);
        showModalStatus('Something went wrong. Please try again.', 'danger');
        return;
      }

      const row = data && data[0];
      if (row && row.success) {
        showModalStatus('Password reset! You can now log in with the default password.', 'success');
        form.reset();
      } else {
        showModalStatus('No matching account found for that Roll Number and Email.', 'danger');
      }
    } finally {
      setLoading(submitBtn, false);
    }
  });

  function showModalStatus(message, type) {
    if (!statusMsg) return;
    statusMsg.textContent = message;
    statusMsg.className = `modal-status-msg ${type}`;
    statusMsg.style.display = 'block';
  }

  function resetModalStatus() {
    if (!statusMsg) return;
    statusMsg.style.display = 'none';
    statusMsg.textContent = '';
    statusMsg.className = 'modal-status-msg';
  }
}
