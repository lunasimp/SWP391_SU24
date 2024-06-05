<%-- 
    Document   : login
    Created on : May 24, 2023, 8:15:50 PM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/logreg.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .google {
                width: 75%;
                height: 46px;
                margin-left: 80px;
                background: red;
                border: 1px solid red;
                color: white;
                font-size: 22px;
                cursor: pointer;
                text-decoration: none; 
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="container-form">
                <div class="left-part_space"></div>
                <div class="left_part">
                    <h6 class="left-heading">
                        <span>FPT EDUCATION</span>
                    </h6>
                </div>
                <div class="right_part">
                    <div class="spacing_top"></div>
                        <div class="right-head">
                            <h3 class="right-title">Login</h3>
                            <p class="right-desc">Fill your info</p>
                        </div>
                        <div class="form-group">
                            <input id="email" name="email" value="${email==null?'admin@gmail.com':email}" type="text" placeholder="Email" class="form-control">
                            <span class="form-message"></span>
                        </div>
                        <div class="form-group">
                            <input id="password" name="password" value="${password==null?'12345678':password}" type="password" placeholder="Password" class="form-control">
                            <span class="form-message"></span>
                        </div>
                        <div>
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:9999/SWP391_SU24/login&response_type=code&client_id=751407796002-7ojn2teuinouq43pkr7lg6bjjsvapa56.apps.googleusercontent.com&approval_prompt=force" class="google">
                                    <span><i class="fab fa-google-plus-g"></i> Login with Google</span></a>
                        </div>
                        <span class="validate-message">${validate}</span>
                        <div>
                            <button id="form-submit" class="form-submit">Login</button>
                        </div>
                    <div class="spacing_bottom"></div>
                </div>
                <div class="right-part_space"></div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/assets/js/login.js"></script>
        <script>
            Validator({
                form: "#form-1",
                formGroupSelector: ".form-group",
                querySelector: ".form-message",
                rules: [
                    Validator.isEmail("#email"),
                    Validator.isRequired("#email"),
                    Validator.isRequired("#password")
                ]
            });
        </script>
    </body>

</html>
