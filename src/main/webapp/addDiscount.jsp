<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.src.model.User, com.src.model.DiscountType" %>
<%@ page import="java.time.LocalDate" %>

<%
    User currentUser = (User) session.getAttribute("loggedInUser");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Discount - Zinkit Admin</title>
    <link rel="icon" type="image/png" href="https://i.pinimg.com/1200x/f8/03/c0/f803c090e8639b97976991333c52d1ef.jpg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7fafc;
            margin: 0;
            color: #333;
        }

        .admin-container {
            max-width: 700px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .admin-header {
            text-align: center;
            border-bottom: 2px solid #eee;
            margin-bottom: 30px;
            padding-bottom: 15px;
        }

        .admin-header h2 {
            color: #249b69;
            font-size: 28px;
            margin: 0;
        }

        .admin-header p {
            color: #777;
            margin-top: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-input-full {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }

        select.form-input-full {
            background-color: white;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 25px;
        }

        .primary-button {
            padding: 12px 20px;
            background-color: #249b69;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
        }

        .primary-button:hover {
            background-color: #1e8258;
        }

        .cancel-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background-color: #5a6268;
        }

        .message {
            padding: 10px;
            margin: 15px 0;
            border-radius: 5px;
            text-align: center;
            font-weight: 600;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .error-message {
            color: #d93025;
            font-size: 13px;
            margin-top: 5px;
            display: none;
        }

        .form-input-full.error {
            border-color: #d93025;
            background-color: #fff5f5;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 15px;
            color: #249b69;
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <div class="admin-container" style="margin-top:50px">
        <a href="manageDiscounts.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Discounts</a>

        <div class="admin-header">
            <h2>Add New Discount</h2>
            <p>Fill in the details below to create a new discount offer.</p>
        </div>

        <% if (successMessage != null) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>
        <% if (errorMessage != null) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>

        <form id="discountForm" action="addDiscount" method="POST" novalidate>
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="discountName">Discount Code / Name</label>
                <input type="text" id="discountName" name="discountName" class="form-input-full" placeholder="e.g., NEWYEAR25" required>
                <span class="error-message" id="nameError">Please enter a valid discount name.</span>
            </div>

            <div class="form-group">
                <label for="discountType">Discount Type</label>
                <select id="discountType" name="discountType" class="form-input-full" required>
                    <% for (DiscountType type : DiscountType.values()) { %>
                        <option value="<%= type.name() %>"><%= type.name() %></option>
                    <% } %>
                </select>
                <span class="error-message" id="typeError">Please select a discount type.</span>
            </div>

            <div class="form-group">
                <label for="discountValue">Discount Value</label>
                <input type="number" id="discountValue" name="discountValue" class="form-input-full"
                    placeholder="Enter amount or percentage" required min="0.01" step="0.01">
                <span class="error-message" id="valueError">Enter a valid discount value greater than 0.</span>
            </div>

            <div class="form-group">
                <label for="isPercentage">Discount Mode</label>
                <select id="isPercentage" name="isPercentage" class="form-input-full" required>
                    <option value="true">Percentage (%)</option>
                    <option value="false">Flat (₹)</option>
                </select>
                <span class="error-message" id="modeError">Please select a discount mode.</span>
            </div>

            <div class="form-group">
                <label for="minCartValue">Minimum Cart Value (₹)</label>
                <input type="number" id="minCartValue" name="minCartValue" class="form-input-full"
                    placeholder="e.g., 500" required min="0" step="0.01">
                <span class="error-message" id="cartError">Enter a valid minimum cart value.</span>
            </div>

            <div class="form-group">
                <label for="active">Status</label>
                <select id="active" name="active" class="form-input-full" required>
                    <option value="true" selected>Active</option>
                    <option value="false">Inactive</option>
                </select>
                <span class="error-message" id="statusError">Please select the status.</span>
            </div>

            <div class="form-actions">
                <button type="button" class="cancel-btn" onclick="window.location.href='manageDiscounts.jsp'">Cancel</button>
                <button type="submit" class="primary-button"><i class="fa-solid fa-floppy-disk"></i> Save Discount</button>
            </div>
        </form>
    </div>

    <script>
 // Grab input elements
    const discountName = document.getElementById("discountName");
    const discountValue = document.getElementById("discountValue");
    const discountType = document.getElementById("discountType");
    const isPercentage = document.getElementById("isPercentage");
    const minCartValue = document.getElementById("minCartValue");
    const active = document.getElementById("active");

    // Helper to show/hide errors
    function toggleError(input, errorId, condition, message) {
        const error = document.getElementById(errorId);
        if (condition) {
            error.style.display = "block";
            error.textContent = message;
            input.classList.add("error");
        } else {
            error.style.display = "none";
            input.classList.remove("error");
        }
    }

    // Real-time validation
    discountName.addEventListener("input", () => {
        toggleError(discountName, "nameError", discountName.value.trim() === "", "Please enter a valid discount name.");
    });

    discountValue.addEventListener("input", () => {
        const value = parseFloat(discountValue.value);
        if (isPercentage.value === "true") {
            toggleError(discountValue, "valueError", isNaN(value) || value <= 0 || value > 100, "Percentage must be between 0 and 100.");
        } else {
            toggleError(discountValue, "valueError", isNaN(value) || value <= 0, "Enter a valid discount amount.");
        }
    });

    minCartValue.addEventListener("input", () => {
        const value = parseFloat(minCartValue.value);
        toggleError(minCartValue, "cartError", isNaN(value) || value < 0, "Enter a valid minimum cart value.");
    });

    discountType.addEventListener("change", () => {
        toggleError(discountType, "typeError", discountType.value === "", "Please select a discount type.");
    });

    isPercentage.addEventListener("change", () => {
        const value = parseFloat(discountValue.value);
        if (isPercentage.value === "true") {
            toggleError(discountValue, "valueError", isNaN(value) || value <= 0 || value > 90, "Percentage must be between 0 and 100.");
        } else {
            toggleError(discountValue, "valueError", isNaN(value) || value <= 0, "Enter a valid discount amount.");
        }
    });

    active.addEventListener("change", () => {
        toggleError(active, "statusError", active.value === "", "Please select the status.");
    });

    // Optional: prevent form submission if invalid
    document.getElementById("discountForm").addEventListener("submit", function(event) {
        // Trigger all validations
        discountName.dispatchEvent(new Event('input'));
        discountValue.dispatchEvent(new Event('input'));
        minCartValue.dispatchEvent(new Event('input'));
        discountType.dispatchEvent(new Event('change'));
        isPercentage.dispatchEvent(new Event('change'));
        active.dispatchEvent(new Event('change'));

        // Check if any errors visible
        if (document.querySelectorAll(".error-message[style*='block']").length > 0) {
            event.preventDefault();
        }
    });

    </script>
</body>
</html>
