<cfparam name="searchme" default=""/>
<cfparam name="genre" default=""/>

<cfoutput>
  <cfset bookInfo = bookstoreFunctions.obtainSearchResults(searchme, genre)/>

  <cfif bookInfo.recordcount == 0>
    #noResults()#
  <cfelseif bookInfo.recordcount == 1>
    #oneResult()#
  <cfelse>
    #manyResults()#
  </cfif>

</cfoutput>

<cffunction name="noResults">
  <cfoutput>
    There were no results. Please search again.
  </cfoutput>
</cffunction>

<cffunction name="oneResult">
  <cfoutput>
    <h2>Search Results</h2>
    <div class="row">
      <div class="col-6">
        <img src="images/#bookInfo.image[1]#" style="width:200px"/>
      </div>
      <div class="col-6">
        Title: #bookInfo.title#<br/>
        Year: #bookInfo.year#<br/>
        Publisher: #bookInfo.name#<br/>
        Pages: #bookInfo.pages#<br/>
        Binding: #bookInfo.binding#<br/>
        Language: #bookInfo.language#<br/>
        ISBN13: #bookInfo.isbn13#<br/>
        ISBN10: #bookInfo.isbn#<br/>
        Description: #bookInfo.description#<br/>
      </div>
    </div>
  </cfoutput>
</cffunction>

<cffunction name="manyResults">
  <cfoutput>
    <div>
     <div>There were #bookInfo.recordcount# results found.</div>
      <div>
        <ol class="nav flex-column">
          <cfloop query="bookInfo">
            <li class="nav-item">
              <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=details&searchme=#isbn13#">#title#</a>
            </li>
          </cfloop>
        </ol>
      </div>
    </div>
  </cfoutput>
</cffunction>