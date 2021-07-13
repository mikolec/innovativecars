/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 07.07.2021 
 * @description Test class checking NewOfferConsistencyCheck trigger
**/
@isTest
private class NewOfferConsistencyCheckTest {
	@isTest 
  static void insertOfferVehiclePresent() {
    
    List<Showroom__c> showrooms = TestHelpers.createTestShowrooms(2);
    Showroom__c showroom1 = showrooms[0];
    Showroom__c showroom2 = showrooms[1];
    Vehicle__c vehicle = TestHelpers.createTestVehicle();

    Offer__c offer = new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom1.Id, Present__c = True);
    insert offer;
        
    Test.startTest();
      Offer__c testOffer = new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom2.Id, Present__c = True);
      Database.SaveResult result = Database.insert(testOffer, false);
    Test.stopTest();
        
    System.assert(!result.isSuccess());
    System.assertEquals(Constants.VEHICLE_AVAILABLE_ERROR_MSG + ' ' + showroom1.Name, result.getErrors()[0].getMessage());
  }

  @isTest 
  static void insertOfferVehicleNotPresent() {
    
    List<Showroom__c> showrooms = TestHelpers.createTestShowrooms(2);
    Showroom__c showroom1 = showrooms[0];
    Showroom__c showroom2 = showrooms[1];
    Vehicle__c vehicle = TestHelpers.createTestVehicle();

    Offer__c offer = new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom1.Id, Present__c = False);
    insert offer;
        
    Test.startTest();
      Offer__c testOffer = new Offer__c(Vehicle__c = vehicle.Id, Showroom__c = showroom2.Id, Present__c = True);
      Database.SaveResult result = Database.insert(testOffer, false);
    Test.stopTest();
        
    System.assert(result.isSuccess());
  }

	@isTest 
  static void insert2Offers() {
    
    List<Showroom__c> showrooms = TestHelpers.createTestShowrooms(2);
    Showroom__c showroom1 = showrooms[0];
    Showroom__c showroom2 = showrooms[1];
    List<Vehicle__c> vehicles = TestHelpers.createTestVehicles(2);
    Vehicle__c vehicle1 = vehicles[0];
    Vehicle__c vehicle2 = vehicles[1];

    Offer__c offer = new Offer__c(Vehicle__c = vehicle1.Id, Showroom__c = showroom1.Id, Present__c = True);
    insert offer;
    
    List<Offer__c> testOffers = new List<Offer__c>();
    testOffers.add(new Offer__c(Vehicle__c = vehicle1.Id, Showroom__c = showroom2.Id, Present__c = False));
    testOffers.add(new Offer__c(Vehicle__c = vehicle2.Id, Showroom__c = showroom1.Id, Present__c = True));
   
    Test.startTest();
      Database.SaveResult[] results = Database.insert(testOffers, false);
    Test.stopTest();
        
    System.assert(results[0].isSuccess());
    System.assert(results[1].isSuccess());
  }

	@isTest 
  static void insert2OffersVehiclePresent() {
    
    List<Showroom__c> showrooms = TestHelpers.createTestShowrooms(2);
    Showroom__c showroom1 = showrooms[0];
    Showroom__c showroom2 = showrooms[1];
    List<Vehicle__c> vehicles = TestHelpers.createTestVehicles(2);
    Vehicle__c vehicle1 = vehicles[0];
    Vehicle__c vehicle2 = vehicles[1];

    List<Offer__c> offers = new List<Offer__c>();
    offers.add(new Offer__c(Vehicle__c = vehicle1.Id, Showroom__c = showroom1.Id, Present__c = True));
    offers.add(new Offer__c(Vehicle__c = vehicle2.Id, Showroom__c = showroom2.Id, Present__c = True));
    insert offers;
    
    List<Offer__c> testOffers = new List<Offer__c>();
    testOffers.add(new Offer__c(Vehicle__c = vehicle1.Id, Showroom__c = showroom2.Id, Present__c = True));
    testOffers.add(new Offer__c(Vehicle__c = vehicle2.Id, Showroom__c = showroom1.Id, Present__c = True));
   
    Test.startTest();
      Database.SaveResult[] results = Database.insert(testOffers, false);
    Test.stopTest();
    
    System.assert(!results[0].isSuccess());
    System.assert(!results[1].isSuccess());
    System.assertEquals(Constants.VEHICLE_AVAILABLE_ERROR_MSG + ' ' + showroom1.Name, results[0].getErrors()[0].getMessage());
    System.assertEquals(Constants.VEHICLE_AVAILABLE_ERROR_MSG + ' ' + showroom2.Name, results[1].getErrors()[0].getMessage());

  }

}