<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.src.model.Discount, com.src.model.DiscountType, com.src.dao.DiscountDaoImpl, com.src.dao.DiscountDao, com.src.service.DiscountServiceImpl, com.src.service.DiscountService" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    String discountId = request.getParameter("discountId");

    DiscountDao dao = new DiscountDaoImpl();
    DiscountService ds = new DiscountServiceImpl(dao);

    Discount discount = null;
    if (discountId != null && !discountId.trim().isEmpty()) {
        discount = ds.getDiscountById(discountId);
    }

    if (discount == null) {
        out.println("<h3>Invalid Discount ID or Discount not found.</h3>");
        return;
    }

    DecimalFormat df = new DecimalFormat("0.00");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Discount - Zinkit Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f7fafc; padding: 40px; }
        .container { max-width: 600px; margin: 0 auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        h2 { color: #249b69; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: 500; margin-bottom: 5px; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .btn { padding: 12px 20px; background-color: #249b69; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: 600; }
        .btn:hover { background-color: #1e8258; }
        .cancel-btn { background-color: #6c757d; margin-left: 10px; }
	     .back-link {
	            display: inline-block;
	            margin-bottom: 15px;
	            color: #249b69;
	            text-decoration: none;
	            font-weight: 500;
	        }
    </style>
</head>
<body>
    <div class="container">
        <a href="manageDiscounts.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Discounts</a>
        <h2>Edit Discount - <%= discount.getName() %></h2>

        <form action="editDiscount" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="discountId" value="<%= discount.getId() %>">

            <div class="form-group">
                <label for="discountName">Discount Name / Code</label>
                <input type="text" id="discountName" name="discountName" value="<%= discount.getName() %>" required>
            </div>

            <div class="form-group">
                <label for="discountType">Discount Type</label>
                <select id="discountType" name="discountType" required>
                    <% for (DiscountType type : DiscountType.values()) { %>
                        <option value="<%= type.name() %>" <%= type == discount.getType() ? "selected" : "" %>><%= type.name() %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="discountValue">Discount Value</label>
                <input type="number" id="discountValue" name="discountValue" value="<%= df.format(discount.getValue()) %>" required min="0.01" step="0.01">
            </div>

            <div class="form-group">
                <label for="isPercentage">Discount Mode</label>
                <select id="isPercentage" name="isPercentage" required>
                    <option value="true" <%= discount.isPercentage() ? "selected" : "" %>>Percentage (%)</option>
                    <option value="false" <%= !discount.isPercentage() ? "selected" : "" %>>Flat (₹)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="minCartValue">Minimum Cart Value (₹)</label>
                <input type="number" id="minCartValue" name="minCartValue" value="<%= df.format(discount.getMinCartValue()) %>" min="0" step="0.01">
            </div>

            <div class="form-group">
                <label for="active">Status</label>
                <select id="active" name="active">
                    <option value="true" <%= discount.isActive() ? "selected" : "" %>>Active</option>
                    <option value="false" <%= !discount.isActive() ? "selected" : "" %>>Inactive</option>
                </select>
            </div>

            <button type="submit" class="btn">Update Discount</button>
            <a href="manageDiscounts.jsp"><button type="button" class="btn cancel-btn">Cancel</button></a>
        </form>
    </div>
</body>
</html>
