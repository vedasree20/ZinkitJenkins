<%@ page import="java.util.List, com.src.model.Discount" %>
<%@ page import="javax.ws.rs.client.Client, javax.ws.rs.client.ClientBuilder, javax.ws.rs.client.WebTarget" %>
<%@ page import="javax.ws.rs.core.GenericType, javax.ws.rs.core.MediaType" %>
<%@ page import="com.src.model.DiscountWrapper" %>

<%
    // Create Jersey client
    Client client = ClientBuilder.newClient();
    WebTarget target = client.target("http://localhost:8082/ZinkitJersey/webresources/myresource/search");

    
    // Fetch list of products

		DiscountWrapper wrapper = target.request(MediaType.APPLICATION_JSON)
		                                .get(DiscountWrapper.class);
		
		List<Discount> products = wrapper.getDiscount();


%>

<table border="1">
    <tr><th>Name</th><th>Type</th><th>Value</th><th>MinCartPrice</th></tr>
    <%
        for(Discount p : products){
    %>
    <tr>
        <td><%= p.getName() %></td>
        <td><%= p.getType() %></td>
        <td><%= p.getValue() %></td>
        <td><%= p.getMinCartValue() %></td>
    </tr>
    <%
        }
    %>
</table>
