/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description Test class for testing CleanTelemetryData. This methods removes telemetry results every 5 minutes.
 **/
@isTest
private class ScheduleTelemetryDataCleanTest {
  
  // CRON: At 02:00, on day 1 of the month" 
  // public static final String CRON_EXP = '0 0 2 1 * ? *';
  // CRON: Every 5 minutes every day" 
  public static final String CRON_EXP = '0 */5 * ? * *';
  
  /**
  * @description main test method for ScheduleTelemetryDataClean class
  * @return testmethod 
  **/
  @isTest
  static void testScheduledJob() {
    // Create some telemetry data
    List<Telemetry__c> telemetries = new List<Telemetry__c>();

    Vehicle__c vehicle = TestHelpers.createTestVehicle();

    for (Integer i=0; i<100; i++) {
      Integer randomNumber = Integer.valueof((Math.random() * 10));
      Decimal tempValue = randomNumber + 30;
      Boolean norm = Math.mod(randomNumber, 2) == 0 ? true : false;
      Telemetry__c telemetry = new Telemetry__c(
        Vehicle__c = vehicle.Id,
        Type__c = Constants.T_TELEMETRY_TYPE_TEMPERATURE,
        Value__c = tempValue,
        Norm__c = norm
      );
      telemetries.add(telemetry);
    }
    insert telemetries;

    Test.startTest();
      ScheduleTelemetryDataClean telemetryBatchDataRemoval = new ScheduleTelemetryDataClean();
      String jobId = System.schedule('ScheduledApexTest',
        CRON_EXP,
        telemetryBatchDataRemoval);
      
      List<Telemetry__c> testTelemetries = [SELECT Id
        FROM Telemetry__c
        WHERE Type__c = :Constants.T_TELEMETRY_TYPE_TEMPERATURE];
      System.assertEquals(100, testTelemetries.size(), 'Telemetry data were not created.');
    Test.stopTest();

    testTelemetries = [SELECT Id
      FROM Telemetry__c
      WHERE Type__c = :Constants.T_TELEMETRY_TYPE_TEMPERATURE];
    System.assertEquals(0, testTelemetries.size(), 'Telemetry data were not removed.');

  }
}
