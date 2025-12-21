package com.voyageconnect.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import com.voyageconnect.model.*;
import com.voyageconnect.service.SearchService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Servlet pour la recherche de voyages
 * URL : /search/*
 */
public class SearchServlet extends HttpServlet {

    private final SearchService searchService = new SearchService();
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
            .setExclusionStrategies(new HibernateExclusionStrategy())
            .create();
    
    // Adaptateur pour LocalDateTime
    private static class LocalDateTimeAdapter extends TypeAdapter<LocalDateTime> {
        private final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
        
        @Override
        public void write(JsonWriter out, LocalDateTime value) throws IOException {
            if (value == null) {
                out.nullValue();
            } else {
                out.value(value.format(formatter));
            }
        }
        
        @Override
        public LocalDateTime read(JsonReader in) throws IOException {
            return LocalDateTime.parse(in.nextString(), formatter);
        }
    }
    
    // Adaptateur pour LocalDate
    private static class LocalDateAdapter extends TypeAdapter<LocalDate> {
        private final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE;
        
        @Override
        public void write(JsonWriter out, LocalDate value) throws IOException {
            if (value == null) {
                out.nullValue();
            } else {
                out.value(value.format(formatter));
            }
        }
        
        @Override
        public LocalDate read(JsonReader in) throws IOException {
            return LocalDate.parse(in.nextString(), formatter);
        }
    }
    
    // Stratégie d'exclusion pour éviter la sérialisation des collections Hibernate lazy
    private static class HibernateExclusionStrategy implements ExclusionStrategy {
        @Override
        public boolean shouldSkipField(FieldAttributes f) {
            // Ignorer les collections Hibernate non initialisées
            return f.getName().equals("flights") 
                || f.getName().equals("hotels") 
                || f.getName().equals("circuits")
                || f.getName().equals("bookings")
                || f.getName().equals("reviews")
                || f.getName().equals("reservations")
                || f.getName().equals("user");
        }
        
        @Override
        public boolean shouldSkipClass(Class<?> clazz) {
            return false;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "flights":
                searchFlights(request, response);
                break;
            case "hotels":
                searchHotels(request, response);
                break;
            case "circuits":
                searchCircuits(request, response);
                break;
            case "destinations":
                getDestinations(request, response);
                break;
            case "all":
                searchAll(request, response);
                break;
            default:
                showSearchPage(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Affiche la page de recherche
     */
    private void showSearchPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Destination> destinations = searchService.getActiveDestinations();
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/search/index.jsp").forward(request, response);
    }

    /**
     * Recherche de vols (retourne JSON pour AJAX)
     */
    private void searchFlights(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        Long destinationId = getParameterAsLong(request, "destinationId");
        String departureCity = request.getParameter("departureCity");
        String departureDateStr = request.getParameter("departureDate");
        Integer passengers = getParameterAsInt(request, "passengers");
        BigDecimal maxPrice = getParameterAsBigDecimal(request, "maxPrice");
        
        LocalDateTime departureDate = null;
        if (departureDateStr != null && !departureDateStr.isEmpty()) {
            departureDate = LocalDateTime.parse(departureDateStr, DateTimeFormatter.ISO_DATE_TIME);
        }
        
        List<Flight> flights = searchService.searchFlights(
                destinationId, departureCity, departureDate, passengers, maxPrice);
        
        sendJsonResponse(response, flights);
    }

    /**
     * Recherche d'hôtels (retourne JSON pour AJAX)
     */
    private void searchHotels(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        Long destinationId = getParameterAsLong(request, "destinationId");
        Integer minStars = getParameterAsInt(request, "minStars");
        BigDecimal maxPrice = getParameterAsBigDecimal(request, "maxPrice");
        Integer rooms = getParameterAsInt(request, "rooms");
        
        List<Hotel> hotels = searchService.searchHotels(destinationId, minStars, maxPrice, rooms);
        
        sendJsonResponse(response, hotels);
    }

    /**
     * Recherche de circuits (retourne JSON pour AJAX)
     */
    private void searchCircuits(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        Long destinationId = getParameterAsLong(request, "destinationId");
        Integer minDuration = getParameterAsInt(request, "minDuration");
        Integer maxDuration = getParameterAsInt(request, "maxDuration");
        BigDecimal maxPrice = getParameterAsBigDecimal(request, "maxPrice");
        Integer persons = getParameterAsInt(request, "persons");
        
        List<Circuit> circuits = searchService.searchCircuits(
                destinationId, minDuration, maxDuration, maxPrice, persons);
        
        sendJsonResponse(response, circuits);
    }

    /**
     * Récupère toutes les destinations
     */
    private void getDestinations(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        List<Destination> destinations = searchService.getActiveDestinations();
        sendJsonResponse(response, destinations);
    }

    /**
     * Recherche globale
     */
    private void searchAll(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        String destination = request.getParameter("destination");
        BigDecimal maxBudget = getParameterAsBigDecimal(request, "budget");
        Integer persons = getParameterAsInt(request, "persons");
        
        SearchService.SearchResults results = searchService.searchAll(destination, maxBudget, persons);
        
        sendJsonResponse(response, results);
    }

    /**
     * Envoie une réponse JSON
     */
    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(data));
        out.flush();
    }

    /**
     * Extrait l'action de l'URL
     */
    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "index";
        }
        return pathInfo.substring(1);
    }

    /**
     * Convertit un paramètre en Long
     */
    private Long getParameterAsLong(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value == null || value.isEmpty()) {
            return null;
        }
        try {
            return Long.parseLong(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /**
     * Convertit un paramètre en Integer
     */
    private Integer getParameterAsInt(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value == null || value.isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /**
     * Convertit un paramètre en BigDecimal
     */
    private BigDecimal getParameterAsBigDecimal(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        if (value == null || value.isEmpty()) {
            return null;
        }
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
