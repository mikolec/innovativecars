/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description The trigger fires creating new Offer
 * After trigger is fired an email is being sent
 **/

trigger SendEmailOnNewOffer on Offer__c (after insert) {
  String address = 'mikolec@gmail.com';
  String subject = 'Pojawily sie nowe oferty';
  String body = 'W systemie pojawily sie nowe oferty: \n';

  for(Offer__c offer : [
    SELECT Vehicle__r.Name, Vehicle__r.Brand__c, Vehicle__r.Model__c, Showroom__r.Name, Present__c, Showroom__c, Vehicle__c
    FROM Offer__c 
    WHERE Id IN :Trigger.new
  ] ) {
    body += String.format('Dodano pojazd: {0} {1} (nr seryjny: {2} )', 
      new String[]{offer.Vehicle__r.Brand__c, offer.Vehicle__r.Model__c, offer.Vehicle__r.Name}
    );

    if(offer.Showroom__c != null) {
      body += 'do salonu: ' + offer.Showroom__r.Name;
    }
    
    if(offer.Present__c) {
      body += ' (dostępny fizycznie w salonie).\n';
    } else {
      body += ' (dostępny wirtuanie w salonie).\n';
    }
  }

  EmailManager.sendMailAsync(address, subject, body);
}