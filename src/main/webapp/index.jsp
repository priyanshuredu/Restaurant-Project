<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogIn</title>
<link rel="stylesheet" href="style.css">
<link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet'>
</head>
<body>
<form action="submit" method="post">
    <div id="main-container">
        <div id="left-container">
            <div class="info-container">
                <div class="heading">Log In to Account</div>
                <div class="bar1"></div>
                <div class="icon-sec">
                    <!-- Your icons here -->
                </div>
                <p>or use your email account</p>
                <div class="input-box">
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="button-box">
                    <button type="button">Remember me</button>
                </div>
                <button class="button1" type="submit" name="action" value="login">LOG IN</button>
            </div>
            <a href="#">Privacy Policy | Terms & conditions</a>
        </div>
        <div id="right-container">
            <h2>Hello, Friend!</h2>
            <div class="bar2"></div>
            <p>Create your account and start your journey with us.</p>
            <a href="Signup.jsp"><button class="button2" type="button">SIGN UP</button></a>
        </div>
    </div>
</form>
</body>
</html>
