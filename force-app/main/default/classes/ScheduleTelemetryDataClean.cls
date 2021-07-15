/**
 * @description       : Clas containing method to clean telemetry Data removing telemetry data. This method can be used from UI
 * @author            : Mikołaj Lechtański
 * @last modified on  : 15.07.2021
**/

public with sharing class ScheduleTelemetryDataClean implements Schedulable {

    /**
    * @description method coming from Schedulable interface to clean the data
    * @param SchedulableContext ctx 
    **/
    public void execute(SchedulableContext ctx) {
        CleanTelemetryData cleanTelemetetryBatchObject = new CleanTelemetryData();
        Id batchId = Database.executeBatch(cleanTelemetetryBatchObject, 100);
    }
  }
  