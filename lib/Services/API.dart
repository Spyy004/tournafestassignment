import 'dart:convert';

import 'package:http/http.dart' as http;
class GetServices{
 Future<dynamic> getAllMovieData()async   // function to retrieve data for the first page
  {
    String uri = "http://www.omdbapi.com/?s=magic&apikey=b7fe3663";
    Uri apiUri = Uri.parse(uri);
    var request = await http.get(apiUri);
    var movieData = jsonDecode(request.body);
    return movieData;
  }
  Future<dynamic>getSingleMovieDetails(String imdbId)async // function to retrieve data for the second page
  {
    String uri = "http://www.omdbapi.com/?i=$imdbId&apikey=b7fe3663";
    Uri apiUri = Uri.parse(uri);
    var request = await http.get(apiUri);
    var movieData = jsonDecode(request.body);
    return movieData;
  }
}