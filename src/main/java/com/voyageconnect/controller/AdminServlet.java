package com.voyageconnect.controller;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Servlet pour l'administration
 * URL : /admin/*
 * Accessible uniquement aux utilisateurs avec le rôle ADMIN
 */
public class AdminServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "destinations":
                listDestinations(request, response);
                break;
            case "flights":
                listFlights(request, response);
                break;
            case "hotels":
                listHotels(request, response);
                break;
            case "circuits":
                listCircuits(request, response);
                break;
            case "promotions":
                listPromotions(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathAction = getAction(request);
        String formAction = request.getParameter("action");
        
        // Handle form actions based on path
        switch (pathAction) {
            case "destinations":
                handleDestinationAction(request, response, formAction);
                break;
            case "flights":
                handleFlightAction(request, response, formAction);
                break;
            case "hotels":
                handleHotelAction(request, response, formAction);
                break;
            case "circuits":
                handleCircuitAction(request, response, formAction);
                break;
            case "create-destination":
                createDestination(request, response);
                break;
            case "create-flight":
                createFlight(request, response);
                break;
            case "create-hotel":
                createHotel(request, response);
                break;
            case "create-circuit":
                createCircuit(request, response);
                break;
            case "create-promotion":
                createPromotion(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }
    
    private void handleDestinationAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        if ("create".equals(action)) {
            createDestination(request, response);
        } else if ("delete".equals(action)) {
            deleteDestination(request, response);
        } else {
            listDestinations(request, response);
        }
    }
    
    private void handleFlightAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        if ("create".equals(action)) {
            createFlight(request, response);
        } else if ("delete".equals(action)) {
            deleteFlight(request, response);
        } else {
            listFlights(request, response);
        }
    }
    
    private void handleHotelAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        if ("create".equals(action)) {
            createHotel(request, response);
        } else if ("delete".equals(action)) {
            deleteHotel(request, response);
        } else {
            listHotels(request, response);
        }
    }
    
    private void handleCircuitAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        if ("create".equals(action)) {
            createCircuit(request, response);
        } else if ("delete".equals(action)) {
            deleteCircuit(request, response);
        } else {
            listCircuits(request, response);
        }
    }

    /**
     * Affiche le tableau de bord administrateur
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    /**
     * Liste les destinations
     */
    private void listDestinations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Destination> destinations = adminService.getAllDestinations();
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/admin/destinations.jsp").forward(request, response);
    }

    /**
     * Liste les vols
     */
    private void listFlights(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Flight> flights = adminService.getAllFlights();
        List<Destination> destinations = adminService.getAllDestinations();
        request.setAttribute("flights", flights);
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/admin/flights.jsp").forward(request, response);
    }

    /**
     * Liste les hôtels
     */
    private void listHotels(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Hotel> hotels = adminService.getAllHotels();
        List<Destination> destinations = adminService.getAllDestinations();
        request.setAttribute("hotels", hotels);
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/admin/hotels.jsp").forward(request, response);
    }

    /**
     * Liste les circuits
     */
    private void listCircuits(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Circuit> circuits = adminService.getAllCircuits();
        List<Destination> destinations = adminService.getAllDestinations();
        request.setAttribute("circuits", circuits);
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/admin/circuits.jsp").forward(request, response);
    }

    /**
     * Liste les promotions
     */
    private void listPromotions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Promotion> promotions = adminService.getAllPromotions();
        request.setAttribute("promotions", promotions);
        request.getRequestDispatcher("/WEB-INF/views/admin/promotions.jsp").forward(request, response);
    }

    /**
     * Crée une destination
     */
    private void createDestination(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String country = request.getParameter("country");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        
        try {
            Destination destination = new Destination(name, country, description);
            destination.setImageUrl(imageUrl);
            
            adminService.createDestination(destination);
            
            request.setAttribute("success", "Destination créée avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/destinations");
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            listDestinations(request, response);
        }
    }

    /**
     * Crée un vol
     */
    private void createFlight(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String flightNumber = request.getParameter("flightNumber");
            String airline = request.getParameter("airline");
            String departureCity = request.getParameter("departureCity");
            Long destinationId = Long.parseLong(request.getParameter("destinationId"));
            LocalDateTime departureDate = LocalDateTime.parse(request.getParameter("departureDate"));
            LocalDateTime arrivalDate = LocalDateTime.parse(request.getParameter("arrivalDate"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
            String flightClass = request.getParameter("flightClass");
            
            Destination destination = adminService.getDestinationById(destinationId);
            
            Flight flight = new Flight();
            flight.setFlightNumber(flightNumber);
            flight.setAirline(airline);
            flight.setDepartureCity(departureCity);
            flight.setDestination(destination);
            flight.setDepartureDate(departureDate);
            flight.setArrivalDate(arrivalDate);
            flight.setPrice(price);
            flight.setTotalSeats(totalSeats);
            flight.setAvailableSeats(totalSeats);
            flight.setFlightClass(FlightClass.valueOf(flightClass));
            flight.setActive(true);
            
            adminService.createFlight(flight);
            
            request.getSession().setAttribute("success", "Vol créé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/flights");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la création du vol: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/flights");
        }
    }

    /**
     * Crée un hôtel
     */
    private void createHotel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            Long destinationId = Long.parseLong(request.getParameter("destinationId"));
            int stars = Integer.parseInt(request.getParameter("stars"));
            BigDecimal pricePerNight = new BigDecimal(request.getParameter("pricePerNight"));
            int totalRooms = Integer.parseInt(request.getParameter("totalRooms"));
            String address = request.getParameter("address");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            boolean wifi = "true".equals(request.getParameter("wifi"));
            boolean pool = "true".equals(request.getParameter("pool"));
            boolean restaurant = "true".equals(request.getParameter("restaurant"));
            boolean parking = "true".equals(request.getParameter("parking"));
            
            Destination destination = adminService.getDestinationById(destinationId);
            
            Hotel hotel = new Hotel();
            hotel.setName(name);
            hotel.setDestination(destination);
            hotel.setStars(stars);
            hotel.setPricePerNight(pricePerNight);
            hotel.setTotalRooms(totalRooms);
            hotel.setAvailableRooms(totalRooms);
            hotel.setAddress(address);
            hotel.setDescription(description);
            hotel.setImageUrl(imageUrl);
            hotel.setWifi(wifi);
            hotel.setPool(pool);
            hotel.setRestaurant(restaurant);
            hotel.setParking(parking);
            hotel.setActive(true);
            
            adminService.createHotel(hotel);
            
            request.getSession().setAttribute("success", "Hôtel créé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/hotels");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la création de l'hôtel: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/hotels");
        }
    }

    /**
     * Crée un circuit
     */
    private void createCircuit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            Long destinationId = Long.parseLong(request.getParameter("destinationId"));
            int durationDays = Integer.parseInt(request.getParameter("durationDays"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
            int totalSpots = Integer.parseInt(request.getParameter("totalSpots"));
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            String included = request.getParameter("included");
            String excluded = request.getParameter("excluded");
            
            Destination destination = adminService.getDestinationById(destinationId);
            
            Circuit circuit = new Circuit();
            circuit.setName(name);
            circuit.setDestination(destination);
            circuit.setDurationDays(durationDays);
            circuit.setPrice(price);
            circuit.setStartDate(startDate);
            circuit.setEndDate(endDate);
            circuit.setTotalSpots(totalSpots);
            circuit.setAvailableSpots(totalSpots);
            circuit.setDescription(description);
            circuit.setImageUrl(imageUrl);
            circuit.setIncluded(included);
            circuit.setExcluded(excluded);
            circuit.setActive(true);
            
            adminService.createCircuit(circuit);
            
            request.getSession().setAttribute("success", "Circuit créé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/circuits");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la création du circuit: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/circuits");
        }
    }
    
    /**
     * Supprime une destination
     */
    private void deleteDestination(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            adminService.deleteDestination(id);
            request.getSession().setAttribute("success", "Destination supprimée avec succès");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/destinations");
    }
    
    /**
     * Supprime un vol
     */
    private void deleteFlight(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            adminService.deleteFlight(id);
            request.getSession().setAttribute("success", "Vol supprimé avec succès");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/flights");
    }
    
    /**
     * Supprime un hôtel
     */
    private void deleteHotel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            adminService.deleteHotel(id);
            request.getSession().setAttribute("success", "Hôtel supprimé avec succès");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/hotels");
    }
    
    /**
     * Supprime un circuit
     */
    private void deleteCircuit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            adminService.deleteCircuit(id);
            request.getSession().setAttribute("success", "Circuit supprimé avec succès");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/circuits");
    }

    /**
     * Crée une promotion
     */
    private void createPromotion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
        
        try {
            Promotion promotion = new Promotion(code, description, discountPercentage, startDate, endDate);
            adminService.createPromotion(promotion);
            
            request.setAttribute("success", "Promotion créée avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            listPromotions(request, response);
        }
    }

    /**
     * Extrait l'action de l'URL
     * Pour /admin/hotels -> retourne "hotels"
     * Pour /admin/destinations -> retourne "destinations"
     */
    private String getAction(HttpServletRequest request) {
        // getServletPath() retourne /admin/hotels pour le mapping exact
        String servletPath = request.getServletPath();
        if (servletPath != null && servletPath.startsWith("/admin/")) {
            String action = servletPath.substring(7); // Enlever "/admin/"
            if (!action.isEmpty()) {
                return action;
            }
        }
        
        // Fallback sur pathInfo pour le pattern wildcard /admin/*
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && !pathInfo.equals("/")) {
            return pathInfo.substring(1);
        }
        
        return "dashboard";
    }
}
