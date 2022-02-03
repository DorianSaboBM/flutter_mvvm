import 'package:mvvm_flutter/models/movie.dart';

abstract class ApiService {
  Future<List<Movie>> fetchAllMovies();
}
