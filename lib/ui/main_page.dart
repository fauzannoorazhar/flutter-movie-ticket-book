import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_bloc_views.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_home_page.dart';

class MainPage extends StatefulWidget {
    MainPage({Key key}) : super(key: key);

    @override
    _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    int _indexTabs = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: getBodyMainPage(),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                    setState(() {
                        this._indexTabs = index;
                    });
                },
                currentIndex: _indexTabs,
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
                            'BLOC',
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

    getBodyMainPage() {
        if (this._indexTabs == 0) {
            return MoviesHomePage();
        }

        if (this._indexTabs == 1) {
            return MoviesBlocViews();
        }
    }
}