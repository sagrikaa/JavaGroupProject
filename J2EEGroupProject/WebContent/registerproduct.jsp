<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Product</title>

<%@ page import="java.sql.*" %>
</head>
<body>

<%!
 String serial_no,product_id,user_name,date;
int count;
 float price,weight;
%>
<%
// Connect to the server
Class.forName("com.mysql.jdbc.Driver");
  String username="root";
  String password="12345";
  String url ="jdbc:mysql://localhost:3306/j2eeproject" ;
  Connection con = DriverManager.getConnection(url, username, password); 
// create statement
Statement st= con.createStatement();
// formulate and execute the query
String product = "Select * from products";
ResultSet rs = st.executeQuery(product);



%>



<div>
		<!-- REGISTER FORM -->
	<h1 style="font-size: 3em;display: block; background-color:#257a5f;color:white;border:1px solid black"> Product Register Form</h1>
	<form  method="post">
	<fieldset>
	<legend></legend>
		<div>
				<table>
					 	<tr><td> Serial Number:</td><td><input type="text" name="serial_no"></td><td>Enter the serial number on the bottom of the appliance</td></tr>
				     
				 	<tr><td>Product Name:</td>
				 	<td> 
				 	<select name="product">
						<% while(rs.next()){ 	%>
						  <option value=<%=rs.getString(1) %>>   <%=rs.getString(2) %> </option>
						  <%} %>
					</select>
				 	</td></tr>
				     
					<tr><td>User Name:</td><td><input type="text" name="user_name"></td></tr>
					 
					<tr><td>Date of Purchase:</td><td><input type="text" name="dop"></td></tr>
					 
					
					 
					<tr><td> <input type="submit" name="submit" value="Submit">
						<a  href="javascript:confirmCancel('Cancel Registration','login.jsp')"> Cancel Registration</a></tr>
					<%
					if(count >= 1){
					%>
						<p>Product is registered.</p>
						
						<%}%>
					
					
				
        		</table>
		</div>
	</fieldset>
	</form>
</center>	
</div>


<%
if(request.getParameter("submit")!=null){
	 
		serial_no=request.getParameter("serial_no");
		product_id=request.getParameter("product");
		user_name=request.getParameter("user_name");
		date=request.getParameter("dop");
	
		String query1= "insert into product_purchase values('"+ serial_no  +"','" +product_id+ "','"+user_name+"','"+date+"');";
		count=st.executeUpdate(query1);
		
		con.close();
		
}
	%>

</body>
</html>