import 'package:flutter/material.dart';
import 'package:mvvm_flutter/data/ApiServiceImpl.dart';
import 'package:mvvm_flutter/data/response/response.dart';
import 'package:mvvm_flutter/models/movie.dart';
import 'package:mvvm_flutter/view_models/stream_view_model.dart';

class StreamBuilderScreen extends StatefulWidget {
  StreamBuilderScreen({Key? key}) : super(key: key);

  @override
  State<StreamBuilderScreen> createState() => _StreamBuilderScreenState();
}

class _StreamBuilderScreenState extends State<StreamBuilderScreen> {
  StreamBuilderViewModel _viewModel = StreamBuilderViewModel(ApiServiceImpl());

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stream Builder MVVM"),
          elevation: 0,
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder<Response<List<Movie>>>(
          stream: _viewModel.outputAllMovies,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: snapshot.data?.status == Status.LOADING
                        ? null
                        : () {
                            _viewModel.fetchAllMovies();
                          },
                    child: Text('Get movies'),
                  ),
                  SizedBox(height: 20),
                  _mapStateToContent(snapshot.data),
                ],
              ),
            );
          },
        ));
  }

  _mapStateToContent(Response<List<Movie>>? data) {
    switch (data?.status) {
      case Status.LOADING:
        return Center(
          child: CircularProgressIndicator(),
        );
      case Status.SUCCESS:
        return _moviesWidget(data?.data);
      case Status.ERROR:
        return Center(
          child: Text("Test"),
        );
      case Status.INITIAL:
        return Container();
      default:
        return Container();
    }
  }

  _moviesWidget(movies) {
    return ListView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return ListTile(
            title: Row(
          children: [
            SizedBox(
                width: 100,
                child: ClipRRect(
                  child: Image.network(movie.poster),
                  borderRadius: BorderRadius.circular(10),
                )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(movie.title), Text(movie.year)],
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
