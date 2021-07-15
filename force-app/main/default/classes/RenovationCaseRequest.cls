/**
 * @description       : enquable class for sending Renovation Case Request to external service
 * @author            : Mikołaj Lechtański
 * @last modified on  : 15.07.2021
**/
public with sharing class RenovationCaseRequest implements Queueable, Database.AllowsCallouts {
  
  private Case renCase;
  
  /**
  * @description class constructor
  * @param Case renCase 
  **/
  public RenovationCaseRequest(Case renCase) {
    this.renCase = renCase;
  }

  /**
  * @description instance member method to execute job of sending new renovation case request
  * @param QueueableContext context 
  **/
  public void execute(QueueableContext context) {

    Http server = new Http();
    HttpRequest req = new HttpRequest();

    String url = 'https://jsonplaceholder.typicode.com/posts';
    req.setEndpoint(url);
    req.setMethod('POST');

    String[] reqBodyParts = new List<String> {
      '{',
      'title: ' + renCase.Subject + ',',
      'body: ' + renCase.Description + ',',
      'caseId: ' + renCase.Id + ',',
      '}'
    };
    String body = String.join(reqBodyParts, '\n');
    req.setBody(JSON.serialize(body));
    HttpResponse res = server.send(req);

    if(res.getStatusCode() == 201) {
      renCase.Status = 'Closed';
      update renCase;
    } else {
      renCase.Status = 'Failed';
      update renCase;
      System.debug(LoggingLevel.ERROR, 'Błąd połączenia');
    }

  }
}
