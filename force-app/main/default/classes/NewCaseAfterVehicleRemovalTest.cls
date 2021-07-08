@isTest
private with sharing class NewCaseAfterVehicleRemovalTest {
	@isTest
    static void createVehicleandRemove() {
       Vehicle__c v = new Vehicle__c(Brand__c='Tesla', 
                                     Model__c='Model T', 
                                     Name='1234567890', 
                                     State__c='Nowy');
        insert v;
        delete v;

        System.assertEquals(1, [ SELECT count() 
                                   FROM Case 
                                  WHERE Subject = 'Sprawdzenie utylizacji pojazdu']);    
    }
}
