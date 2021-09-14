import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class GetServices{
 Future<dynamic> getAllMovieData()async   // function to retrieve data for the first page
  {
    String uri = "http://www.omdbapi.com/?s=magic&apikey=${DotEnv().env['ApiKey'].toString()}";
    Uri x = Uri.parse(uri);
    var request = await http.get(x);
    var movieData = jsonDecode(request.body);
    return movieData;
  }
  Future<dynamic>getSingleMovieDetails(String imdbId)async // function to retrieve data for the second page
  {
    String uri = "http://www.omdbapi.com/?i=$imdbId&apikey=${DotEnv().env['APIKEY'].toString()}";
    Uri x = Uri.parse(uri);
    var result = await http.get(x);
    var ans = jsonDecode(result.body);
    return ans;
  }
}