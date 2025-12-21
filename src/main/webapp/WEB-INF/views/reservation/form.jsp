<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Réservation - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .reservation-form-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .form-header h1 {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .item-details {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .item-details h3 {
            color: #667eea;
            margin-top: 0;
            margin-bottom: 15px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #555;
        }

        .detail-value {
            color: #333;
        }

        .price-highlight {
            font-size: 1.4em;
            font-weight: bold;
            color: #667eea;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .total-calculator {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
            text-align: center;
        }

        .total-calculator h3 {
            margin: 0 0 10px 0;
            font-size: 1.2em;
        }

        .total-amount {
            font-size: 2em;
            font-weight: bold;
        }

        .help-text {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="reservation-form-container">
        <div class="form-header">
            <h1>🎫 Nouvelle Réservation</h1>
            <p>Confirmez les détails de votre réservation</p>
        </div>

        <!-- FORMULAIRE VOL -->
        <c:if test="${reservationType == 'FLIGHT'}">
            <div class="item-details">
                <h3>✈️ Détails du Vol</h3>
                <div class="detail-row">
                    <span class="detail-label">Numéro de vol :</span>
                    <span class="detail-value"><strong>${flight.flightNumber}</strong></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Compagnie :</span>
                    <span class="detail-value">${flight.airline}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Itinéraire :</span>
                    <span class="detail-value">${flight.departureCity} → ${flight.destination.name}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Départ :</span>
                    <span class="detail-value">${flight.departureDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy à HH:mm'))}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Arrivée :</span>
                    <span class="detail-value">${flight.arrivalDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy à HH:mm'))}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Classe :</span>
                    <span class="detail-value">${flight.classType}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Places disponibles :</span>
                    <span class="detail-value">${flight.availableSeats} sièges</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Prix par personne :</span>
                    <span class="detail-value price-highlight">${flight.price} €</span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/reservation/confirm" method="post" id="reservationForm" data-price="${flight.price}">
                <input type="hidden" name="type" value="FLIGHT">
                <input type="hidden" name="flightId" value="${flight.id}">

                <div class="form-group">
                    <label for="numberOfPeople">👥 Nombre de passagers *</label>
                    <input type="number" id="numberOfPeople" name="numberOfPeople" 
                           min="1" max="${flight.availableSeats}" value="1" required
                           onchange="calculateTotal()">
                    <p class="help-text">Maximum ${flight.availableSeats} personnes disponibles</p>
                </div>

                <div class="form-group">
                    <label for="paymentMethod">💳 Méthode de paiement *</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="">-- Choisir --</option>
                        <option value="CREDIT_CARD">Carte de crédit</option>
                        <option value="PAYPAL">PayPal</option>
                        <option value="BANK_TRANSFER">Virement bancaire</option>
                    </select>
                </div>

                <div class="total-calculator">
                    <h3>💰 Montant Total</h3>
                    <div class="total-amount" id="totalAmount">${flight.price} €</div>
                    <p style="margin-top: 10px; opacity: 0.9;">
                        <span id="peopleCount">1</span> personne(s) × ${flight.price} €
                    </p>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-secondary">
                        ⬅️ Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ✅ Confirmer la réservation
                    </button>
                </div>
            </form>

            <script>
                const pricePerPerson = parseFloat(document.getElementById('reservationForm').getAttribute('data-price'));
                function calculateTotal() {
                    const numberOfPeople = document.getElementById('numberOfPeople').value || 1;
                    const total = pricePerPerson * numberOfPeople;
                    document.getElementById('totalAmount').textContent = total.toFixed(2) + ' €';
                    document.getElementById('peopleCount').textContent = numberOfPeople;
                }
            </script>
        </c:if>

        <!-- FORMULAIRE HÔTEL -->
        <c:if test="${reservationType == 'HOTEL'}">
            <div class="item-details">
                <h3>🏨 Détails de l'Hôtel</h3>
                <div class="detail-row">
                    <span class="detail-label">Nom :</span>
                    <span class="detail-value"><strong>${hotel.name}</strong></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Destination :</span>
                    <span class="detail-value">${hotel.destination.name}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Adresse :</span>
                    <span class="detail-value">${hotel.address}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Étoiles :</span>
                    <span class="detail-value">
                        <c:forEach begin="1" end="${hotel.stars}">⭐</c:forEach>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Chambres disponibles :</span>
                    <span class="detail-value">${hotel.availableRooms} chambres</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Prix par nuit :</span>
                    <span class="detail-value price-highlight">${hotel.pricePerNight} €</span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/reservation/confirm" method="post" id="reservationForm" data-price="${hotel.pricePerNight}">
                <input type="hidden" name="type" value="HOTEL">
                <input type="hidden" name="hotelId" value="${hotel.id}">

                <div class="form-group">
                    <label for="numberOfRooms">🛏️ Nombre de chambres *</label>
                    <input type="number" id="numberOfRooms" name="numberOfRooms" 
                           min="1" max="${hotel.availableRooms}" value="1" required
                           onchange="calculateHotelTotal()">
                    <p class="help-text">Maximum ${hotel.availableRooms} chambres disponibles</p>
                </div>

                <div class="form-group">
                    <label for="checkIn">📅 Date d'arrivée *</label>
                    <input type="date" id="checkIn" name="checkIn" required 
                           min="<%= java.time.LocalDate.now() %>"
                           onchange="calculateHotelTotal()">
                </div>

                <div class="form-group">
                    <label for="checkOut">📅 Date de départ *</label>
                    <input type="date" id="checkOut" name="checkOut" required 
                           min="<%= java.time.LocalDate.now().plusDays(1) %>"
                           onchange="calculateHotelTotal()">
                </div>

                <div class="form-group">
                    <label for="paymentMethod">💳 Méthode de paiement *</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="">-- Choisir --</option>
                        <option value="CREDIT_CARD">Carte de crédit</option>
                        <option value="PAYPAL">PayPal</option>
                        <option value="BANK_TRANSFER">Virement bancaire</option>
                    </select>
                </div>

                <div class="total-calculator">
                    <h3>💰 Montant Total</h3>
                    <div class="total-amount" id="totalAmount">${hotel.pricePerNight} €</div>
                    <p style="margin-top: 10px; opacity: 0.9;" id="calculationDetails">
                        <span id="roomCount">1</span> chambre(s) × <span id="nightCount">1</span> nuit(s) × ${hotel.pricePerNight} €
                    </p>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/search/hotels" class="btn btn-secondary">
                        ⬅️ Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ✅ Confirmer la réservation
                    </button>
                </div>
            </form>

            <script>
                const pricePerNight = parseFloat(document.getElementById('reservationForm').getAttribute('data-price'));
                function calculateHotelTotal() {
                    const numberOfRooms = document.getElementById('numberOfRooms').value || 1;
                    const checkIn = document.getElementById('checkIn').value;
                    const checkOut = document.getElementById('checkOut').value;
                    
                    let nights = 1;
                    if (checkIn && checkOut) {
                        const start = new Date(checkIn);
                        const end = new Date(checkOut);
                        nights = Math.max(1, Math.ceil((end - start) / (1000 * 60 * 60 * 24)));
                    }
                    
                    const total = pricePerNight * numberOfRooms * nights;
                    document.getElementById('totalAmount').textContent = total.toFixed(2) + ' €';
                    document.getElementById('roomCount').textContent = numberOfRooms;
                    document.getElementById('nightCount').textContent = nights;
                }
            </script>
        </c:if>

        <!-- FORMULAIRE CIRCUIT -->
        <c:if test="${reservationType == 'CIRCUIT'}">
            <div class="item-details">
                <h3>🗺️ Détails du Circuit</h3>
                <div class="detail-row">
                    <span class="detail-label">Nom :</span>
                    <span class="detail-value"><strong>${circuit.name}</strong></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Destination :</span>
                    <span class="detail-value">${circuit.destination.name}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Durée :</span>
                    <span class="detail-value">${circuit.durationDays} jours</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Dates :</span>
                    <span class="detail-value">
                        ${circuit.startDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy'))} 
                        → 
                        ${circuit.endDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy'))}
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Places disponibles :</span>
                    <span class="detail-value">${circuit.maxParticipants - circuit.currentParticipants} places</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Prix par personne :</span>
                    <span class="detail-value price-highlight">${circuit.price} €</span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/reservation/confirm" method="post" id="reservationForm" data-price="${circuit.price}">
                <input type="hidden" name="type" value="CIRCUIT">
                <input type="hidden" name="circuitId" value="${circuit.id}">

                <div class="form-group">
                    <label for="numberOfPeople">👥 Nombre de participants *</label>
                    <input type="number" id="numberOfPeople" name="numberOfPeople" 
                           min="1" max="${circuit.maxParticipants - circuit.currentParticipants}" value="1" required
                           onchange="calculateCircuitTotal()">
                    <p class="help-text">Maximum ${circuit.maxParticipants - circuit.currentParticipants} places disponibles</p>
                </div>

                <div class="form-group">
                    <label for="paymentMethod">💳 Méthode de paiement *</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="">-- Choisir --</option>
                        <option value="CREDIT_CARD">Carte de crédit</option>
                        <option value="PAYPAL">PayPal</option>
                        <option value="BANK_TRANSFER">Virement bancaire</option>
                    </select>
                </div>

                <div class="total-calculator">
                    <h3>💰 Montant Total</h3>
                    <div class="total-amount" id="totalAmount">${circuit.price} €</div>
                    <p style="margin-top: 10px; opacity: 0.9;">
                        <span id="peopleCount">1</span> personne(s) × ${circuit.price} €
                    </p>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/search/circuits" class="btn btn-secondary">
                        ⬅️ Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ✅ Confirmer la réservation
                    </button>
                </div>
            </form>

            <script>
                const circuitPrice = parseFloat(document.getElementById('reservationForm').getAttribute('data-price'));
                function calculateCircuitTotal() {
                    const numberOfPeople = document.getElementById('numberOfPeople').value || 1;
                    const total = circuitPrice * numberOfPeople;
                    document.getElementById('totalAmount').textContent = total.toFixed(2) + ' €';
                    document.getElementById('peopleCount').textContent = numberOfPeople;
                }
            </script>
        </c:if>
    </div>
</body>
</html>
