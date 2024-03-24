<cfset genresInStock = bookstoreFunctions.genresInStock()/>

  <section id="left" class="col-sm-3 order-first">
    <h3>Search By Genre</h3>
    <ul class="nav flex-column">
      <cfoutput query="genresInStock">
        <li class="nav-item">
          <a href="#cgi.SCRIPT_NAME#?p=details&genre=#genreID#" class="nav-link">#name#</a>
        </li>
      </cfoutput>
    </ul>
  </section>