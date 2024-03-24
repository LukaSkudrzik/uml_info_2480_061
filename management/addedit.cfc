
component {
  function processForms(required struct formData) {
    if(formData.keyExists("isbn13") && formData.isbn13.len()==13 && formData.keyExists("title") && formData.title.len() > 0) {

      if(formData.keyExists("uploadImage") && formData.uploadImage.len() > 0) {
        arguments.formData.image = uploadBookCover();
      }

     var qs = new query( datasource = application.dsource );
     qs.setSql("
        IF NOT EXISTS( SELECT * FROM books WHERE isbn13=:isbn13)
        INSERT INTO books (isbn13,title) VALUES (:isbn13,:title);
        UPDATE books SET
            title=:title,
            weight=:weight,
            year=:year,
            pages=:pages,
            isbn=:isbn,
            publisher=:publisherID,
            image=:image,
            description=:description
        WHERE isbn13=:isbn13
        ");
     qs.addParam(
      name = "isbn13",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(formData.isbn13),
      null = formData.isbn13.len()!=13
     );
     qs.addParam(
      name = "title",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(formData.title),
      null = formData.title.len()==0
     );
     qs.addParam(
      name = "weight",
      cfsqltype = "CF_SQL_NUMERIC",
      value = trim(formData.weight),
      null = !isValid("numeric", formData.weight)
     );
     qs.addParam(
      name = "year",
      cfsqltype = "CF_SQL_INTEGER",
      value = trim(formData.year),
      null = !isValid("numeric", formData.year)
     );
     qs.addParam(
      name = "pages",
      cfsqltype = "CF_SQL_INTEGER",
      value = trim(formData.pages),
      null = !isValid("numeric", formData.pages)
     );
     qs.addParam(
      name = "isbn",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(formData.isbn),
      null = formData.isbn.len()!=10
     );
     qs.addParam(
      name = "publisherID",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(formData.publisherID),
      null = formData.publisherID.len() == 0
     );
     qs.addParam(
      name = "image",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(formData.image),
      null = formData.image.len() == 0
     );
     qs.addParam(
      name = "description",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(formData.description),
      null = trim(formData.description).len() == 0
     );
     qs.execute();

     if(formData.keyExists("genre")) {

      deleteAllBookGenres(formData.isbn13);

      formData.genre.listToArray().each(function(item) {
        insertGenre(item, formData.isbn13);
      })
     }

    }
  }

  function sideNavBooks(qterm) {
    if(qterm.len() == 0) {
      return queryNew("title");
    } else {
    var qs = new query(datasource = application.dsource);
    qs.setSql("select * from books where title like :qterm order by title");
    qs.addParam(name="qterm",value="%#qterm#%");
    return qs.execute().getResult();
    }
  }

  function bookDetails(required string isbn13) {
    var qs = new query(datasource = application.dsource);
    qs.setSql("Select * from books where isbn13=:isbn13");
    qs.addParam(
      name = "isbn13",
      cfsqltype = "CF_SQL_NVARCHAR",
      value = trim(arguments.isbn13)
     );
    return qs.execute().getResult();
  }

  function allPublishers(isbn13) {
    var qs = new query(datasource = application.dsource);
    qs.setSql("Select * from Publishers order by name");
    return qs.execute().getResult();
  }

  function uploadBookCover() {
    var imageData = fileUpload(expandPath("../images/"),"uploadImage","*","makeUnique");
    return imageData.serverFile;
  }

  function allGenres() {
    var qs = new query(datasource = application.dsource);
    qs.setSql("Select * from genres order by name");
    return qs.execute().getResult();
  }

  function insertGenre(genreID, bookID) {
    var qs = new query(datasource=application.dsource);
    qs.setSql("insert into genreToBook (bookID, genreID) VALUES (:bookID, :genreID) ");
    qs.addParam(name="bookID", value=arguments.bookID);
    qs.addParam(name="genreID", value=arguments.genreID);
    qs.execute();
  }

  function deleteAllBookGenres(bookID) {
    var qs = new query(datasource=application.dsource);
    qs.setSql("delete from genreToBook WHERE bookID=:bookID");
    qs.addParam(name="bookID", value=arguments.bookID);
    qs.execute();
  }

  function bookGenres(bookID){
    var qs = new query(datasource=application.dsource);
    qs.setSql("select * from genreToBook WHERE bookID=:bookID");
    qs.addParam(name="bookID", value=arguments.bookID);
    return qs.execute().getResult();
  }

}