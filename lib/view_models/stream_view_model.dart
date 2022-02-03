import 'dart:async';

import 'package:mvvm_flutter/data/ApiServiceImpl.dart';
import 'package:mvvm_flutter/data/response/response.dart';
import 'package:mvvm_flutter/models/movie.dart';

class StreamBuilderViewModel extends SecondaryViewModelInputs with SecondaryViewModelOutputs {
  final ApiServiceImpl _apiService;

  StreamBuilderViewModel(this._apiService);

  StreamController _searchMovieController = StreamController<Response<List<Movie>>>();

  Response<List<Movie>> _allMovies = Response.initial();

  Response<List<Movie>> get allMovies => _allMovies;

  start() {
    _setState(Response.initial());
  }

  dispose() {
    _searchMovieController.close();
  }

  @override
  Sink get inputSearchMovie => _searchMovieController.sink;

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
    inputSearchMovie.add(state);
  }

  @override
  Stream<Response<List<Movie>>> get outputAllMovies => _searchMovieController.stream.map((event) => event);
}

abstract class SecondaryViewModelInputs {
  Sink get inputSearchMovie;
}

abstract class SecondaryViewModelOutputs {
  Stream<Response<List<Movie>>> get outputAllMovies;
}
