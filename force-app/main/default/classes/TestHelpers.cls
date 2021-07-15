/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description The class containing helper methods for testing
 **/

public with sharing class TestHelpers {
  public static List<Account> createTestAccounts(Integer count) {
    List<Account> accs = new List<Account>();
    for(Integer i = 0; i < count; i++) {
      accs.add(new Account(Name = Constants.T_ACCOUNT_NAME + (i+1)));
    }
    insert accs;
    return accs;
  }
  public static Account createTestAccount() {
    return createTestAccounts(1)[0];
  }

  public static List<Showroom__c> createTestShowrooms(Integer count) {
    List<Showroom__c> showrooms = new List<Showroom__c>();
    Account acc = createTestAccount();
    for(Integer i = 0; i < count; i++) {
      showrooms.add(new Showroom__c(Name = Constants.T_SHOWROOM_NAME + (i+1), Account__c = acc.Id));
    }
    insert showrooms;
    return showrooms;
  }
  public static Showroom__c createTestShowroom() {
    return createTestShowrooms(1)[0];
  }
  
  public static List<Vehicle__c> createTestVehicles(Integer count) {
    List<Vehicle__c> vehicles = new List<Vehicle__c>();

    for(Integer i = 0; i < count; i++) {
      vehicles.add(
        new Vehicle__c(
          Brand__c = Constants.T_VEHICLE_BRAND, 
          Model__c = Constants.T_VEHICLE_MODEL + (i + 1), 
          Name = Constants.T_VEHICLE_NAME_PREFIX + (i + 1), 
          State__c = Constants.T_VEHICLE_STATE_NEW
        )
      );
    }
    insert vehicles;
    return vehicles;
  }
  public static Vehicle__c createTestVehicle() {
    return createTestvehicles(1)[0];
  }  

}
