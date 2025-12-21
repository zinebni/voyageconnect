package com.voyageconnect.controller;

import com.voyageconnect.model.*;
import com.voyageconnect.service.SearchService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Servlet MVC pour l'affichage des pages de recherche (HTML/JSP)
 * Routes : /search/flights, /search/hotels, /search/circuits
 * 
 * Cette servlet affiche des JSP (vues HTML).
 * Pour l'API JSON, voir SearchServlet (/api/search/*)
 */
public class SearchViewController extends HttpServlet {

    private final SearchService searchService = new SearchService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "flights":
                showFlightsPage(request, response);
                break;
            case "hotels":
                showHotelsPage(request, response);
                break;
            case "circuits":
                showCircuitsPage(request, response);
                break;
            case "destinations":
                showDestinationsPage(request, response);
                break;
            default:
                showSearchHomePage(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Extrait l'action depuis l'URL
     */
    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "home";
        }
        return pathInfo.substring(1);
    }

    /**
     * Page d'accueil de recherche
     */
    private void showSearchHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Destination> destinations = searchService.getActiveDestinations();
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/search/index.jsp").forward(request, response);
    }

    /**
     * Page de recherche de vols
     */
    private void showFlightsPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Récupérer les paramètres de recherche
        Long destinationId = getParameterAsLong(request, "destinationId");
        String departureCity = request.getParameter("departureCity");
        String departureDateStr = request.getParameter("departureDate");
        Integer passengers = getParameterAsInt(request, "passengers");
        BigDecimal maxPrice = getParameterAsBigDecimal(request, "maxPrice");
        
        LocalDateTime departureDate = null;
        if (departureDateStr != null && !departureDateStr.isEmpty()) {
            try {
                departureDate = LocalDate.parse(departureDateStr, DateTimeFormatter.ISO_DATE).atStartOfDay();
            } catch (Exception e) {
                request.setAttribute("error", "Format de date invalide");
            }
        }
        
        // Recherche des vols
        List<Flight> flights = searchService.searchFlights(
                destinationId, departureCity, departureDate, passengers, maxPrice);
        
        // Charger aussi les destinations pour le formulaire
        List<Destination> destinations = searchService.getActiveDestinations();
        
        // Passer les résultats à la JSP
        request.setAttribute("flights", flights);
        request.setAttribute("destinations", destinations);
        request.setAttribute("selectedDestinationId", destinationId);
        request.setAttribute("departureCity", departureCity);
        request.setAttribute("departureDate", departureDateStr);
        request.setAttribute("passengers", passengers);
        request.setAttribute("maxPrice", maxPrice);
        
        request.getRequestDispatcher("/WEB-INF/views/search/flights.jsp").forward(request, response);
    }

    /**
     * Page de recherche d'hôtels
     */
    private void showHotelsPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long destinationId = getParameterAsLong(request, "destinationId");
        Integer minStars = getParameterAsInt(request, "minStars");
        BigDecimal maxPrice = getParameterAsBigDecimal(request, "maxPrice");
        Integer rooms = getParameterAsInt(request, "rooms");
        
        List<Hotel> hotels = searchService.searchHotels(
                destinationId, minStars, maxPrice, rooms);
        
        List<Destination> destinations = searchService.getActiveDestinations();
        
        request.setAttribute("hotels", hotels);
        request.setAttribute("destinations", destinations);
        request.setAttribute("selectedDestinationId", destinationId);
        request.setAttribute("minStars", minStars);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("rooms", rooms);
        
        request.getRequestDispatcher("/WEB-INF/views/search/hotels.jsp").forward(request, response);
    }

    /**
     * Page de recherche de circuits
     */
    private void showCircuitsPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long destinationId = getParameterAsLong(request, "destinationId");
        Integer minDuration = getParameterAsInt(request, "minDuration");
        Integer maxDuration = getParameterAsInt(request, "maxDuration");
        BigDecimal maxPrice = getParameterAsBigDecimal(request, "maxPrice");
        Integer participants = getParameterAsInt(request, "participants");
        
        List<Circuit> circuits = searchService.searchCircuits(
                destinationId, minDuration, maxDuration, maxPrice, participants);
        
        List<Destination> destinations = searchService.getActiveDestinations();
        
        request.setAttribute("circuits", circuits);
        request.setAttribute("destinations", destinations);
        request.setAttribute("selectedDestinationId", destinationId);
        request.setAttribute("minDuration", minDuration);
        request.setAttribute("maxDuration", maxDuration);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("participants", participants);
        
        request.getRequestDispatcher("/WEB-INF/views/search/circuits.jsp").forward(request, response);
    }

    /**
     * Page d'affichage des destinations
     */
    private void showDestinationsPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Destination> destinations = searchService.getActiveDestinations();
        request.setAttribute("destinations", destinations);
        
        request.getRequestDispatcher("/WEB-INF/views/search/destinations.jsp").forward(request, response);
    }

    // Méthodes utilitaires
    
    private Long getParameterAsLong(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.isEmpty()) {
            try {
                return Long.parseLong(value);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }

    private Integer getParameterAsInt(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.isEmpty()) {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }

    private BigDecimal getParameterAsBigDecimal(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.isEmpty()) {
            try {
                return new BigDecimal(value);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }

    private Boolean getParameterAsBoolean(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value != null && !value.isEmpty()) {
            return Boolean.parseBoolean(value);
        }
        return null;
    }
}
