trigger NewCaseAfterVehicleRemoval on Vehicle__c (after delete) {
  // System.debug('Removing car... ');
  // System.debug(Trigger.old);
  for(Vehicle__c v : Trigger.old) {
    String description = 'Dane utylizowanego pojazdu: \n'
                      + 'Marka: ' + v.Brand__c + '\n' + 
                      + 'Model: ' + v.Model__c + '\n' + 
                      + 'Nr seryjny: ' + v.Name + '\n';
    // System.debug(description);
    Case c = new Case(Subject = 'Sprawdzenie utylizacji pojazdu',
                     Description = description,
                      Status = 'New',
                      Origin = 'Internal'
                     );
    //insert c;
    Database.SaveResult result = Database.insert(c);
    // System.debug(result);
    
  }
}