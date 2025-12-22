<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservation - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .reservation-container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .reservation-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .reservation-header h1 {
            font-size: 2em;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .reservation-header p {
            font-size: 1.1em;
            opacity: 0.9;
        }

        .reservation-content {
            padding: 40px;
        }

        .travel-details {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .travel-details h2 {
            color: #667eea;
            font-size: 1.5em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .travel-details h2::before {
            content: "✈️";
            font-size: 1.2em;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .detail-item {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .detail-label {
            font-weight: 600;
            color: #667eea;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .detail-value {
            font-size: 1.1em;
            color: #333;
        }

        .price-highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
            margin: 20px 0;
        }

        .reservation-form {
            margin-top: 30px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .form-section h3 {
            color: #667eea;
            font-size: 1.3em;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.95em;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #e0e0e0;
        }

        .btn {
            padding: 15px 40px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.5);
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #d0d0d0;
            transform: translateY(-2px);
        }

        .error-message {
            background: #fee;
            border-left: 4px solid #f00;
            color: #c00;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .reservation-content {
                padding: 20px;
            }

            .detail-grid,
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="reservation-container">
        <div class="reservation-header">
            <h1>Nouvelle Réservation</h1>
            <p>Complétez les informations pour finaliser votre réservation</p>
        </div>

        <div class="reservation-content">
            <c:if test="${not empty error}">
                <div class="error-message">
                    <strong>Erreur :</strong> ${error}
                </div>
            </c:if>

            <!-- Flight Details -->
            <c:if test="${not empty flight}">
                <div class="travel-details">
                    <h2>Détails du Vol</h2>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <div class="detail-label">Vol</div>
                            <div class="detail-value">${flight.flightNumber}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Compagnie</div>
                            <div class="detail-value">${flight.airline}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Départ</div>
                            <div class="detail-value">
                                ${flight.departureCity}<br>
                                ${flight.departureDate}
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Arrivée</div>
                            <div class="detail-value">
                                ${flight.destination.name}<br>
                                ${flight.arrivalDate}
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Classe</div>
                            <div class="detail-value">${flight.flightClass}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Places disponibles</div>
                            <div class="detail-value">${flight.availableSeats} sièges</div>
                        </div>
                    </div>
                    <div class="price-highlight">
                        Prix : <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="€" />
                    </div>
                </div>
            </c:if>

            <!-- Hotel Details -->
            <c:if test="${not empty hotel}">
                <div class="travel-details">
                    <h2 style="display: flex; align-items: center; gap: 10px;">
                        <span>🏨</span> Détails de l'Hôtel
                    </h2>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <div class="detail-label">Hôtel</div>
                            <div class="detail-value">${hotel.name}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Destination</div>
                            <div class="detail-value">${hotel.destination.name}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Adresse</div>
                            <div class="detail-value">${hotel.address}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Étoiles</div>
                            <div class="detail-value">
                                <c:forEach begin="1" end="${hotel.stars}">⭐</c:forEach>
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Chambres disponibles</div>
                            <div class="detail-value">${hotel.availableRooms} chambres</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Services</div>
                            <div class="detail-value">
                                <c:if test="${hotel.wifi}">✓ WiFi</c:if>
                                <c:if test="${hotel.pool}">✓ Piscine</c:if>
                                <c:if test="${hotel.restaurant}">✓ Restaurant</c:if>
                                <c:if test="${hotel.parking}">✓ Parking</c:if>
                            </div>
                        </div>
                    </div>
                    <div class="price-highlight">
                        Prix par nuit : <fmt:formatNumber value="${hotel.pricePerNight}" type="currency" currencySymbol="€" />
                    </div>
                </div>
            </c:if>

            <!-- Circuit Details -->
            <c:if test="${not empty circuit}">
                <div class="travel-details">
                    <h2 style="display: flex; align-items: center; gap: 10px;">
                        <span>🗺️</span> Détails du Circuit
                    </h2>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <div class="detail-label">Circuit</div>
                            <div class="detail-value">${circuit.name}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Destination</div>
                            <div class="detail-value">${circuit.destination.name}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Durée</div>
                            <div class="detail-value">${circuit.durationDays} jours</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Début</div>
                            <div class="detail-value">
                                ${circuit.startDate}
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Fin</div>
                            <div class="detail-value">
                                ${circuit.endDate}
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Places disponibles</div>
                            <div class="detail-value">${circuit.availableSpots} places</div>
                        </div>
                    </div>
                    <div class="detail-item" style="margin-top: 20px;">
                        <div class="detail-label">Programme</div>
                        <div class="detail-value">${circuit.description}</div>
                    </div>
                    <div class="price-highlight">
                        Prix total : <fmt:formatNumber value="${circuit.price}" type="currency" currencySymbol="€" />
                    </div>
                </div>
            </c:if>

            <!-- Reservation Form -->
            <form action="${pageContext.request.contextPath}/reservation/new" method="post" class="reservation-form">
                <c:if test="${not empty flight}">
                    <input type="hidden" name="flightId" value="${flight.id}">
                    <input type="hidden" name="type" value="FLIGHT">
                </c:if>
                <c:if test="${not empty hotel}">
                    <input type="hidden" name="hotelId" value="${hotel.id}">
                    <input type="hidden" name="type" value="HOTEL">
                </c:if>
                <c:if test="${not empty circuit}">
                    <input type="hidden" name="circuitId" value="${circuit.id}">
                    <input type="hidden" name="type" value="CIRCUIT">
                </c:if>

                <!-- Personal Information -->
                <div class="form-section">
                    <h3>Informations Personnelles</h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="firstName">Prénom *</label>
                            <input type="text" id="firstName" name="firstName" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Nom *</label>
                            <input type="text" id="lastName" name="lastName" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email *</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Téléphone *</label>
                            <input type="tel" id="phone" name="phone" required>
                        </div>
                    </div>
                </div>

                <!-- Reservation Details -->
                <div class="form-section">
                    <h3>Détails de la Réservation</h3>
                    <div class="form-grid">
                        <c:if test="${not empty flight}">
                            <div class="form-group">
                                <label for="numberOfPassengers">Nombre de passagers *</label>
                                <input type="number" id="numberOfPassengers" name="numberOfPassengers" 
                                       min="1" max="${flight.availableSeats}" value="1" required>
                            </div>
                        </c:if>
                        <c:if test="${not empty hotel}">
                            <div class="form-group">
                                <label for="checkInDate">Date d'arrivée *</label>
                                <input type="date" id="checkInDate" name="checkInDate" required>
                            </div>
                            <div class="form-group">
                                <label for="checkOutDate">Date de départ *</label>
                                <input type="date" id="checkOutDate" name="checkOutDate" required>
                            </div>
                            <div class="form-group">
                                <label for="numberOfRooms">Nombre de chambres *</label>
                                <input type="number" id="numberOfRooms" name="numberOfRooms" 
                                       min="1" max="${hotel.availableRooms}" value="1" required>
                            </div>
                        </c:if>
                        <c:if test="${not empty circuit}">
                            <div class="form-group">
                                <label for="numberOfParticipants">Nombre de participants *</label>
                                <input type="number" id="numberOfParticipants" name="numberOfParticipants" 
                                       min="1" max="${circuit.availableSpots}" value="1" required>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Payment Information -->
                <div class="form-section">
                    <h3>Informations de Paiement</h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="cardNumber">Numéro de carte *</label>
                            <input type="text" id="cardNumber" name="cardNumber" 
                                   placeholder="1234 5678 9012 3456" 
                                   pattern="[0-9\s]{16,19}" required>
                        </div>
                        <div class="form-group">
                            <label for="cardHolder">Titulaire de la carte *</label>
                            <input type="text" id="cardHolder" name="cardHolder" required>
                        </div>
                        <div class="form-group">
                            <label for="expiryDate">Date d'expiration *</label>
                            <input type="text" id="expiryDate" name="expiryDate" 
                                   placeholder="MM/AA" pattern="[0-9]{2}/[0-9]{2}" required>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV *</label>
                            <input type="text" id="cvv" name="cvv" 
                                   placeholder="123" pattern="[0-9]{3,4}" required>
                        </div>
                    </div>
                </div>

                <!-- Special Requests -->
                <div class="form-section">
                    <h3>Demandes Spéciales (Optionnel)</h3>
                    <div class="form-group">
                        <label for="specialRequests">Avez-vous des demandes particulières ?</label>
                        <textarea id="specialRequests" name="specialRequests" 
                                  placeholder="Régime alimentaire, accessibilité, préférences..."></textarea>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Confirmer la réservation</button>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-secondary">Annuler</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Date validation for hotel
        const checkIn = document.getElementById('checkInDate');
        const checkOut = document.getElementById('checkOutDate');
        
        if (checkIn && checkOut) {
            const today = new Date().toISOString().split('T')[0];
            checkIn.min = today;
            
            checkIn.addEventListener('change', function() {
                checkOut.min = this.value;
                if (checkOut.value && checkOut.value <= this.value) {
                    checkOut.value = '';
                }
            });
        }

        // Card number formatting
        const cardNumber = document.getElementById('cardNumber');
        if (cardNumber) {
            cardNumber.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\s/g, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = formattedValue;
            });
        }

        // Expiry date formatting
        const expiryDate = document.getElementById('expiryDate');
        if (expiryDate) {
            expiryDate.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.slice(0, 2) + '/' + value.slice(2, 4);
                }
                e.target.value = value;
            });
        }

        // Form validation
        document.querySelector('.reservation-form').addEventListener('submit', function(e) {
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = '#f00';
                } else {
                    field.style.borderColor = '#e0e0e0';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires');
            }
        });
    </script>
</body>
</html>
