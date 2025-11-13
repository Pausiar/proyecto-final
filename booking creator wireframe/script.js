// Función para mostrar pantallas
function showScreen(screenId) {
    // Ocultar todas las pantallas
    const screens = document.querySelectorAll('.screen');
    screens.forEach(screen => {
        screen.classList.remove('active');
    });
    
    // Mostrar la pantalla seleccionada
    const targetScreen = document.getElementById(screenId);
    if (targetScreen) {
        targetScreen.classList.add('active');
        // Scroll to top
        targetScreen.scrollTop = 0;
    }
}

// Función para confirmar reserva
function confirmBooking() {
    // Validación simple
    const termsCheckbox = document.getElementById('terms');
    if (!termsCheckbox.checked) {
        alert('Por favor, acepta los términos y condiciones');
        return;
    }
    
    // Mostrar pantalla de confirmación
    showScreen('screen-confirmation');
}

// Animaciones al cargar
document.addEventListener('DOMContentLoaded', function() {
    console.log('Booking Creator Wireframe cargado');
    
    // Efecto de carga inicial
    const phoneFrame = document.querySelector('.phone-frame');
    phoneFrame.style.opacity = '0';
    phoneFrame.style.transform = 'scale(0.9)';
    
    setTimeout(() => {
        phoneFrame.style.transition = 'all 0.5s ease';
        phoneFrame.style.opacity = '1';
        phoneFrame.style.transform = 'scale(1)';
    }, 100);
});

// Simular selección de método de pago
document.addEventListener('click', function(e) {
    if (e.target.closest('.payment-option')) {
        // Remover selección previa
        document.querySelectorAll('.payment-option').forEach(option => {
            option.classList.remove('selected');
            option.querySelector('input[type="radio"]').checked = false;
        });
        
        // Seleccionar nuevo método
        const selectedOption = e.target.closest('.payment-option');
        selectedOption.classList.add('selected');
        selectedOption.querySelector('input[type="radio"]').checked = true;
    }
});

// Simular búsqueda y filtros
const searchInput = document.querySelector('.search-input');
if (searchInput) {
    searchInput.addEventListener('input', function(e) {
        console.log('Buscando:', e.target.value);
        // Aquí iría la lógica de búsqueda real
    });
}

// Chips de filtro
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('chip')) {
        document.querySelectorAll('.chip').forEach(chip => {
            chip.classList.remove('active');
        });
        e.target.classList.add('active');
    }
});

// Efectos hover mejorados para tarjetas
const businessCards = document.querySelectorAll('.business-card');
businessCards.forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transition = 'all 0.3s ease';
    });
});

// Simular carga de imágenes
const imagePlaceholders = document.querySelectorAll('.image-placeholder');
imagePlaceholders.forEach(placeholder => {
    placeholder.addEventListener('click', function() {
        console.log('Abriendo selector de imagen...');
        // Aquí iría la lógica para subir imágenes
        this.style.borderColor = '#667eea';
        setTimeout(() => {
            this.style.borderColor = '#ccc';
        }, 500);
    });
});

// Validación de formularios
function validateForm(formElement) {
    const inputs = formElement.querySelectorAll('.input-field');
    let isValid = true;
    
    inputs.forEach(input => {
        if (input.hasAttribute('required') && !input.value.trim()) {
            input.style.borderColor = '#f44336';
            isValid = false;
        } else {
            input.style.borderColor = '#ddd';
        }
    });
    
    return isValid;
}

// Animación de scroll suave
document.querySelectorAll('.screen').forEach(screen => {
    screen.style.scrollBehavior = 'smooth';
});

// Simulación de carga de reseñas
function loadReviews() {
    console.log('Cargando más reseñas...');
    // Aquí iría la lógica para cargar más reseñas
}

// Función para dar like a reseñas
function likeReview(reviewId) {
    console.log('Like a reseña:', reviewId);
    // Aquí iría la lógica para dar like
}

// Prevenir envío de formularios (es un wireframe)
document.addEventListener('submit', function(e) {
    e.preventDefault();
    console.log('Formulario enviado (simulación)');
});

// Feedback visual al hacer clic en botones
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('btn')) {
        const btn = e.target;
        btn.style.transform = 'scale(0.95)';
        setTimeout(() => {
            btn.style.transform = 'scale(1)';
        }, 100);
    }
});

// Atajos de teclado para navegación rápida
document.addEventListener('keydown', function(e) {
    // 1: Inicio
    if (e.key === '1') showScreen('screen-home');
    // 2: Registro empresa
    if (e.key === '2') showScreen('screen-business-register');
    // 3: Búsqueda
    if (e.key === '3') showScreen('screen-search');
    // 4: Detalle
    if (e.key === '4') showScreen('screen-detail');
    // 5: Reserva
    if (e.key === '5') showScreen('screen-booking');
    // 6: Confirmación
    if (e.key === '6') showScreen('screen-confirmation');
});

console.log('Usa las teclas 1-6 para navegar rápidamente entre pantallas');
