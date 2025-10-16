<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Zinkit Grocery</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="forms.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<style>
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f7fafc;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    color: #333;
}

.form-container {
    background-color: #ffffff;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    width: 100%;
    max-width: 400px;
    box-sizing: border-box;
}

.form-header {
    text-align: center;
    margin-bottom: 30px;
}

.form-header .logo {
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: inherit;
    margin-bottom: 15px;
}

.form-header .logo img {
    height: 35px;
    margin-right: 10px;
}

.form-header .logo span {
    font-size: 14px;
    line-height: 1.2;
    text-align: left;
}

.form-header h2 {
    margin: 0;
    font-size: 24px;
    font-weight: 600;
}

.form-header p {
    margin: 5px 0 0;
    color: #777;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-weight: 500;
    margin-bottom: 8px;
    font-size: 14px;
}

.input-wrapper {
    position: relative;
}

.input-wrapper i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #aaa;
}

.form-input {
    width: 100%;
    padding: 12px 15px 12px 40px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box;
    transition: border-color 0.2s;
}

.form-input:focus {
    outline: none;
    border-color: #249b69;
}

.form-button {
    width: 100%;
    padding: 14px;
    background-color: #249b69;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s;
}

.form-button:hover {
    background-color: #1e8258;
}

.form-switch-link {
    text-align: center;
    margin-top: 25px;
    font-size: 14px;
    color: #555;
}

.form-switch-link a {
    color: #249b69;
    font-weight: 600;
    text-decoration: none;
}

.form-switch-link a:hover {
    text-decoration: underline;
}
</style>

<body>
    <div class="form-container">
        <div class="form-header">
            <a href="index.jsp" class="logo">
                <img src="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg" alt="Zinkit Logo">
                <span>
                    <strong>Zinkit</strong><br>GROCERY
                </span>
            </a>
            <h2>Forgot Password?</h2>
            <p>Enter your registered email to receive an OTP.</p>
        </div>

        <form action="ForgotPasswordServlet" method="POST">
            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" id="email" name="email" class="form-input" placeholder="your.email@example.com" required>
                </div>
            </div>

            <button type="submit" class="form-button">Next</button>

            <div class="form-switch-link">
                Remembered your password? <a href="login.jsp">Login here</a>
            </div>
        </form>

        <% String msg = (String) request.getAttribute("message");
           if (msg != null) { %>
           <p style="color: green; text-align: center; font-weight: 500;">
               <%= msg %>
           </p>
        <% } %>
    </div>
</body>
</html>
