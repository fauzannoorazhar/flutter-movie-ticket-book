import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mf_movie_ticket_book/models/ListCategoryMovies.dart';
import 'package:mf_movie_ticket_book/models/ListMoviesApi.dart';
import 'package:mf_movie_ticket_book/ui/widgets/custom_slider.dart';
import 'package:mf_movie_ticket_book/ui/widgets/custom_tab_line.dart';

class MainPage extends StatefulWidget {
    MainPage({Key key}) : super(key: key);

    @override
    _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    List<ListCategoryMovies> listCategory = new List<ListCategoryMovies>();
    List<ListMoviesApi> listMoviesSlider = new List<ListMoviesApi>();

    @override
    Widget build(BuildContext context) {
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
                        CustomeSlider(listMoviesApi: initListMoviesSlider()),
                        CustomTabLine(list: initListCategoryMovies()),
                    ],
                )
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                    
                },
                currentIndex: 0,
                items: <BottomNavigationBarItem> [
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.video),
                        title: Text(
                            'MOVIES',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                        )
                    ),
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.ticketAlt),
                        title: Text(
                            'EVENTS',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                        )
                    ),
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.userAlt),
                        title: Text(
                            'PROFIL',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                        )
                    )
                ],
            )
        );
    }

    List<ListCategoryMovies> initListCategoryMovies() {
        if (listCategory.isEmpty) {
            listCategory.add(ListCategoryMovies(nama: 'Marvel Cinematic Universe', active: true));
            listCategory.add(ListCategoryMovies(nama: 'DC Extended Universe', active: false));
            listCategory.add(ListCategoryMovies(nama: 'Adventure/Fantasy', active: false));
        }

        return listCategory;
    }

    List<ListMoviesApi> initListMoviesSlider() {
        if (listMoviesSlider.isEmpty) {
            listMoviesSlider.add(ListMoviesApi(id: 'tt3480822', apiUrl: 'http://www.omdbapi.com/?i=tt3480822&apikey=84f704f1'));
            listMoviesSlider.add(ListMoviesApi(id: 'tt9032400', apiUrl: 'http://www.omdbapi.com/?i=tt9032400&apikey=84f704f1'));
            listMoviesSlider.add(ListMoviesApi(id: 'tt9376612', apiUrl: 'http://www.omdbapi.com/?i=tt9376612&apikey=84f704f1'));
            listMoviesSlider.add(ListMoviesApi(id: 'tt10648342', apiUrl: 'http://www.omdbapi.com/?i=tt10648342&apikey=84f704f1'));
            listMoviesSlider.add(ListMoviesApi(id: 'tt9419884', apiUrl: 'http://www.omdbapi.com/?i=tt9419884&apikey=84f704f1'));
        }

        return listMoviesSlider;
    }

    int _currentSlider = 0;
    Widget costumeSlider() {
        Widget carouselSlider = CarouselSlider(
            items: listMoviesSlider.map((i) {
                return Builder(
                    builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 6, right: 6, top: 10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                        Colors.purple,
                                        Colors.deepPurpleAccent,
                                    ]
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)
                                ),
                            ),
                        );
                    },
                );
            }).toList(),
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.23,
                enableInfiniteScroll: true,
                aspectRatio: 16/9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                    setState(() {
                        _currentSlider = index;
                    });
                }
            ),
        );

        return Container(
            height: MediaQuery.of(context).size.height * 0.273,
            child: Column(
                children: [
                    carouselSlider,
                    SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: listMoviesSlider.map((url) {
                            int index = listMoviesSlider.indexOf(url);
                            return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentSlider == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                            );
                        }).toList(),
                    ),
                ],
            ),
        );
    }
}