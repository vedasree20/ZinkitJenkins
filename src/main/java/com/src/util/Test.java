package com.src.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Test {

    public static void sendEmail(String to, String subject, String body) {
        final String from = "privateveda200@gmail.com"; // your Gmail
        final String password = "xpkrkayaayypcejj";     // App password

        // SMTP properties for SSL
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.sendgrid.net");
        props.put("mail.smtp.port", "587");



        // Create session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        // Enable debug logs
        session.setDebug(true);

        try {
            // Compose message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "Zinkit Team")); // optional sender name
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body); // for plain text
            // message.setContent(body, "text/html; charset=utf-8"); // use for HTML emails

            // Send message
            Transport.send(message);
            System.out.println("Email sent successfully to " + to);

        } catch (Exception e) {
            System.err.println("Error while sending email:");
            e.printStackTrace();
        }
    }

    // Optional main method to test standalone
    public static void main(String[] args) {
        sendEmail("vedasree2045@gmail.com", "Test Email", "This is a test email from Java.");
    }
}
