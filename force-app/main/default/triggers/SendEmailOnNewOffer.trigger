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

  for(Offer__c o : Trigger.new) {
    Vehicle__c v = [SELECT Name, Brand__c, Model__c FROM Vehicle__c WHERE Id = :o.Vehicle__c LIMIT 1][0];
    body += 'Dodano pojazd: ' + v.Brand__c + ' ' + v.Model__c + ' ( ' + v.Name + ' ) ';
    if(o.Showroom__c != '') {
      Showroom__c s = [SELECT Name FROM Showroom__c WHERE Id = :o.Showroom__c LIMIT 1][0];
      body += 'do salonu: ' + s.Name + '.';
    }
    if(o.Present__c) {
      body += ' (dostępny fizycznie w salonie) ';
    } else {
      body += ' (dostępny wirtuanie w salonie) ';
    }
  }
  EmailManager.sendMailAsync(address, subject, body);
}