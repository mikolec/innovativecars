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
  
  static testmethod void testScheduledJob() {
    // Create some telemetry data
    List<Telemetry__c> telys = new List<Telemetry__c>();

    Vehicle__c vehicle = new Vehicle__c(
      Name = '000000001',
      Brand__c = 'Test',
      Model__c = 'Testowy',
      State__c = 'Nowy',
      Power__c = 100,
      FuelConsumption__c = 1
    );
    insert vehicle;

    for (Integer i=0; i<100; i++) {
      Integer randomNumber = Integer.valueof((Math.random() * 10));
      Decimal tempValue = randomNumber + 30;
      Boolean norm = Math.mod(randomNumber, 2) == 0 ? true : false;
      Telemetry__c t = new Telemetry__c(
        Vehicle__c = vehicle.Id,
        Type__c = 'temperatura',
        Value__c = tempValue,
        Norm__c = norm
      );
      telys.add(t);
    }
    insert telys;

    Test.startTest();
      ScheduleTelemetryDataClean telemetryBatchDataRemoval = new ScheduleTelemetryDataClean();
      String jobId = System.schedule('ScheduledApexTest',
        CRON_EXP,
        telemetryBatchDataRemoval);
      
      List<Telemetry__c> lt = [SELECT Id
        FROM Telemetry__c
        WHERE Type__c = 'temperatura'];
      System.assertEquals(100, lt.size(), 'Telemetry data were not created.');
    Test.stopTest();

    lt = [SELECT Id
      FROM Telemetry__c
      WHERE Type__c = 'temperatura'];
    System.assertEquals(0, lt.size(), 'Telemetry data were not removed.');

  }
}
