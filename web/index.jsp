<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <title>Welcome</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <link rel="stylesheet" href="css/custom.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <link rel="shortcut icon" href="assets/ico/trophy.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Merriweather:400,900,900i" rel="stylesheet">
    </head>
    <body>
        <input type="hidden" value="${requestScope.NOTIFY}" id="notify" />
        <input type="hidden" value="${requestScope.INVALID_EMAIL}" id="valid_email"/>
        <input type="hidden" value="${requestScope.INVALID_NAME}" id="valid_name"/>
        <input type="hidden" value="${requestScope.INVALID_PASSWORD}" id="valid_password" >
        <input type="hidden" value="${requestScope.INVALID_RE_PASSWORD}" id="valid_re_password"/>
        <input type="hidden" value="${requestScope.ACTION}" id="action" />

        <div class="login-page">
            <div class="form">

                <!-- REGISTER FORM -->
                <form class="register-form" action="register" method="post" onsubmit="return checkValidation()">
                    <h1>Register Form</h1>
                    <center>
                        <input id="txtEmail" title="" style="width: 98%; margin-left: 7px" value="${requestScope.EMAIL}" name="p_email" type="email" placeholder="email address" maxlength="30" required/>
                    </center>
                    <center>
                        <input id="txtName" title="" style="width: 98%; margin-left: 7px" value="${requestScope.NAME}" name="p_name" type="text" placeholder="name" maxlength="30" required/>
                    </center>
                    <center>
                        <input id="txtPassword" title="" style="width: 98%"  value="${requestScope.PASSWORD}" name="p_password" type="password" placeholder="password"  required maxlength="30"/>
                        <i onclick="viewPass(this)" class="far fa-eye" style="margin-left: -30px; cursor: pointer"></i>
                    </center>

                    <center>
                        <input id="txtRePassword" title="" style="width: 98%" name="p_re_password" type="password" placeholder="re-password" required maxlength="30"/>
                        <i onclick="viewRePass(this)" class="far fa-eye" style="margin-left: -30px; cursor: pointer"></i>  
                    </center>   

                    <button style="width: 98%">Create</button>
                    <p class="message">Already registered? <a href="#">Login</a></p>
                </form>

                <script>
                    function viewPass(icon) {
                        
                        var element = document.getElementById("txtPassword");
                        if (element.type === "password") {
                            element.type = "text";
                            icon.className = "far fa-eye-slash";
                        } else {
                            element.type = "password";
                            icon.className = "far fa-eye";
                        }
                    }
                    function viewRePass(icon) {
                        var element = document.getElementById("txtRePassword");
                        if (element.type === "password") {
                            element.type = "text";
                            icon.className = "far fa-eye-slash";
                        } else {
                            element.type = "password";
                            icon.className = "far fa-eye";
                        }
                    }
                    function checkValidation() {
                        var pass = document.getElementById("txtPassword").value;
                        var re_pass = document.getElementById("txtRePassword").value;

                        if (pass !== re_pass) {
                            alert("Password is not match with re-password !!! Pleaase re-check.");
                            return false;
                        }
                        return true;
                    }
                </script>

                <!-- LOGIN FORM-->
                <form class="login-form" action="login" method="post">
                    <h1>Login</h1>
                    <input type="text" placeholder="email" name="p_email"/>
                    <input type="password" placeholder="password" name="p_password"/>
                    <button>Login</button>
                    <p class="message">Not registered? <a href="#" id="registerLink" onclick="change()">Create an account</a></p>
                </form>
            </div>
            <script>
                $('.message a').click(function () {
                    $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
                });

                var action = document.getElementById("action").value;

                var notify = document.getElementById("notify").value;

                if (notify.length !== 0) {
                    alert(notify);
                }

                if (action.length !== 0) {
                    document.getElementById("registerLink").click();
                }

                function change() {
                    var txtEmail = document.getElementById("txtEmail");
                    var txtName = document.getElementById("txtName");
                    var txtPassword = document.getElementById("txtPassword");
                    var txtRePassword = document.getElementById("txtRePassword");

                    if (txtEmail !== null && txtEmail.value.length !== 0) {
                        
                        txtEmail.style.background = '#fc4e03';
                        txtEmail.title = document.getElementById("valid_email").value;
                    }

                    if (txtName !== null && txtName.value.length !== 0) {
                        txtName.title = document.getElementById("valid_name").value;
                        txtName.style.borderColor = '#fc4e03';
                    }
                    
                    if (txtPassword !== null && txtPassword.value.length !== 0) {
                        txtPassword.title = document.getElementById("valid_password").value;
                        txtPassword.style.borderColor = '#fc4e03';
                    }
                    
                    if (txtRePassword !== null && txtRePassword.value.length !== 0) {
                        txtRePassword.title = document.getElementById("valid_re_password").value;
                        txtRePassword.style.borderColor = '#fc4e03';
                    }
                }
            </script>
        </div>
    </body>
</html>
