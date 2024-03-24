<cfparam name="accountMessage" default=""/>

<script type="text/javascript" defer>
  function validateNewAccount() {
    let originalPassword = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;

    if(originalPassword.length && originalPassword === confirmPassword){
      document.getElementById("accountMessage").innerHTML = "";
      document.getElementById("submitPage").click();
    } else {
      document.getElementById("accountMessage").innerHTML = "Please check that you entered your password and the confirm password entry."
    }
  }
</script>

<cfoutput>

  <div id="accountMessage">
    #accountMessage#
  </div>

  <form action="#cgi.script_name#?p=login" method="POST">
    <div class="form-floating mb-3">
      <input type="text" id="title" name="title" class="form-control" placeholder="Please Enter Mr., Ms., or Mrs." />
      <label for="title">Title: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="text" id="firstname" name="firstname" class="form-control" placeholder="Please Enter Your First Name" required/>
      <label for="firstname">*First Name: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="text" id="lastname" name="lastname" class="form-control" placeholder="Please Enter Your Last Name" required/>
      <label for="lastname">*Last Name: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="email" id="email" name="email" class="form-control" placeholder="Please Enter Your Email" required />
      <label for="email">*Email: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="password" id="password" name="password" class="form-control" placeholder="Please Enter Your Password" required/>
      <label for="password">*Password: </label>
    </div>

    <div class="form-floating mb-3">
      <input type="password" id="confirmPassword" class="form-control" placeholder="Please Confirm Your Password" required />
      <label for="confirmPassword">*Confirm Password: </label>
    </div>

    <div>
      <button class="btn btn-warning" type="button" onclick="validateNewAccount()">Make New Account</button>
      <input type="submit" id="submitPage" style="display:none"/>
    </div>
  </form>

</cfoutput>