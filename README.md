# Movies

Application primarily shows list of Movies based on below categories:
1. Popular
2. Top Rated
3. Upcoming

Key features:
1. The movie list is lazy loaded and the app fetches subsequent page data on scroll.
2. App works in both online and offline mode i.e. the list is cached and loaded in case of no connection.
3. Movie list is searchable within the selected category.
4. Movie details including generes and production companies.

Key components :
1. Protocol oriented design approach.
2. Movie list screen (Architecture used : VIPER)
3. Movie details screen (Architecture used : VIPER)
4. MovieAPIManager confirming to APIManager (Service layer) 
5. MediaStore (to load and cache media)
