import 'package:flurest/blocs/movie_bloc.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_response.dart';
import 'package:flurest/view/movie_detail.dart';
import 'package:flutter/material.dart';
class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}
class _MovieScreenState extends State<MovieScreen> {
  MovieBloc _bloc;
@override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Moviez',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMovieList(),
        child: StreamBuilder<ApiResponse<List<Movie>>>(
          stream: _bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return MovieList(movieList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchMovieList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
@override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
class MovieList extends StatelessWidget {
  final List<Movie> movieList;
const MovieList({Key key, this.movieList}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetail(movieList[index].id)));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
class Error extends StatelessWidget {
  final String errorMessage;
final Function onRetryPressed;
const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);
@override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
class Loading extends StatelessWidget {
  final String loadingMessage;
const Loading({Key key, this.loadingMessage}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}