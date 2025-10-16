<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Zinkit Grocery</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <style>
        /* General Setup */
        body { 
            font-family: 'Poppins', sans-serif; 
            background: #f7f7f7; /* Light gray background */
            color: #333;
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            margin: 0;
        }

        /* Form Container */
        .form-container { 
            background: white; 
            padding: 40px; 
            border-radius: 12px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); 
            width: 100%;
            max-width: 400px; /* Standard form width */
            border-top: 5px solid #249b69; /* Zinkit green accent */
        }

        /* Form Header */
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-header h2 { 
            color: #249b69; /* Primary Zinkit color */
            font-size: 28px; 
            font-weight: 700;
            margin: 0 0 5px 0;
        }
        .form-header p {
            color: #777;
            font-size: 14px;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #555;
            margin-bottom: 8px;
        }

        /* Input Wrapper with Icon */
        .input-wrapper {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 0 15px;
            background-color: #fff;
            transition: border-color 0.3s;
        }
        .input-wrapper:focus-within {
            border-color: #249b69;
            box-shadow: 0 0 0 3px rgba(36, 155, 105, 0.1);
        }

        .input-wrapper i {
            color: #999;
            font-size: 16px;
            margin-right: 10px;
        }

        .form-input {
            border: none;
            flex-grow: 1;
            padding: 12px 0;
            font-size: 15px;
            outline: none;
        }
        
        /* Submit Button */
        .form-button {
            width: 100%;
            padding: 12px;
            background: #249b69;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s, transform 0.2s;
        }
        .form-button:hover {
            background: #1e8258;
            transform: translateY(-1px);
        }
        
        /* Switch Link */
        .form-switch-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .form-switch-link a {
            color: #249b69;
            text-decoration: none;
            font-weight: 500;
        }
        .form-switch-link a:hover {
            text-decoration: underline;
        }

        /* Message Display */
        p[style*="color:red"] {
            color: #e74c3c !important; /* Standard error red */
            font-size: 14px;
            margin-top: 15px;
            padding: 10px;
            background: #fbecec;
            border: 1px solid #f0b5b5;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <h2>Reset Password</h2>
            <p>Enter your new password below.</p>
        </div>

        <form action="ResetPasswordServlet" method="POST">
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="Min 8 characters" required>
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="Re-enter password" required>
                </div>
            </div>

            <button type="submit" class="form-button">Update Password</button>

            <div class="form-switch-link">
                <a href="login.jsp">Back to Login</a>
            </div>
        </form>

        <% String msg = (String) request.getAttribute("message");
           if (msg != null) { %>
           <p style="color:red;text-align:center;"><%= msg %></p>
        <% } %>
    </div>
</body>
</html>