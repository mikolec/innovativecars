/**
 * @description       : Class containing helper methods esed in various test methods
 * @author            : Mikołaj Lechtański
 * @last modified on  : 13.07.2021
**/

public with sharing class TestHelpers {
  static final String T_ACCOUNT_NAME = 'Konto testowe';
  static final String T_SHOWROOM_NAME = 'Salon testowy';
  static final String T_VEHICLE_BRAND = 'Tesla';
  static final String T_VEHICLE_MODEL = 'Model testowy';
  static final String T_VEHICLE_NAME_PREFIX = '90000';

  /**
  * @description Creates a number of test accounts
  * @param Integer count (number of account to create)
  * @return List<Account> 
  **/
  public static List<Account> createTestAccounts(Integer count) {
    List<Account> accs = new List<Account>();
    for (Integer i = 0; i < count; i++) {
      accs.add(new Account(Name = T_ACCOUNT_NAME + (i+1)));
    }
    insert accs;
    return accs;
  }

  /**
  * @description Creates 1 test account
  * @return Account 
  **/
  public static Account createTestAccount() {
    return createTestAccounts(1)[0];
  }

  /**
  * @description Creates a number of test showrooms
  * @param Integer count (number of showrooms to create)
  * @return List<Showroom__c> 
  **/
  public static List<Showroom__c> createTestShowrooms(Integer count) {
    List<Showroom__c> showrooms = new List<Showroom__c>();
    Account acc = createTestAccount();
    for (Integer i = 0; i < count; i++) {
      showrooms.add(new Showroom__c(Name = T_SHOWROOM_NAME + (i+1), Account__c = acc.Id));
    }
    insert showrooms;
    return showrooms;
  }

  /**
  * @description Creates 1 test showroom record
  * @return Showroom__c 
  **/
  public static Showroom__c createTestShowroom() {
    return createTestShowrooms(1)[0];
  }

  /**
  * @description Creates a number of test vehicles
  * @param Integer count (number of vehicles to create)
  * @return List<Vehicle__c> 
  **/
  public static List<Vehicle__c> createTestVehicles(Integer count) {
    List<Vehicle__c> vehicles = new List<Vehicle__c>();
 
    for (Integer i = 0; i < count; i++) {
      vehicles.add(
        new Vehicle__c(
          Brand__c = T_VEHICLE_BRAND, 
          Model__c = T_VEHICLE_MODEL + (i + 1), 
          Name = T_VEHICLE_NAME_PREFIX + (i + 1), 
          State__c = 'Nowy'
        )
      );
    }
    insert vehicles;
    return vehicles;
  }

  /**
  * @description Creates 1 test vehicle record
  * @return Vehicle__c 
  **/
  public static Vehicle__c createTestVehicle() {
    return createTestvehicles(1)[0];
  }

  /**
  * @description Creates a vehicle with a number of test telemetry records
  * @param Integer teleCount (number of telemetries to create for the vehicle)
  * @return Vehicle__c 
  **/
  public static Vehicle__c createTestVehicleWithTelemetries(Integer teleCount) {
    
    Vehicle__c vehicle = createTestVehicle();

    List<Telemetry__c> telemetries = new List<Telemetry__c>();
 
    for (Integer i = 0; i < teleCount; i++) {
      telemetries.add(
        new Telemetry__c(
          Vehicle__c = vehicle.Id,
          Norm__c = True,
          Unit__c = 'tarcza hamulcowa',
          Type__c = 'temperatura',
          Value__c = i * 10
        )
      );
    }
    insert telemetries;

    return vehicle;
  }

  /**
  * @description Creates a test vehicle record containing 1 telemetry record related
  * @return Vehicle__c 
  **/
  public static Vehicle__c createTestVehicleWithTelemtry() {
    return createTestVehicleWithTelemetries(1);
  }

}