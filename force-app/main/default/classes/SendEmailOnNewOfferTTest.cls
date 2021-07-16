/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 13.07.2021 
 * @description Test class for SendEmailOnNewOffer method triggering email on new offer send
 **/
@isTest
public with sharing class SendEmailOnNewOfferTTest {
  
  /**
  * @description tst creating two offers and checking trigger SendEmailOnNewOffer
  **/
  @isTest
  static void create2Offers() {

    List<Showroom__c> showrooms = TestHelpers.createTestShowrooms(2);
    Showroom__c showroom1 = showrooms[0];
    Showroom__c showroom2 = showrooms[1];
    Vehicle__c vehicle = TestHelpers.createTestVehicle();

    List<Offer__c> offers = new List<Offer__c>();
    offers.add(new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom1.Id, Present__c = True));
    offers.add(new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom2.Id, Present__c = False));

    Test.startTest();
    Database.SaveResult[] results = Database.insert(offers, false);
    Test.stopTest();

    System.assert(results[0].isSuccess());
    System.assert(results[1].isSuccess());  
  }
}
