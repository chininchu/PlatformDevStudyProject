// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// string tempvar = 'Enter_your_name_here';
// System.debug('Hello World!');
// System.debug('My name is ' + tempvar);

// String desiredState = 'CA';
// List <Account> caliAccounts = AccountUtils.accountsByState(desiredState);

// System.debug(caliAccounts);


Http http = new Http();

HttpRequest request = new HttpRequest();

request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');

request.setMethod('POST');

request.setHeader('Content-Type','application/json;charset=UTF-8' );

// Set the body as a JSON Object

request.setBody('{"name" : "mighty moose"}');

HttpResponse response = http.send(request);

// Parse the JSON 

if(response.getStatusCode() != 201) {
    System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
} else {
    System.debug(response.getBody());
    System.debug('this is a test');
}

//Testing SSH Key





