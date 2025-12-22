package com.voyageconnect.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Servlet pour afficher la page de succès après une réservation
 * URL : /reservation/success
 */
@WebServlet("/reservation/success")
public class ReservationSuccessServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ReservationSuccessServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("Tentative d'accès sans session - Redirection vers login");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        LOGGER.info("Affichage de la page de succès de réservation");
        request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
    }
}
