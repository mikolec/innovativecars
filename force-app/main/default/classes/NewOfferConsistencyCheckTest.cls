@isTest
private class NewOfferConsistencyCheckTest {
	@isTest 
  static void insertVehiclePresent() {
    
    Account acc = new Account(Name = 'Firma Testowa');
    insert acc;
    
    String showRoomName = 'Salon Testowy';
    Showroom__c showroom = new Showroom__c(Name = showRoomName, Account__c = acc.Id);
    insert showroom;
    
    Vehicle__c vehicle = new Vehicle__c(Name = '00001', Brand__c = 'Tesla', Model__c = 'S');
    insert vehicle;
    
    Offer__c offer = new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom.Id, Present__c = True);
    insert offer;
        
    Test.startTest();
    Offer__c testOffer = new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom.Id, Present__c = True);
    Database.SaveResult result = Database.insert(testOffer, false);
    Test.stopTest();
        
    System.assert(!result.isSuccess());
    System.assertEquals('Pojazd jez juz dostępny w salonie ' + showRoomName, result.getErrors()[0].getMessage());
  }
}