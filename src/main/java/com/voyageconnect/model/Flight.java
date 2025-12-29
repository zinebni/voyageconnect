package com.voyageconnect.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * Entité représentant un vol
 */
@Entity
@Table(name = "flights")
public class Flight implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le numéro de vol est obligatoire")
    @Column(name = "flight_number", nullable = false, unique = true, length = 20)
    private String flightNumber;

    @NotBlank(message = "La ville de départ est obligatoire")
    @Column(name = "departure_city", nullable = false, length = 100)
    private String departureCity;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "destination_id", nullable = false)
    private Destination destination;

    @NotNull(message = "La date de départ est obligatoire")
    @Column(name = "departure_date", nullable = false)
    private LocalDateTime departureDate;

    @NotNull(message = "La date d'arrivée est obligatoire")
    @Column(name = "arrival_date", nullable = false)
    private LocalDateTime arrivalDate;

    @NotBlank(message = "La compagnie aérienne est obligatoire")
    @Column(nullable = false, length = 100)
    private String airline;

    @NotNull(message = "Le prix est obligatoire")
    @DecimalMin(value = "0.0", inclusive = false, message = "Le prix doit être supérieur à 0")
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @NotNull(message = "Le nombre de places est obligatoire")
    @Min(value = 0, message = "Le nombre de places ne peut pas être négatif")
    @Column(name = "available_seats", nullable = false)
    private Integer availableSeats;

    @Column(name = "total_seats", nullable = false)
    private Integer totalSeats;

    @Enumerated(EnumType.STRING)
    @Column(name = "class_type", nullable = false, length = 20)
    private FlightClass flightClass = FlightClass.ECONOMY;

    @Column(nullable = false)
    private Boolean active = true;

    // Champ temporaire pour le formatage de la date dans la JSP
    @Transient
    private String departureDateFormatted;

    @Transient
    private String arrivalDateFormatted;

    @OneToMany(mappedBy = "flight", fetch = FetchType.LAZY)
    private List<Reservation> reservations = new ArrayList<>();

    // Constructeurs
    public Flight() {}

    public Flight(String flightNumber, String departureCity, Destination destination, 
                  LocalDateTime departureDate, LocalDateTime arrivalDate, String airline, 
                  BigDecimal price, Integer totalSeats) {
        this.flightNumber = flightNumber;
        this.departureCity = departureCity;
        this.destination = destination;
        this.departureDate = departureDate;
        this.arrivalDate = arrivalDate;
        this.airline = airline;
        this.price = price;
        this.totalSeats = totalSeats;
        this.availableSeats = totalSeats;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFlightNumber() {
        return flightNumber;
    }

    public void setFlightNumber(String flightNumber) {
        this.flightNumber = flightNumber;
    }

    public String getDepartureCity() {
        return departureCity;
    }

    public void setDepartureCity(String departureCity) {
        this.departureCity = departureCity;
    }

    public Destination getDestination() {
        return destination;
    }

    public void setDestination(Destination destination) {
        this.destination = destination;
    }

    public LocalDateTime getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(LocalDateTime departureDate) {
        this.departureDate = departureDate;
    }

    public LocalDateTime getArrivalDate() {
        return arrivalDate;
    }

    public void setArrivalDate(LocalDateTime arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    public String getAirline() {
        return airline;
    }

    public void setAirline(String airline) {
        this.airline = airline;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(Integer availableSeats) {
        this.availableSeats = availableSeats;
    }

    public Integer getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(Integer totalSeats) {
        this.totalSeats = totalSeats;
    }

    public FlightClass getFlightClass() {
        return flightClass;
    }

    public void setFlightClass(FlightClass flightClass) {
        this.flightClass = flightClass;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
    }

    public boolean isAvailable(int requestedSeats) {
        return active && availableSeats >= requestedSeats;
    }

    //geter et setter pour departureDateFormatted et arrivalDateFormatted
    public String getDepartureDateFormatted() {
        return departureDateFormatted;
    }

    public void setDepartureDateFormatted(String departureDateFormatted) {
        this.departureDateFormatted = departureDateFormatted;
    }

    public String getArrivalDateFormatted() {
        return arrivalDateFormatted;
    }

    public void setArrivalDateFormatted(String arrivalDateFormatted) {
        this.arrivalDateFormatted = arrivalDateFormatted;
    }

    @Override
    public String toString() {
        return "Flight{" +
                "id=" + id +
                ", flightNumber='" + flightNumber + '\'' +
                ", departureCity='" + departureCity + '\'' +
                ", airline='" + airline + '\'' +
                ", price=" + price +
                '}';
    }
}
