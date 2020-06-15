class Movies {
    String title;
    String year;
    String released;
    String runtime;
    String genre;
    String director;
    String writer;
    String actors;
    String plot;
    String language;
    String country;
    String awards;
    String poster;
    String metascore;
    String imdbRating;
    String imdbVotes;
    String imdbID;
    String type;
    List<Rating> listRating;

    // categoryMovies for home_page tab
    String categoryName;

    Movies({
        this.title,
        this.year,
        this.released,
        this.runtime,
        this.genre,
        this.director,
        this.writer,
        this.actors,
        this.plot,
        this.language,
        this.country,
        this.awards,
        this.poster,
        this.metascore,
        this.imdbRating,
        this.imdbVotes,
        this.imdbID,
        this.type,
        this.listRating,
        this.categoryName
    });

    factory Movies.fecthData(Map<String, dynamic> json) {
        List<Rating> listRatings = new List<Rating>();
        List listJsonRating = json['Ratings'];
        listRatings = listJsonRating.map((data) {
            return Rating.fecthData(data);
        }).toList();

        return Movies(
            title : json['Title'],
            year : json['Year'],
            released : json['Released'],
            runtime : json['Runtime'],
            genre : json['Genre'],
            director : json['Director'],
            writer : json['Writer'],
            actors : json['Actors'],
            plot : json['Plot'],
            language : json['Language'],
            country : json['Country'],
            awards : json['Awards'],
            poster : json['Poster'],
            metascore : json['Metascore'],
            imdbRating : json['imdbRating'],
            imdbVotes : json['imdbVotes'],
            imdbID : json['imdbID'],
            type : json['Type'],
            listRating: listRatings
        );
    }

    Rating getRating(int index) {
        return listRating[index];
    }
}

class Rating {
    String source;
    String value;

    Rating({
        this.source,
        this.value
    });

    factory Rating.fecthData(Map<String, dynamic> json) {
        return Rating(
            source: json['Source'],
            value: json['Value']
        );
    }
}