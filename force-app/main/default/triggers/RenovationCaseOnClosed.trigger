/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 12.07.2021 
 * @description The trigger fires on Showroom Status being set to Closed
 * After trigger is fired new Case is created and HTTP Request is being sent
 **/

 trigger RenovationCaseOnClosed on Showroom__c (after update) {

  List<Case> cases = new List<Case>();

  for(Showroom__c showroom : Trigger.new) {
    if(showroom.Status__c != Trigger.oldMap.get(showroom.Id).Status__c 
      && showroom.Status__c == 'Zamknięty') {
      
      Case newRenovationCase = new Case(Status = 'New', 
        Origin = 'Inner', 
        Subject = 'Renovation Case: ' + showroom.Name, 
        Description = 'Renowacja w salonie: ' + showroom.Name + ' (' + showroom.Id + ').', 
        Showroom__c = showroom.Id);
      cases.add(newRenovationCase);
    }   
  }
  insert cases;

  RenovationCaseRequest requestJob = new RenovationCaseRequest(cases);
  ID jobId = System.enqueueJob(requestJob);

}