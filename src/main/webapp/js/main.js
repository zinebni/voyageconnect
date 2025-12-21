// VoyageConnect - Scripts JavaScript

document.addEventListener('DOMContentLoaded', function() {
    console.log('VoyageConnect initialized');
    
    // Initialiser les tooltips Bootstrap
    initializeTooltips();
    
    // Gérer le formulaire de recherche
    setupSearchForm();
    
    // Validation des formulaires
    setupFormValidation();
});

/**
 * Initialise les tooltips Bootstrap
 */
function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

/**
 * Configure le formulaire de recherche
 */
function setupSearchForm() {
    const searchForm = document.getElementById('searchForm');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            handleSearch();
        });
    }
}

/**
 * Gère la recherche AJAX
 */
async function handleSearch() {
    const searchType = document.getElementById('searchType').value;
    const destination = document.getElementById('destination').value;
    const departureDate = document.getElementById('departureDate').value;
    
    if (!destination) {
        showAlert('Veuillez entrer une destination', 'warning');
        return;
    }
    
    showSpinner();
    
    try {
        const url = `/VoyageConnect/search/${searchType}s?destination=${encodeURIComponent(destination)}&departureDate=${departureDate}`;
        const response = await fetch(url);
        
        if (!response.ok) {
            throw new Error('Erreur lors de la recherche');
        }
        
        const results = await response.json();
        displaySearchResults(results, searchType);
        
    } catch (error) {
        console.error('Erreur:', error);
        showAlert('Une erreur est survenue lors de la recherche', 'danger');
    } finally {
        hideSpinner();
    }
}

/**
 * Affiche les résultats de recherche
 */
function displaySearchResults(results, type) {
    console.log('Résultats:', results);
    // Rediriger vers la page de résultats
    window.location.href = `/VoyageConnect/search/${type}s?destination=${document.getElementById('destination').value}`;
}

/**
 * Configure la validation des formulaires
 */
function setupFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
}

/**
 * Affiche une alerte
 */
function showAlert(message, type = 'info') {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-3`;
    alertDiv.style.zIndex = '9999';
    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    document.body.appendChild(alertDiv);
    
    setTimeout(() => {
        alertDiv.remove();
    }, 5000);
}

/**
 * Affiche le spinner de chargement
 */
function showSpinner() {
    const spinner = document.createElement('div');
    spinner.id = 'loadingSpinner';
    spinner.className = 'spinner-overlay';
    spinner.innerHTML = '<div class="spinner-border text-light" role="status"><span class="visually-hidden">Chargement...</span></div>';
    document.body.appendChild(spinner);
}

/**
 * Cache le spinner de chargement
 */
function hideSpinner() {
    const spinner = document.getElementById('loadingSpinner');
    if (spinner) {
        spinner.remove();
    }
}

/**
 * Formate une date
 */
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('fr-FR', options);
}

/**
 * Formate un prix
 */
function formatPrice(price) {
    return new Intl.NumberFormat('fr-FR', {
        style: 'currency',
        currency: 'EUR'
    }).format(price);
}

/**
 * Confirme une action
 */
function confirmAction(message) {
    return confirm(message);
}

/**
 * Recherche de vols AJAX
 */
async function searchFlights(params) {
    const queryString = new URLSearchParams(params).toString();
    const response = await fetch(`/VoyageConnect/search/flights?${queryString}`);
    return await response.json();
}

/**
 * Recherche d'hôtels AJAX
 */
async function searchHotels(params) {
    const queryString = new URLSearchParams(params).toString();
    const response = await fetch(`/VoyageConnect/search/hotels?${queryString}`);
    return await response.json();
}

/**
 * Recherche de circuits AJAX
 */
async function searchCircuits(params) {
    const queryString = new URLSearchParams(params).toString();
    const response = await fetch(`/VoyageConnect/search/circuits?${queryString}`);
    return await response.json();
}

/**
 * Réserver un vol
 */
async function bookFlight(flightId) {
    if (!confirmAction('Confirmer la réservation de ce vol ?')) {
        return;
    }
    
    showSpinner();
    try {
        const response = await fetch('/VoyageConnect/reservation/flight', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `flightId=${flightId}&paymentMethod=CREDIT_CARD`
        });
        
        if (response.ok) {
            showAlert('Réservation effectuée avec succès !', 'success');
            setTimeout(() => {
                window.location.href = '/VoyageConnect/reservation/list';
            }, 2000);
        } else {
            throw new Error('Erreur lors de la réservation');
        }
    } catch (error) {
        showAlert('Une erreur est survenue lors de la réservation', 'danger');
    } finally {
        hideSpinner();
    }
}
