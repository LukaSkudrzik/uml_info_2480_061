<cftry>
  <cfparam name="book" default=""/>
  <cfparam name="qterm" default=""/>
  <cfdump var="#form#">

  <cfset addEditFunctions = createObject("addedit") />
  <cfset addEditFunctions.processForms(form)>
  
  <div class="row">
    <div id="main" class="col-9">
      <cfif book neq "">
        <cfoutput>#mainForm()#</cfoutput>
      </cfif>
    </div>

    <div id="leftgutter" class="col-lg-3 order-first">
      <cfoutput>#sideNav()#</cfoutput>
    </div>
  </div>
  <cfcatch type="any">
    <cfoutput>
      #cfcatch.Message#
    </cfoutput>
  </cfcatch>
</cftry>

<cffunction name="mainForm">

  <cfif book.len() == 0>
    Please choose a book from the left hand side.
  <cfelse>

    <cfset var thisBookDetails = addEditFunctions.bookDetails(book)/>
    <cfset var allPublishers = addEditFunctions.allPublishers()/>

    <cfoutput>
      <form action="#cgi.script_name#?tool=addedit&book=#book#&qterm=#qterm#" method="POST" enctype="multipart/form-data">
        <div class="form-floating mb-3">
          <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Please Enter the Book Title" />
          <label for="title">Book Title: </label>
        </div>
        <div class="form-floating mb-3">
          <input type="text" id="isbn13" name="isbn13" class="form-control" value="#thisBookDetails.isbn13[1]#" placeholder="Please Enter the ISBN13 of the Book" />
          <label for="isbn13">ISBN13: </label>
        </div>
        <div class="form-floating mb-3">
          <input type="text" id="isbn" name="isbn" class="form-control" value="#thisBookDetails.isbn[1]#" placeholder="Please Enter the ISBN10 of the Book" />
          <label for="isbn">ISBN10: </label>
        </div>
        <div class="form-floating mb-3">
          <input type="number" id="year" name="year" class="form-control" value="#thisBookDetails.year[1]#" placeholder="Please Enter the Year the Book was Published" />
          <label for="year">Year Published: </label>
        </div>
        <div class="form-floating mb-3">
          <input type="number" id="pages" name="pages" class="form-control" value="#thisBookDetails.pages[1]#" placeholder="Please Enter the Number of Pages in the Book" />
          <label for="pages">Number of Pages: </label>
        </div>
        <div class="form-floating mb-3">
          <input type="number" id="weight" name="weight" step="0.1" class="form-control" value="#thisBookDetails.weight[1]#" placeholder="Please Enter the Book Weight" />
          <label for="weight">Book Weight: </label>
        </div>
        <div class="form-floating mb-3">
          <select class="form-select" id="publisherID" name="publisherID" aria-label="Publisher Select Control">
            <option value=""></option>
            <cfloop query="allPublishers">
              <option value="#publisherID#" #publisherID eq thisBookDetails.publisher ? "selected" : ""#>#name#</option>
            </cfloop>
          </select>
          <label for="publisherID" >Publisher: </label>
        </div>
        <div class="row">
          <div class="col">
             <label for="uploadImage">Upload Cover</label>
           <div class="input-group mb-3">
              <input type="file" id="uploadImage" name="uploadImage" class="form-control"/>
              <input type="hidden" name="image" value="#trim(thisBookDetails.image[1])#"/>
            </div> 
          </div>
          <div class="col">
            <cfif thisBookDetails.image[1].len() gt 0 >
              <img src="../images/#trim(thisBookDetails.image[1])#" style="width:200px"/>
            </cfif>
          </div>
        </div>
        <div class="form-floating mb-3">
          <div>
            <label for="description">Description</label>
          </div>
          <textarea id="description" name="description">
            <cfoutput>#thisBookDetails.description#</cfoutput>
          </textarea>
          <script>
            ClassicEditor
              .create(document.querySelector('##description'))
              .catch(error => {console.dir(error)});
          </script>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%">Add Book</button>
      </form>
    </cfoutput>

  </cfif>
</cffunction>

<cffunction name="sideNav">
  <cfset allbooks = addEditFunctions.sideNavBooks(qterm)>
  <div>
  Book List
  </div>
  <cfoutput>
    #findBookForm()#
  </cfoutput>

  <cfoutput>
   <ul class="nav flex-column">
    <li class="nav-item">
      <a href="#cgi.SCRIPT_NAME#?tool=addedit&book=new" class="nav-link">
        Add a New Book
      </a>
    </li>
    <cfif qterm.len() == 0>
      No Search Term Entered
    <cfelseif allBooks.recordcount == 0>
      No Results found
    <cfelse>
      <cfloop query="allbooks">
       <li class="nav-item">
          <a href="#cgi.SCRIPT_NAME#?tool=addedit&book=#isbn13#&qterm=#qterm#" class="nav-link">#trim(title)#</a>
        </li>
      </cfloop>
    </cfif>
   </ul>
  </cfoutput>
</cffunction>

<cffunction name="findBookForm">
  <cfoutput>
    <form action="#cgi.SCRIPT_NAME#?tool=#tool#" method="POST">
      <div class="form-floating mb-3">
        <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit"/>
        <label for="qterm">Search Inventory</label>
      </div>
    </form>
  </cfoutput>
</cffunction>