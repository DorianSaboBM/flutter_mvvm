import 'package:flutter/material.dart';
import 'package:mvvm_flutter/data/ApiServiceImpl.dart';
import 'package:mvvm_flutter/data/response/response.dart';
import 'package:mvvm_flutter/view_models/provider_view_model.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatefulWidget {
  ProviderScreen({Key? key}) : super(key: key);

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  ProviderViewModel _viewModel = ProviderViewModel(ApiServiceImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider with MVVM"),
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: Consumer<ProviderViewModel>(
          builder: (context, viewModel, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: viewModel.allMovies.status == Status.LOADING
                        ? null
                        : () {
                            _viewModel.fetchAllMovies();
                          },
                    child: Text('Get movies'),
                  ),
                  SizedBox(height: 20),
                  _mapStateToContent(viewModel),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _mapStateToContent(ProviderViewModel viewModel) {
    switch (viewModel.allMovies.status) {
      case Status.LOADING:
        return Center(
          child: CircularProgressIndicator(),
        );
      case Status.SUCCESS:
        return _moviesWidget(_viewModel.allMovies.data);
      case Status.ERROR:
        return Center(
          child: Text(viewModel.allMovies.message!),
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
        });
  }
}
