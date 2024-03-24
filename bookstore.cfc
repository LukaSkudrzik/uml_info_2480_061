component {

  function obtainSearchResults(searchme) {
    var qs = new query(datasource = application.dsource);
    qs.setSql("select * from books inner join publishers on books.publisher = publishers.publisherID where title like :searchme or isbn13=:isbn13");
    qs.addParam(name="searchme",value="%#searchme#%");
    qs.addParam(name="isbn13",value="#searchme#");
    return qs.execute().getResult();
  }

}