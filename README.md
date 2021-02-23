# moviephile

This app allows users to gain access to an overview of popular movies. Specifically, users can see all popular movies (including details such as Ratings, Cast, and Description), as well as Popular movies by popularity.

The app is powered by content from The Movie DataBase (TMDB), through their comprehensive APIs. Check the website here (https://www.themoviedb.org/).

To run the App, clone/download, then edit the movies_provider.dart file (lib/data_providers/), and input your own API key (obtained from TMDB). Then then run. Replace <<Keys.TMDB_API_KEY>> with your own API key.


(NB: this app also depends on numerous packages including RxDart, bloc_test, flutter_bloc etc, make sure to get dependencies by running pub get before you build)