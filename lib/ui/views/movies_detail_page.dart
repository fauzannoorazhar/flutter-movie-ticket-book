import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_booking_page.dart';

class MoviesDetailPage extends StatefulWidget {
    final Movies movies;
    
    MoviesDetailPage({
        @required this.movies,
    });

    @override
    _MoviesDetailPageState createState() => _MoviesDetailPageState();
}

class _MoviesDetailPageState extends State<MoviesDetailPage> with TickerProviderStateMixin {
    TabController _controller;

    @override
    void initState() {
        _controller = new TabController(length: 3, vsync: this);
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.42,
                            child: appBarMovies()
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: DefaultTabController(
                                length: 3,
                                child: Column(
                                    children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.purple,
                                                    )
                                                )
                                            ),
                                            constraints: BoxConstraints.expand(height: 50),
                                            child: TabBar(
                                                controller: _controller,
                                                indicatorColor: Theme.of(context).primaryColor,
                                                labelColor: Theme.of(context).primaryColor,
                                                unselectedLabelColor: Colors.black,
                                                indicatorWeight: 5,
                                                tabs: [
                                                    Tab(
                                                        text: "Synopsis/Plot"
                                                    ),
                                                    Tab(
                                                        text: "Writer"
                                                    ),
                                                    Tab(
                                                        text: "Actors"
                                                    ),
                                                ],
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: TabBarView(
                                controller: _controller,
                                children: [
                                    Text(
                                        widget.movies.plot,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1.8
                                        ),
                                    ),
                                    Text(
                                        widget.movies.writer,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1.8
                                        ),
                                    ),
                                    Text(
                                        widget.movies.actors,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1.8
                                        ),
                                    ),
                                ],
                            ),
                        )
                    ],
                )
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    return Navigator.push(context, MaterialPageRoute(builder: (_) => MoviesBookingPage(movies: widget.movies)));
                }, 
                label: Text(
                    'Buy Ticket',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 18
                    ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                icon: FaIcon(FontAwesomeIcons.ticketAlt),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
    }

    Widget appBarMovies() {
        return Stack(
            children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //     image: NetworkImage(widget.movies.poster),
                        //     fit: BoxFit.cover
                        // ),
                        color: Colors.purple
                    ),
                    child: SafeArea(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    InkWell(
                                        child: FaIcon(FontAwesomeIcons.arrowLeft),
                                        onTap: () {
                                            return Navigator.pop(context);
                                        },
                                    ),
                                    FaIcon(FontAwesomeIcons.shareAlt),
                                ],
                            )
                        ),
                    ),
                ),
                Positioned(
                    top: 100,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.28,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Positioned(
                                    top: 100,
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                                        height: 180,
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(widget.movies.poster),
                                                fit: BoxFit.cover
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                            ),
                                            boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black.withOpacity(0.2),
                                                    blurRadius: 2,
                                                    offset: Offset(9, 9)
                                                ),
                                            ]
                                        ),
                                    ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.only(top: 80, left: 10),
                                        padding: EdgeInsets.only(top: 10),
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                    widget.movies.title,
                                                    style: TextStyle(
                                                        fontSize: 20
                                                    ),
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                    widget.movies.genre,
                                                    style: TextStyle(
                                                        fontSize: 14
                                                    ),
                                                ),
                                                SizedBox(height: 6),
                                                Row(
                                                    children: [
                                                        FaIcon(
                                                            FontAwesomeIcons.star,
                                                            size: 13,
                                                            color: Colors.purple,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            "iMDB ${widget.movies.getRating(0).value}",
                                                            style: TextStyle(
                                                                fontSize: 14
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                    "${widget.movies.runtime}",
                                                    style: TextStyle(
                                                        fontSize: 14
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                ),
            ],
        );
    }
}