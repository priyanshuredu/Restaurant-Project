<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUp</title>
<link rel="stylesheet" href="signup.css">
</head>
<body>
<div id="main-container">
    <div id="left-container">
        <div class="info-container">
            <div class="heading">Create Account</div>
            <div class="bar1"></div>
            <div class="icon-sec">
                <!-- Icons section here -->
            </div>
            <p>or your email account</p>
            <form action="submit" method="post">
                <div class="input-box">
                    <input type="text" placeholder="Username" id="username" name="username" required>
                    <input type="email" placeholder="Email" id="email" name="email" required>
                    <input type="password" placeholder="Password" id="password" name="password" required>
                    <input type="password" placeholder="Confirm Password" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="button1" name="action" value="register">SIGN UP</button>
            </form>
        </div>
        <a href="">Privacy Policy | Terms & conditions</a>
    </div>
    <div id="right-container">
        <h2>Hello, Friend!</h2>
        <div class="bar2"></div>
        <p>Enter your details and start your journey with us.</p>
        <a href="index.jsp"><button class="button2">LOG IN</button></a>
    </div>
</div>
</body>
</html>
