
const menuButton = document.getElementById('menu-button');
const closeMenuButton = document.getElementById('close-menu-button');
const mobileMenu = document.getElementById('mobile-menu');

function toggleMenu() {
  mobileMenu.classList.toggle('hidden');
}

menuButton.addEventListener('click', toggleMenu);
closeMenuButton.addEventListener('click', toggleMenu);