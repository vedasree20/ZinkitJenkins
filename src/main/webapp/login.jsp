<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Zinkit Grocery</title>
        <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="forms.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<style>
/* General Body and Form Wrapper */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f7fafc; /* A light grey background */
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

/* Header and Logo */
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

/* Form Groups and Inputs */
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
    padding: 12px 15px 12px 40px; /* Left padding for icon */
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

/* Form Options (Forgot Password, etc.) */
.form-options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    font-size: 13px;
}

.form-options a {
    color: #249b69;
    text-decoration: none;
}

.form-options a:hover {
    text-decoration: underline;
}

/* Submit Button */
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

/* Link to switch between Login/Register */
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
                    <strong>Zinkit</strong>
                    <br>GROCERY
                </span>
            </a>
            <h2>Welcome Back!</h2>
            <p>Enter your credentials to access your account.</p>
        </div>

        <form action="./LoginServlet" method="POST">
            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" id="email" name="email" class="form-input" placeholder="your.email@example.com" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="password" name="password" class="form-input" placeholder="Enter your password" required>
                </div>
            </div>

            <div class="form-options">
                <div>
                    <%-- Optional: Remember me checkbox --%>
                </div>
                <a href="forgot-password.jsp">Forgot Password?</a>
            </div>

            <button type="submit" class="form-button">Login</button>

            <div class="form-switch-link">
                Don't have an account? <a href="register.jsp">Register Now</a>
            </div>
        </form>
        <% String errorMessage = (String) request.getAttribute("errorMessage");
	   if (errorMessage != null) { %>
	   <p style="color: red; text-align: center; font-weight: 500;">
	       <%= errorMessage %>
	   </p>
	<% } %>
        
    </div>

</body>

</html>