import 'dart:convert';

import 'package:http/http.dart' as http;
class GetServices{
 Future<dynamic> getAllMovieData()async
  {
    String uri = "http://www.omdbapi.com/?s=sea&apikey=b7fe3663";
    Uri x = Uri.parse(uri);
    var result = await http.get(x);
    var ans = jsonDecode(result.body);
    print(ans);
    return ans;
  }
}