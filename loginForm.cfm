<cfparam name="loginMessage" default=""/>

<h2>Login</h2>

<cfoutput>

  <div id="loginMessage">#loginMessage#</div>

  <form action="#cgi.script_name#?p=login" method="POST">
    <div class="form-floating mb-3">
      <input type="text" id="loginemail" name="loginemail" class="form-control" placeholder="Please Enter Your Email" required />
      <label for="loginemail">Login Email: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Please Enter Your Password" required />
      <label for="loginpass">Password: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="submit" class="btn btn-primary" value="Login" style="width:100%"/>
    </div>
  </form>

</cfoutput>