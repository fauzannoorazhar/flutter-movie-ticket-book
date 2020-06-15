import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_bloc.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_event.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_state.dart';
import 'package:mf_movie_ticket_book/data/domain/movies_domain.dart';
import 'package:mf_movie_ticket_book/data/repository/movies_repository.dart';
import 'package:mf_movie_ticket_book/models/ListCategoryMovies.dart';
import 'package:mf_movie_ticket_book/models/ListMoviesApi.dart';
import 'package:mf_movie_ticket_book/ui/widgets/custom_slider.dart';
import 'package:mf_movie_ticket_book/ui/widgets/tab_movies.dart';
import 'package:mf_movie_ticket_book/utilities/constants.dart';

class MoviesHomePage extends StatefulWidget {
    @override
    _MoviesHomePageState createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
    MoviesListBloc _moviesListBloc;
    MoviesListDomain _moviesListDomain;

    List<ListCategoryMovies> listCategoryMovies = new List<ListCategoryMovies>();
    List<ListMoviesApi> listMoviesSlider = new List<ListMoviesApi>();

    @override
    void initState() { 
        super.initState();
        _moviesListDomain = new MoviesListDomain(MoviesListRepository());
        _moviesListBloc = new MoviesListBloc(
            moviesListDomain: _moviesListDomain,
            futureMethod: _moviesListDomain.getListMoviesTabHomePage()
        );

        initListCategoryMovies();
        initListMoviesApi();
    }

    void initListCategoryMovies() {
        if (listCategoryMovies.isEmpty) {
            setState(() {
                listCategoryMovies.add(ListCategoryMovies(name: 'Marvel Cinematic Universe', active: true));
                listCategoryMovies.add(ListCategoryMovies(name: 'DC Extended Universe', active: false));
                listCategoryMovies.add(ListCategoryMovies(name: 'Adventure/Fantasy', active: false));
            });
        }
    }

    void initListMoviesApi() {
        if (listMoviesSlider.isEmpty) {
            setState(() {
                listMoviesSlider.add(ListMoviesApi(id: 'tt3480822', apiUrl: apiUrl + '?i=tt3480822&apikey=' + apiKey));
                listMoviesSlider.add(ListMoviesApi(id: 'tt9032400', apiUrl: apiUrl + '?i=tt9032400&apikey=' + apiKey));
                listMoviesSlider.add(ListMoviesApi(id: 'tt9376612', apiUrl: apiUrl + '?i=tt9376612&apikey=' + apiKey));
                listMoviesSlider.add(ListMoviesApi(id: 'tt10648342', apiUrl: apiUrl + '?i=tt10648342&apikey=' + apiKey));
                listMoviesSlider.add(ListMoviesApi(id: 'tt9419884', apiUrl: apiUrl + '?i=tt9419884&apikey=' + apiKey));
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        _moviesListBloc.add(MoviesListFetching());

        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 0,
                bottom: PreferredSize(
                    child: Container(color: Colors.white, height: 4.0), 
                    preferredSize: Size.fromHeight(4.0)
                ),
                backgroundColor: Colors.white,
                title: Text('Movies', style: TextStyle(color: Colors.purple)),
                centerTitle: true,
                actions: [
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: FaIcon(
                            FontAwesomeIcons.bell,
                            color: Colors.purple,
                        )
                    )
                ],
            ),
            body: SingleChildScrollView(
                child: Column(
                    children: [
                        CustomeSlider(listMoviesApi: listMoviesSlider),
                        BlocProvider(
                            create: (BuildContext context) {
                                return _moviesListBloc;
                            },
                            child: BlocListener<MoviesListBloc, MoviesListState> (
                                bloc: _moviesListBloc,
                                listener: (BuildContext context, MoviesListState state) {
                                    if (state is MoviesFetchErrorList) {
                                        print(state.error.toString());
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text('${state.error}'),
                                                backgroundColor: Colors.red,
                                            ),
                                        );
                                    }
                                },
                                child: BlocBuilder<MoviesListBloc, MoviesListState>(
                                    bloc: _moviesListBloc,
                                    builder: (BuildContext buildContext, MoviesListState state) {
                                        if (state is MoviesFetchSuccessList) {
                                            return TabMovies(
                                                listCategoryMovies: this.listCategoryMovies,
                                                listMovies: state.lisMovies,
                                            );
                                        } else {
                                            return Center(
                                                child: CircularProgressIndicator(),
                                            );
                                        }
                                    },
                                ),
                            ),
                        )
                    ],
                )
            ),
        );
    }
}