package com.voyageconnect.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Utilitaire pour l'envoi d'emails via JavaMail
 */
public class EmailUtil {

    private static final Logger logger = LoggerFactory.getLogger(EmailUtil.class);

    // Configuration SMTP (à adapter selon votre serveur)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "voyageconnect@gmail.com";
    private static final String SMTP_PASSWORD = "votre_mot_de_passe_app";
    private static final String FROM_EMAIL = "voyageconnect@gmail.com";
    private static final String FROM_NAME = "VoyageConnect";

    /**
     * Envoie un email
     * @param to Adresse email du destinataire
     * @param subject Sujet de l'email
     * @param content Contenu de l'email (HTML supporté)
     * @return true si l'envoi a réussi, false sinon
     */
    public static boolean sendEmail(String to, String subject, String content) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", SMTP_HOST);

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");

            Transport.send(message);
            logger.info("Email envoyé avec succès à : {}", to);
            return true;

        } catch (Exception e) {
            logger.error("Erreur lors de l'envoi de l'email à : {}", to, e);
            return false;
        }
    }

    /**
     * Envoie un email de confirmation de réservation
     */
    public static boolean sendReservationConfirmation(String to, String userName, 
                                                      String reservationNumber, String details) {
        String subject = "Confirmation de réservation - " + reservationNumber;
        String content = buildReservationConfirmationEmail(userName, reservationNumber, details);
        return sendEmail(to, subject, content);
    }

    /**
     * Envoie un email d'annulation de réservation
     */
    public static boolean sendReservationCancellation(String to, String userName, 
                                                      String reservationNumber) {
        String subject = "Annulation de réservation - " + reservationNumber;
        String content = buildCancellationEmail(userName, reservationNumber);
        return sendEmail(to, subject, content);
    }

    /**
     * Envoie un email de bienvenue
     */
    public static boolean sendWelcomeEmail(String to, String userName) {
        String subject = "Bienvenue sur VoyageConnect !";
        String content = buildWelcomeEmail(userName);
        return sendEmail(to, subject, content);
    }

    /**
     * Construit le contenu HTML de l'email de confirmation
     */
    private static String buildReservationConfirmationEmail(String userName, 
                                                           String reservationNumber, 
                                                           String details) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
                "<h2 style='color: #007bff;'>Confirmation de réservation</h2>" +
                "<p>Bonjour " + userName + ",</p>" +
                "<p>Votre réservation a été confirmée avec succès !</p>" +
                "<div style='background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>" +
                "<p><strong>Numéro de réservation :</strong> " + reservationNumber + "</p>" +
                "<p><strong>Détails :</strong></p>" +
                "<p>" + details + "</p>" +
                "</div>" +
                "<p>Merci de voyager avec VoyageConnect !</p>" +
                "<p style='color: #6c757d; font-size: 12px;'>Cet email a été envoyé automatiquement, merci de ne pas y répondre.</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }

    /**
     * Construit le contenu HTML de l'email d'annulation
     */
    private static String buildCancellationEmail(String userName, String reservationNumber) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
                "<h2 style='color: #dc3545;'>Annulation de réservation</h2>" +
                "<p>Bonjour " + userName + ",</p>" +
                "<p>Votre réservation <strong>" + reservationNumber + "</strong> a été annulée.</p>" +
                "<p>Si vous avez des questions, n'hésitez pas à nous contacter.</p>" +
                "<p>Merci,<br>L'équipe VoyageConnect</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }

    /**
     * Construit le contenu HTML de l'email de bienvenue
     */
    private static String buildWelcomeEmail(String userName) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
                "<h2 style='color: #007bff;'>Bienvenue sur VoyageConnect !</h2>" +
                "<p>Bonjour " + userName + ",</p>" +
                "<p>Merci de vous être inscrit sur VoyageConnect, votre plateforme de voyage en ligne.</p>" +
                "<p>Vous pouvez maintenant :</p>" +
                "<ul>" +
                "<li>Rechercher des vols, hôtels et circuits</li>" +
                "<li>Réserver vos voyages en quelques clics</li>" +
                "<li>Gérer vos réservations</li>" +
                "<li>Laisser des avis</li>" +
                "</ul>" +
                "<p>Bon voyage avec VoyageConnect !</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}
