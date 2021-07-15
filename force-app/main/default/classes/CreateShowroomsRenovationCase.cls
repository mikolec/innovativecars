/**
 * @description       : 
 * @author            : Mikołaj Lechtański
 * @last modified on  : 15.07.2021
**/
public with sharing class CreateShowroomsRenovationCase implements Queueable {
  List<Showroom__c> showrooms = new List<Showroom__c>();
  List<Case> cases = new List<Case>();

  public CreateShowroomsRenovationCase(List<Showroom__c> showrooms) {
    this.showrooms = showrooms;
  }

  public void execute(QueueableContext context) {
    for (Showroom__c showroom : showrooms) {
      // perform other processing or callout
      Case newRenovationCase = new Case(
        Status = 'New', 
        Origin = 'Inner', 
        Subject = 'Renovation Case: ' + showroom.Name, 
        Description = 'Renowacja w salonie: ' + showroom.Name + ' (' + showroom.Id + ').', 
        Showroom__c = showroom.Id
      );
    
      cases.add(newRenovationCase);
      
      RenovationCaseRequest requestJob = new RenovationCaseRequest(newRenovationCase);
      ID jobId = System.enqueueJob(requestJob);
    }
    insert cases;
  }
}