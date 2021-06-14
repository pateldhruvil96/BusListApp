# BusList - Dhruvil Patel


API Used: https://api.jsonbin.io/b/6093c95293e0ce40806d8a1d

Video Demo: https://youtu.be/XsXdA4lI__s

Data Fetched from API:
   1. Source Location, Destination Location
   2. Departure & Arrival Time
   3. User's Rating
   4. Fare Price & Currency type
   5. Bus Type: AC, Non-AC, Seater, Sleeper
   6. Bus Logo Url
  
    
Things to know:
   1. Implemented dynamic TableView for displaying data fetched from API
   2. Since fetched data is very less(i.e 5), pagination is not implemented in TableView
   3. Once data is fetched it will be saved in database with the help of CoreData Framework for Offline support
   4. User can multi-select the bus type(i.e AC,NonAc,Seater & Sleeper)
   5. User can also sort the fetched data by selecting:
        Sort by:
        a) User's Rating
        b) Early Departure
        c) Late Departure
        d) Fare price
   6. Used xib's for custom layouts, implemented AutoLayouts, used StackView for properly displaying the data
   7. Added  alert for : no networkConnectivity, failed API, empty data
   8. Design Pattern: MVC(Model View Controller)
   9. No third-party framework is integrated.






 
