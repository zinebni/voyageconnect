package com.voyageconnect.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.voyageconnect.model.PaymentMethod;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.service.ReservationService;

/**
 * URL : /reservation/*
 */
public class ReservationServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ReservationServlet.class.getName());
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = getAction(request);

        switch (action) {
            case "list":
                listReservations(request, response);
                break;
            case "view":
                viewReservation(request, response);
                break;
            case "cancel":
                showCancelConfirmation(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = getAction(request);

        switch (action) {
            case "flight":
                createFlightReservation(request, response);
                break;
            case "hotel":
                createHotelReservation(request, response);
                break;
            case "circuit":
                createCircuitReservation(request, response);
                break;
            case "cancel":
                cancelReservation(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /* ================= ACTIONS ================= */

    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long userId = getUserIdFromSession(request);
        List<Reservation> reservations = reservationService.getUserReservations(userId);

        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/WEB-INF/views/reservation/list.jsp")
               .forward(request, response);
    }

    private void viewReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Reservation reservation = reservationService.getReservationById(id);

            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/view.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservation/list");
        }
    }

    private void showCancelConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Reservation reservation = reservationService.getReservationById(id);

            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/cancel.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservation/list");
        }
    }

    private void cancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Long userId = getUserIdFromSession(request);
            Long reservationId = Long.parseLong(request.getParameter("reservationId"));

            reservationService.cancelReservation(reservationId, userId);

            response.sendRedirect(request.getContextPath() + "/reservation/list?success=1");

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservation/list?error=1");
        }
    }

    private void createFlightReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long userId = getUserIdFromSession(request);
            Long flightId = Long.parseLong(request.getParameter("flightId"));
            Integer people = Integer.parseInt(request.getParameter("numberOfPeople"));
            PaymentMethod pm = PaymentMethod.valueOf(request.getParameter("paymentMethod"));

            Reservation r = reservationService.createFlightReservation(
                    userId, flightId, people, pm);

            request.setAttribute("reservation", r);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp")
                   .forward(request, response);
        }
    }

    private void createHotelReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long userId = getUserIdFromSession(request);
            Long hotelId = Long.parseLong(request.getParameter("hotelId"));
            Integer rooms = Integer.parseInt(request.getParameter("numberOfRooms"));

            LocalDateTime in = LocalDateTime.parse(
                    request.getParameter("checkIn"), DateTimeFormatter.ISO_DATE_TIME);
            LocalDateTime out = LocalDateTime.parse(
                    request.getParameter("checkOut"), DateTimeFormatter.ISO_DATE_TIME);

            PaymentMethod pm = PaymentMethod.valueOf(request.getParameter("paymentMethod"));

            Reservation r = reservationService.createHotelReservation(
                    userId, hotelId, rooms, in, out, pm);

            request.setAttribute("reservation", r);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp")
                   .forward(request, response);
        }
    }

    private void createCircuitReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long userId = getUserIdFromSession(request);
            Long circuitId = Long.parseLong(request.getParameter("circuitId"));
            Integer people = Integer.parseInt(request.getParameter("numberOfPeople"));
            PaymentMethod pm = PaymentMethod.valueOf(request.getParameter("paymentMethod"));

            Reservation r = reservationService.createCircuitReservation(
                    userId, circuitId, people, pm);

            request.setAttribute("reservation", r);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp")
                   .forward(request, response);
        }
    }

    /* ================= UTILS ================= */

    private String getAction(HttpServletRequest request) {
        String path = request.getPathInfo(); // /list /view /cancel

        if (path == null || path.equals("/")) {
            return "list";
        }
        return path.substring(1);
    }

    private boolean isUserLoggedIn(HttpServletRequest request) {
        return getUserIdFromSession(request) != null;
    }

    private Long getUserIdFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (Long) session.getAttribute("userId") : null;
    }
}
