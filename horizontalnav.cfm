<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link href="../includes/css/class.css" rel="stylesheet"/>
    <link href="../includes/css/mycss.css" rel="stylesheet"/>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="#">
          <img src="images/rdb.png" alt="Read Dees Books Logo"/>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                  <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="#">Store Information</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="#">Highlighted Favorites</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="#">Events</a>
              </li>
          </ul>
        <cfoutput>
          <form class="d-flex" action="#cgi.SCRIPT_NAME#?p=details" method="POST">
              <input class="form-control me-2" type="search" placeholder="Search" name="searchme" aria-label="Search">
              <button class="btn btn-outline-success" type="submit">Search</button>
          </form>
          <ul class="navbar-nav mr-auto">
            <cfif session.user.isLoggedIn>
              <li class="nav-item">
                <a class="nav-link">Welcome #session.user.firstname# #session.user.lastname#</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=logoff ">Logout</a>
              </li>
            <cfelse>
              <li class="nav-item">
                <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=login">Login</a>
              </li>
            </cfif>
          </ul>
        </cfoutput>
      </div>
    </nav>
  </body>
</html>