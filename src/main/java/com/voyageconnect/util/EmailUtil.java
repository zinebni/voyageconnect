package com.voyageconnect.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Utilitaire pour l'envoi d'emails via JavaMail
 * Configuré avec Brevo SMTP
 */
public class EmailUtil {

    private static final Logger logger = LoggerFactory.getLogger(EmailUtil.class);

    // Configuration SMTP Brevo
    private static final String SMTP_HOST = "smtp-relay.brevo.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "9efae5001@smtp-brevo.com";
    private static final String SMTP_PASSWORD = "xsmtpsib-8b2da85f4aeed6151a759febbcc1c076251f7ccb1ffea18985a72abbe43d9e1f-1z80cW7F9ffA0pkh"; // Remplacez par votre clé API
    private static final String FROM_EMAIL = "ayaettouil4@gmail.com";
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
     * Envoie un email de confirmation de réservation par l'admin
     */
    public static boolean sendAdminReservationConfirmation(String to, String userName, 
                                                           String reservationNumber, 
                                                           String reservationType,
                                                           String details) {
        String subject = "✅ Votre réservation " + reservationNumber + " a été confirmée !";
        String content = buildAdminConfirmationEmail(userName, reservationNumber, reservationType, details);
        return sendEmail(to, subject, content);
    }

    /**
     * Envoie un email d'annulation de réservation par l'admin
     */
    public static boolean sendAdminReservationCancellation(String to, String userName, 
                                                           String reservationNumber,
                                                           String reservationType) {
        String subject = "❌ Votre réservation " + reservationNumber + " a été annulée";
        String content = buildAdminCancellationEmail(userName, reservationNumber, reservationType);
        return sendEmail(to, subject, content);
    }

    /**
     * Construit le contenu HTML de l'email de confirmation par l'admin
     */
    private static String buildAdminConfirmationEmail(String userName, String reservationNumber, 
                                                      String reservationType, String details) {
        String typeLabel = getTypeLabel(reservationType);
        String typeIcon = getTypeIcon(reservationType);
        String typeColor = getTypeColor(reservationType);
        
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6; background-color: #f4f4f4; margin: 0; padding: 20px;'>" +
                "<div style='max-width: 600px; margin: 0 auto; background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);'>" +
                "<div style='background: linear-gradient(135deg, #00aa6c 0%, #008f5a 100%); color: white; padding: 30px; text-align: center;'>" +
                "<h1 style='margin: 0; font-size: 28px;'>✅ Réservation Confirmée</h1>" +
                "<p style='margin: 10px 0 0; opacity: 0.9;'>Votre voyage est en route !</p>" +
                "</div>" +
                "<div style='padding: 30px;'>" +
                "<p style='font-size: 18px; color: #333;'>Bonjour <strong>" + userName + "</strong>,</p>" +
                "<p style='color: #555;'>Bonne nouvelle ! Votre réservation a été <strong style='color: #00aa6c;'>confirmée</strong> par notre équipe.</p>" +
                "<div style='background: #f8f9fa; border-radius: 12px; padding: 20px; margin: 25px 0; border-left: 4px solid " + typeColor + ";'>" +
                "<p style='margin: 0 0 10px; color: #666; font-size: 14px;'>DÉTAILS DE LA RÉSERVATION</p>" +
                "<p style='margin: 5px 0; font-size: 16px;'><strong>N° de réservation:</strong> <span style='color: #003580;'>" + reservationNumber + "</span></p>" +
                "<p style='margin: 5px 0; font-size: 16px;'><strong>Type:</strong> <span style='color: " + typeColor + ";'>" + typeIcon + " " + typeLabel + "</span></p>" +
                "<p style='margin: 5px 0; font-size: 16px;'><strong>Détails:</strong> " + details + "</p>" +
                "</div>" +
                "<p style='color: #555;'>Vous pouvez consulter les détails de votre réservation dans votre espace personnel.</p>" +
                "<div style='text-align: center; margin: 30px 0;'>" +
                "<a href='http://localhost:8080/VoyageConnect/reservation/list' style='display: inline-block; background: linear-gradient(135deg, #003580 0%, #0057b8 100%); color: white; padding: 14px 30px; text-decoration: none; border-radius: 8px; font-weight: bold;'>Voir mes réservations</a>" +
                "</div>" +
                "<p style='color: #888; font-size: 14px;'>Merci de votre confiance !<br><strong>L'équipe VoyageConnect</strong></p>" +
                "</div>" +
                "<div style='background: #f8f9fa; padding: 20px; text-align: center; color: #888; font-size: 12px;'>" +
                "<p style='margin: 0;'>Cet email a été envoyé automatiquement. Merci de ne pas y répondre.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }

    /**
     * Construit le contenu HTML de l'email d'annulation par l'admin
     */
    private static String buildAdminCancellationEmail(String userName, String reservationNumber, 
                                                      String reservationType) {
        String typeLabel = getTypeLabel(reservationType);
        
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6; background-color: #f4f4f4; margin: 0; padding: 20px;'>" +
                "<div style='max-width: 600px; margin: 0 auto; background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);'>" +
                "<div style='background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); color: white; padding: 30px; text-align: center;'>" +
                "<h1 style='margin: 0; font-size: 28px;'>❌ Réservation Annulée</h1>" +
                "<p style='margin: 10px 0 0; opacity: 0.9;'>Information importante</p>" +
                "</div>" +
                "<div style='padding: 30px;'>" +
                "<p style='font-size: 18px; color: #333;'>Bonjour <strong>" + userName + "</strong>,</p>" +
                "<p style='color: #555;'>Nous vous informons que votre réservation a été <strong style='color: #dc3545;'>annulée</strong>.</p>" +
                "<div style='background: #fff3f3; border-radius: 12px; padding: 20px; margin: 25px 0; border-left: 4px solid #dc3545;'>" +
                "<p style='margin: 0 0 10px; color: #666; font-size: 14px;'>RÉSERVATION ANNULÉE</p>" +
                "<p style='margin: 5px 0; font-size: 16px;'><strong>N° de réservation:</strong> <span style='color: #003580;'>" + reservationNumber + "</span></p>" +
                "<p style='margin: 5px 0; font-size: 16px;'><strong>Type:</strong> " + typeLabel + "</p>" +
                "</div>" +
                "<p style='color: #555;'>Si vous avez des questions concernant cette annulation ou si vous souhaitez effectuer une nouvelle réservation, n'hésitez pas à nous contacter.</p>" +
                "<div style='text-align: center; margin: 30px 0;'>" +
                "<a href='http://localhost:8080/VoyageConnect/search' style='display: inline-block; background: linear-gradient(135deg, #003580 0%, #0057b8 100%); color: white; padding: 14px 30px; text-decoration: none; border-radius: 8px; font-weight: bold;'>Faire une nouvelle réservation</a>" +
                "</div>" +
                "<p style='color: #888; font-size: 14px;'>Nous espérons vous revoir bientôt !<br><strong>L'équipe VoyageConnect</strong></p>" +
                "</div>" +
                "<div style='background: #f8f9fa; padding: 20px; text-align: center; color: #888; font-size: 12px;'>" +
                "<p style='margin: 0;'>Cet email a été envoyé automatiquement. Merci de ne pas y répondre.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }

    private static String getTypeLabel(String type) {
        switch (type) {
            case "FLIGHT": return "Vol";
            case "HOTEL": return "Hôtel";
            case "CIRCUIT": return "Circuit";
            case "PACKAGE": return "Package";
            default: return type;
        }
    }

    private static String getTypeIcon(String type) {
        switch (type) {
            case "FLIGHT": return "✈️";
            case "HOTEL": return "🏨";
            case "CIRCUIT": return "🗺️";
            case "PACKAGE": return "📦";
            default: return "📋";
        }
    }

    private static String getTypeColor(String type) {
        switch (type) {
            case "FLIGHT": return "#0071c2";
            case "HOTEL": return "#febb02";
            case "CIRCUIT": return "#dc3545";
            case "PACKAGE": return "#9b59b6";
            default: return "#003580";
        }
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
