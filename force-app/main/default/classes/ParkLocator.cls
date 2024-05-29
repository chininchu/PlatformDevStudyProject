public class ParkLocator {

    public static List<String> country(String countryName) {
        ParkService.ParksImplPort service = new ParkService.ParksImplPort();
        String[] parksArray = service.byCountry(countryName);
        List<String> parkNames = new List<String>();
        if (parksArray != null) {
            for (String park : parksArray) {
                parkNames.add(park);
            }
        }
        return parkNames;
    }
}