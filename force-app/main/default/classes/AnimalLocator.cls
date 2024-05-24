public class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Construct the endpoint using the provided ID
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // Parse the JSON response
        if (response.getStatusCode() == 200) { // Successful response
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            String animalName = (String) results.get('name');
            return animalName; 
        } else {
            // Error handling (you can customize this based on your needs)
            System.debug('Error calling web service: ' + response.getStatusCode() + ' - ' + response.getStatus());
            return null; // Or throw an exception
        }
    }
}

