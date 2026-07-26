// Global page scripts: Preloader, Custom cursor, Theme switcher, Ripple buttons, Particle background, Header/Footer injection

document.addEventListener('DOMContentLoaded', () => {
  initLayout();
  initPreloader();
  initCustomCursor();
  initTheme();
  initRippleButtons();
  initParticles();
  initMobileMenu();
});

// 1. HEADER & FOOTER DYNAMIC INJECTION
function initLayout() {
  const isDashboard = window.location.pathname.includes('dashboard');
  
  // Inject Header if selector exists
  const headerElem = document.querySelector('header');
  if (headerElem && !headerElem.innerHTML.trim()) {
    headerElem.innerHTML = `
      <div class="nav-container">
        <div class="logo-area" onclick="window.location.href='index.html'">
          <div class="college-logo-img">S</div>
          <span class="logo-title">Saranathan College</span>
        </div>
        <ul class="nav-links">
          <li><a href="index.html" id="nav-home">Home</a></li>
          <li><a href="campus.html" id="nav-campus">3D Campus</a></li>
          <li><a href="map.html" id="nav-map">Campus Map</a></li>
          <li><a href="library.html" id="nav-library">Library</a></li>
          <li><a href="chatbot.html" id="nav-chatbot">AI Chatbot</a></li>
          <li><a href="events.html" id="nav-events">Events</a></li>
          <li><a href="login.html?tab=admin" id="nav-database">Database Panel</a></li>
          <li><a href="about.html" id="nav-about">About</a></li>
          <li><a href="contact.html" id="nav-contact">Contact</a></li>
        </ul>
        <div class="nav-right">
          <button class="theme-toggle" id="theme-toggle-btn" aria-label="Toggle Theme">
            <i class="bx bx-moon" id="theme-icon"></i>
          </button>
          <button class="btn-login-nav" onclick="window.location.href='login.html'">Portal Login</button>
          <button class="menu-btn" aria-label="Toggle Mobile Menu">
            <i class="bx bx-menu"></i>
          </button>
        </div>
      </div>
    `;
    setActiveNavLink();
  }

  // Inject Footer if selector exists
  const footerElem = document.querySelector('footer');
  if (footerElem && !footerElem.innerHTML.trim()) {
    footerElem.innerHTML = `
      <div class="footer-content">
        <div class="footer-branding">
          <h3>Saranathan College of Engineering</h3>
          <p>Affiliated to Anna University, Chennai. Approved by AICTE, New Delhi.</p>
          <p style="margin-top: 10px; font-weight: 500; color: var(--text-primary);">
            Venkateswara Nagar, Panjappur,<br>
            Tiruchirappalli - 620012, Tamil Nadu, India.
          </p>
        </div>
        <div class="footer-links">
          <h4>Portals</h4>
          <ul>
            <li><a href="login.html?tab=student">Student Dashboard</a></li>
            <li><a href="login.html?tab=staff">Staff Dashboard</a></li>
            <li><a href="login.html?tab=admin">Admin Dashboard</a></li>
            <li><a href="login.html?tab=admin">Database Control Panel</a></li>
            <li><a href="register.html">Student Registration</a></li>
          </ul>
        </div>
        <div class="footer-links">
          <h4>Quick Links</h4>
          <ul>
            <li><a href="library.html">Digital Library</a></li>
            <li><a href="campus.html">3D Virtual Campus</a></li>
            <li><a href="chatbot.html">AI Campus Assistant</a></li>
            <li><a href="notice.html">Notice Board</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; ${new Date().getFullYear()} Saranathan College of Engineering. All rights reserved. Made with 🤍 for Advanced Agentic Coding.</p>
      </div>
    `;
  }
  
  // Inject floating poster unblock button if not on poster.html and not in an iframe
  if (!window.location.pathname.includes('poster.html') && !isDashboard && window.self === window.top) {
    const triggerBtn = document.createElement('button');
    triggerBtn.className = 'floating-poster-trigger';
    triggerBtn.innerHTML = `<i class="bx bx-gift"></i> Start Your Journey`;
    triggerBtn.onclick = () => { window.location.href = 'poster.html'; };
    document.body.appendChild(triggerBtn);
  }
}

function setActiveNavLink() {
  const path = window.location.pathname.split('/').pop() || 'index.html';
  const navIdMap = {
    'index.html': 'nav-home',
    'campus.html': 'nav-campus',
    'map.html': 'nav-map',
    'library.html': 'nav-library',
    'chatbot.html': 'nav-chatbot',
    'events.html': 'nav-events',
    'about.html': 'nav-about',
    'contact.html': 'nav-contact'
  };
  const activeId = navIdMap[path];
  if (activeId) {
    const activeLink = document.getElementById(activeId);
    if (activeLink) activeLink.classList.add('active');
  }
}

// 2. PRELOADER
function initPreloader() {
  const preloader = document.querySelector('.preloader');
  if (preloader) {
    // If we are on campus.html, do NOT auto-hide the preloader on page load
    // The 3D model loader inside three-scene.js will dismiss it once the GLB is fully loaded.
    if (window.location.pathname.includes('campus.html')) {
      return;
    }
    
    window.addEventListener('load', () => {
      preloader.style.opacity = '0';
      setTimeout(() => {
        preloader.style.display = 'none';
      }, 500);
    });
    // Fallback if load event already fired
    if (document.readyState === 'complete') {
      preloader.style.opacity = '0';
      setTimeout(() => {
        preloader.style.display = 'none';
      }, 500);
    }
  }
}

// 3. CUSTOM INTERACTIVE CURSOR
function initCustomCursor() {
  // Mobile check
  if (window.matchMedia('(max-width: 768px)').matches) return;
  
  const cursor = document.createElement('div');
  cursor.className = 'custom-cursor';
  document.body.appendChild(cursor);

  document.addEventListener('mousemove', (e) => {
    cursor.style.left = `${e.clientX}px`;
    cursor.style.top = `${e.clientY}px`;
  });

  const hoverables = document.querySelectorAll('a, button, input, select, textarea, .logo-area, .interactive');
  hoverables.forEach(item => {
    item.addEventListener('mouseenter', () => {
      cursor.style.transform = 'translate(-50%, -50%) scale(1.6)';
      cursor.style.backgroundColor = 'rgba(59, 130, 246, 0.1)';
    });
    item.addEventListener('mouseleave', () => {
      cursor.style.transform = 'translate(-50%, -50%) scale(1)';
      cursor.style.backgroundColor = 'transparent';
    });
  });
}

// 4. THEME SWITCHER (Dark/Light)
function initTheme() {
  const themeToggle = document.getElementById('theme-toggle-btn');
  if (!themeToggle) return;
  
  const themeIcon = document.getElementById('theme-icon');
  
  // Check stored theme or default to dark
  const storedTheme = localStorage.getItem('theme') || 'dark';
  document.documentElement.setAttribute('data-theme', storedTheme);
  updateThemeIcon(storedTheme, themeIcon);
  
  themeToggle.addEventListener('click', () => {
    const currentTheme = document.documentElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateThemeIcon(newTheme, themeIcon);
  });
}

function updateThemeIcon(theme, icon) {
  if (!icon) return;
  if (theme === 'dark') {
    icon.className = 'bx bx-sun';
  } else {
    icon.className = 'bx bx-moon';
  }
}

// 5. RIPPLE BUTTONS
function initRippleButtons() {
  document.addEventListener('click', (e) => {
    const button = e.target.closest('.ripple-btn');
    if (!button) return;
    
    const ripple = document.createElement('span');
    ripple.className = 'ripple';
    
    const rect = button.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;
    
    ripple.style.left = `${x}px`;
    ripple.style.top = `${y}px`;
    
    button.appendChild(ripple);
    
    setTimeout(() => {
      ripple.remove();
    }, 600);
  });
}

// 6. CONNECTING PARTICLES BACKGROUND
function initParticles() {
  const canvas = document.querySelector('.particle-canvas');
  if (!canvas) return;
  
  const ctx = canvas.getContext('2d');
  let animationId;
  
  let particlesArray = [];
  const numberOfParticles = 75;
  const connectionDistance = 120;
  
  let mouse = {
    x: null,
    y: null,
    radius: 150
  };
  
  window.addEventListener('mousemove', (e) => {
    mouse.x = e.clientX;
    mouse.y = e.clientY;
  });
  
  window.addEventListener('mouseout', () => {
    mouse.x = null;
    mouse.y = null;
  });
  
  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }
  
  window.addEventListener('resize', resizeCanvas);
  resizeCanvas();
  
  class Particle {
    constructor() {
      this.x = Math.random() * canvas.width;
      this.y = Math.random() * canvas.height;
      this.size = Math.random() * 2 + 1;
      this.speedX = Math.random() * 0.8 - 0.4;
      this.speedY = Math.random() * 0.8 - 0.4;
    }
    
    update() {
      this.x += this.speedX;
      this.y += this.speedY;
      
      // Boundaries
      if (this.x < 0 || this.x > canvas.width) this.speedX = -this.speedX;
      if (this.y < 0 || this.y > canvas.height) this.speedY = -this.speedY;
      
      // Mouse interaction
      if (mouse.x !== null && mouse.y !== null) {
        let dx = mouse.x - this.x;
        let dy = mouse.y - this.y;
        let distance = Math.sqrt(dx * dx + dy * dy);
        if (distance < mouse.radius) {
          // Push away slightly
          const force = (mouse.radius - distance) / mouse.radius;
          this.x -= dx / distance * force * 2;
          this.y -= dy / distance * force * 2;
        }
      }
    }
    
    draw() {
      ctx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--color-primary').trim();
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
      ctx.fill();
    }
  }
  
  function setupParticles() {
    particlesArray = [];
    for (let i = 0; i < numberOfParticles; i++) {
      particlesArray.push(new Particle());
    }
  }
  
  function drawConnections() {
    for (let a = 0; a < particlesArray.length; a++) {
      for (let b = a; b < particlesArray.length; b++) {
        let dx = particlesArray[a].x - particlesArray[b].x;
        let dy = particlesArray[a].y - particlesArray[b].y;
        let distance = Math.sqrt(dx * dx + dy * dy);
        
        if (distance < connectionDistance) {
          const opacity = (1 - (distance / connectionDistance)) * 0.15;
          ctx.strokeStyle = `rgba(59, 130, 246, ${opacity})`;
          ctx.lineWidth = 1;
          ctx.beginPath();
          ctx.moveTo(particlesArray[a].x, particlesArray[a].y);
          ctx.lineTo(particlesArray[b].x, particlesArray[b].y);
          ctx.stroke();
        }
      }
    }
  }
  
  function animate() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (let i = 0; i < particlesArray.length; i++) {
      particlesArray[i].update();
      particlesArray[i].draw();
    }
    drawConnections();
    animationId = requestAnimationFrame(animate);
  }
  
  setupParticles();
  animate();
}

// 7. MOBILE RESPONSIVE NAV MENU
function initMobileMenu() {
  const menuBtn = document.querySelector('.menu-btn');
  const navLinks = document.querySelector('.nav-links');
  if (!menuBtn || !navLinks) return;
  
  menuBtn.addEventListener('click', (e) => {
    e.stopPropagation();
    const isActive = navLinks.classList.toggle('active');
    menuBtn.innerHTML = isActive ? '<i class="bx bx-x"></i>' : '<i class="bx bx-menu"></i>';
  });

  // Close menu when clicking nav links
  navLinks.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      navLinks.classList.remove('active');
      menuBtn.innerHTML = '<i class="bx bx-menu"></i>';
    });
  });

  // Close menu when clicking outside
  document.addEventListener('click', (e) => {
    if (!navLinks.contains(e.target) && !menuBtn.contains(e.target) && navLinks.classList.contains('active')) {
      navLinks.classList.remove('active');
      menuBtn.innerHTML = '<i class="bx bx-menu"></i>';
    }
  });
}
