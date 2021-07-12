/** 
 * @author Mikołaj Lechtański <mikolaj.lechtanski@accenture.com> 
 * @date 08.07.2021 
 * @description Queuable method that takes cases with status New, sends an Http request 
 * and updates the cases' Status to Completed or Failed depending on req result
 * @params List of Cases with Status set to New
 * @return -
 **/

public with sharing class RenovationCaseRequest implements Queueable, Database.AllowsCallouts {
  
  private List<Case> renCases;
  
  public RenovationCaseRequest(List<Case> renCases) {
    this.renCases = renCases;
  }

  public void execute(QueueableContext context) {

    Http server = new Http();
    HttpRequest req = new HttpRequest();

    String url = 'https://jsonplaceholder.typicode.com/posts';
    req.setEndpoint(url);
    req.setMethod('POST');

    for (Case renCase : renCases) {

      String body = '{\n' + 
        'title: ' + renCase.Subject + ',\n' +
        'body: ' + renCase.Description + ',\n' +
        'caseId: ' + renCase.Id + ',\n' +
      '}';
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
}
