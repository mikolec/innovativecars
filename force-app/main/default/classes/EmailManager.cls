/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description Helper methods for sending emails
 **/

public with sharing class EmailManager {
    
    /**
    * @description Public method for sending emails asyncronously
    * @param String address (email address)
    * @param String subject (email subject)
    * @param String body (email body)
    **/
    @future
    public static void sendMailAsync(String address, String subject, String body) {
        // Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        // Pass this email message to the built-in sendEmail method 
        // of the Messaging class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });
        
    }
}
