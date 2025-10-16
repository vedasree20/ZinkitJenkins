<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Zinkit Grocery</title>
        <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="forms.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<style>
/* --- Styling same as previous form --- */
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
    max-width: 500px;
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
    margin-bottom: 18px;
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
    margin-top: 10px;
}

.form-button:hover {
    background-color: #1e8258;
}

.form-switch-link {
    text-align: center;
    margin-top: 20px;
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
              <% String successMessage = (String) request.getAttribute("successMessage");
           if (successMessage != null) { %>
           <p style="color: green; text-align: center; font-weight: 500;">
               <%= successMessage %>
           </p>
        <% } %>
        
        <% String errorMessage = (String) request.getAttribute("errorMessage");
           if (errorMessage != null) { %>
           <p style="color: red; text-align: center; font-weight: 500;">
               <%= errorMessage %>
           </p>
        <% } %>
    
        <div class="form-header">
            <a href="index.jsp" class="logo">
                <img src="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg" alt="Zinkit Logo">
                <span><strong>Zinkit</strong><br>GROCERY</span>
            </a>
            <h2>Create Account</h2>
            <p>Join Zinkit and enjoy easy grocery delivery.</p>
        </div>

        <form action="./RegisterServlet" method="POST">

            <div class="form-group">
                <label for="username">Full Name</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" id="username" name="username" class="form-input" placeholder="e.g., Veda Sree" required>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" id="email" name="email" class="form-input" placeholder="your.email@example.com" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="password" name="password" class="form-input" placeholder="Create a strong password" required>
                </div>
            </div>

            <div class="form-group">
                <label for="phone">Phone</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-phone"></i>
                    <input type="text" id="phone" name="phone" class="form-input" placeholder="e.g., 9876543210" required>
                </div>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-location-dot"></i>
                    <input type="text" id="address" name="address" class="form-input" placeholder="House No, Street, Locality" required>
                </div>
            </div>

            <div class="form-group">
                <label for="city">City</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-city"></i>
                    <input type="text" id="city" name="city" class="form-input" placeholder="e.g., Hyderabad" required>
                </div>
            </div>

            <div class="form-group">
                <label for="state">State</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-flag"></i>
                    <input type="text" id="state" name="state" class="form-input" placeholder="e.g., Telangana" required>
                </div>
            </div>

            <div class="form-group">
                <label for="pincode">Pincode</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-map-pin"></i>
                    <input type="text" id="pincode" name="pincode" class="form-input" placeholder="e.g., 500001" required>
                </div>
            </div>

            <button type="submit" class="form-button">Register</button>

            <div class="form-switch-link">
                Already have an account? <a href="login.jsp">Login</a>
            </div>
        </form>
    </div>
<script>
document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    const fields = {
        email: {
            regex: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            message: "Enter a valid email address"
        },
        password: {
            regex: /^.{6,}$/,
            message: "Password must be at least 6 characters"
        },
        phone: {
            regex: /^[0-9]{10}$/,
            message: "Enter a 10-digit phone number"
        },
        pincode: {
            regex: /^[0-9]{6}$/,
            message: "Enter a 6-digit pincode"
        }
    };

    // Function to create message span if not exists
    const ensureMessageSpan = (input) => {
        let msg = input.parentElement.querySelector(".msg");
        if (!msg) {
            msg = document.createElement("small");
            msg.classList.add("msg");
            msg.style.color = "#e63946";
            msg.style.display = "block";
            msg.style.marginTop = "4px";
            input.parentElement.appendChild(msg);
        }
        return msg;
    };

    // Add live listeners
    Object.keys(fields).forEach(id => {
        const input = document.getElementById(id);
        if (!input) return;

        const { regex, message } = fields[id];
        const msg = ensureMessageSpan(input);

        input.addEventListener("input", () => {
            if (input.value.trim() === "") {
                msg.textContent = "";
                input.style.borderColor = "#ddd";
            } else if (!regex.test(input.value.trim())) {
                msg.textContent = message;
                input.style.borderColor = "#e63946";
            } else {
                msg.textContent = "";
                input.style.borderColor = "#249b69";
            }
        });
    });

    // Simple empty check for text fields
    ["username", "address", "city", "state"].forEach(id => {
        const input = document.getElementById(id);
        const msg = ensureMessageSpan(input);
        input.addEventListener("input", () => {
            if (input.value.trim() === "") {
                msg.textContent = "This field is required";
                input.style.borderColor = "#e63946";
            } else {
                msg.textContent = "";
                input.style.borderColor = "#249b69";
            }
        });
    });

    // Auto-generate hidden userId before submit
    form.addEventListener("submit", (e) => {
        const userId = "USER_" + Date.now();
        const hidden = document.createElement("input");
        hidden.type = "hidden";
        hidden.name = "userId";
        hidden.value = userId;
        form.appendChild(hidden);
    });
});
</script>

</body>
</html>
