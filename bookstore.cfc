component {

  function obtainSearchResults(searchme, genre) {
    if(searchme.len()){
      var qs = new query(datasource = application.dsource);
      qs.setSql("select * from books inner join publishers on books.publisher = publishers.publisherID where title like :searchme or isbn13=:isbn13");
      qs.addParam(name="searchme",value="%#searchme#%");
      qs.addParam(name="isbn13",value="#searchme#");
      return qs.execute().getResult();
    } else if(genre.len()) {
        var qs = new query(datasource = application.dsource);
        qs.setSql("select * from books 
        inner join genreToBook on books.isbn13 = genreToBook.bookID
        inner join publishers on books.publisher = publishers.publisherID
        where genreToBook.genreID = :genreID
        and title like :searchme or isbn13 = :isbn13
        ")
        qs.addParam(name="searchme", value="%#searchme#");
        qs.addParam(name="genreID", value=arguments.genre);
        qs.addParam(name="isbn13", value="#searchme#");
        return qs.execute().getResult();
    }
  }

  function genresInStock(){
    var qs = new query(datasource=application.dsource);
    qs.setSql("select distinct name, genreID from genreToBook
      inner join genres on genreToBook.genreID = genres.ID
      order by genres.name
    ");
    return qs.execute().getResult();
  }

}

// 