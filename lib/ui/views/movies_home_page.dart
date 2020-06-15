import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_bloc.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_event.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_state.dart';
import 'package:mf_movie_ticket_book/data/domain/movies_domain.dart';
import 'package:mf_movie_ticket_book/data/repository/movies_repository.dart';
import 'package:mf_movie_ticket_book/models/ListCategoryMovies.dart';
import 'package:mf_movie_ticket_book/ui/widgets/slider_movies.dart';
import 'package:mf_movie_ticket_book/ui/widgets/tab_movies.dart';

class MoviesHomePage extends StatefulWidget {
    @override
    _MoviesHomePageState createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
    MoviesListBloc _moviesListBlocTab;
    MoviesListBloc _moviesListBlocSlider;
    MoviesListDomain _moviesListDomain;

    List<ListCategoryMovies> listCategoryMovies = new List<ListCategoryMovies>();

    @override
    void initState() { 
        super.initState();
        _moviesListDomain = new MoviesListDomain(MoviesListRepository());
        _moviesListBlocTab = new MoviesListBloc(
            moviesListDomain: _moviesListDomain,
            futureMethod: _moviesListDomain.getListMoviesTabHomePage()
        );
        _moviesListBlocSlider = new MoviesListBloc(
            moviesListDomain: _moviesListDomain,
            futureMethod: _moviesListDomain.getListMoviesHomeSlider()
        );

        initListCategoryMovies();
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

    @override
    Widget build(BuildContext context) {
        _moviesListBlocTab.add(MoviesListFetching());
        _moviesListBlocSlider.add(MoviesListFetching());

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
                        blocSliderMovies(),
                        blocTabMovies(),
                    ],
                )
            ),
        );
    }

    Widget blocSliderMovies() {
        return BlocProvider(
            create: (BuildContext context) {
                return _moviesListBlocSlider;
            },
            child: BlocListener<MoviesListBloc, MoviesListState> (
                bloc: _moviesListBlocSlider,
                listener: (BuildContext context, MoviesListState state) {
                    if (state is MoviesFetchErrorList) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${state.error}'),
                                backgroundColor: Colors.red,
                            ),
                        );
                    }
                },
                child: BlocBuilder<MoviesListBloc, MoviesListState>(
                    bloc: _moviesListBlocSlider,
                    builder: (BuildContext context, MoviesListState state) {
                        if (state is MoviesFetchSuccessList) {
                            return SliderMovies(listMovies: state.lisMovies);
                        } else {
                            return SliderMoviesLoad();
                        }
                    },
                ),
            ),
        );
    }

    Widget blocTabMovies() {
        return BlocProvider(
            create: (BuildContext context) {
                return _moviesListBlocTab;
            },
            child: BlocListener<MoviesListBloc, MoviesListState> (
                bloc: _moviesListBlocTab,
                listener: (BuildContext context, MoviesListState state) {
                    if (state is MoviesFetchErrorList) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${state.error}'),
                                backgroundColor: Colors.red,
                            ),
                        );
                    }
                },
                child: BlocBuilder<MoviesListBloc, MoviesListState>(
                    bloc: _moviesListBlocTab,
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
        );
    }
}