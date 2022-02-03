import 'package:flutter/material.dart';
import 'package:mvvm_flutter/data/ApiServiceImpl.dart';
import 'package:mvvm_flutter/data/response/response.dart';
import 'package:mvvm_flutter/models/movie.dart';

class ProviderViewModel extends ChangeNotifier {
  final ApiServiceImpl _apiService;

  ProviderViewModel(this._apiService);

  Response<List<Movie>> _allMovies = Response.initial();

  Response<List<Movie>> get allMovies => _allMovies;

  fetchAllMovies() async {
    _setState(Response.loading());
    final List<Movie>? movies = await _apiService.fetchAllMovies();
    // Force delay for showcase purposes
    await Future.delayed(Duration(seconds: 2));
    if (movies!.isNotEmpty) {
      _setState(Response.success(movies));
    } else {
      _setState(Response.error("Something went wrong"));
    }
  }

  _setState(Response<List<Movie>> state) {
    _allMovies = state;
    notifyListeners();
  }
}
