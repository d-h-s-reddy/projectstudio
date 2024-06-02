<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset Success</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }
        .container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .success-icon {
            display: inline-block;
            width: 80px;
            height: 80px;
            background-color: lightgreen;
            border-radius: 50%;
            text-align: center;
            line-height: 80px;
            font-size: 36px;
            color: white;
        }
        .message {
            font-size: 20px;
            margin: 20px 0;
        }
        .login-button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .login-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">&#10004;</div>
        <div class="message">Your password has been reset successfully</div>
        <a href="${pageContext.request.contextPath}/login" class="login-button">Go to Login Page</a>
    </div>
</body>
</html>
