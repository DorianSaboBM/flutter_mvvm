import 'dart:convert';

import 'package:mvvm_flutter/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl {
  Future<List<Movie>?> fetchAllMovies() async {
    try {
      final response = await http.get(Uri.parse("http://www.omdbapi.com/?s=Superman&page=2&apikey=ff815cf0"));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
