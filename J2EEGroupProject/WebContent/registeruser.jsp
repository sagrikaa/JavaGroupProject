<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Register</title>
<style type="text/css">
			.error-field{
				border: 1px;
				color: red;
				border-radius: 3px;
				background-color: #e8e4e3;
				padding: 10px;
				margin-left:2em;
				margin-right:4em;
				margin-bottom: .5em;
			}
</style>
<script>
	function confirmCancel(msg,link) {
		if(confirm(msg)){
			window.location = link;
		}
	}
</script>

</head>
<body>

<sql:setDataSource var="dbCon" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/j2eeproject" user="root" password="123"></sql:setDataSource>
<center>
<c:if test="${  (param.submit != null)}">
	
		<c:set var="uname" value="${param.user_name }"></c:set>
		<c:set var="name" value="${param.name }"></c:set>
		<c:set var="password" value="${param.password }"></c:set>
		<c:set var="phno" value="${param.phone }"></c:set>
		<c:set var="email" value="${param.email }"></c:set>
		<c:set var="address" value="${param.address }"></c:set>
		<c:set var="confirm" value="${param.check_password }"></c:set>
		<c:set var="eml" value="^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$"></c:set>
		
	
		<c:if test="${ email.matches(eml) }" var="validemail"></c:if>
		<c:if test="${password eq confirm}" var="matchpassword"></c:if>
		<c:if test="${(phno.length() eq 10) and phno.matches('[0-9]+')}" var="validphone"></c:if>
		
        <c:choose>
        	<c:when test="${ (not empty uname) and (not empty name) and (not empty password) and (not empty phno) and (not empty email) and (not empty address) and (not empty confirm)}">
		        	<c:choose>
		        		
		        		<c:when test="${(uname.length() > 5) and (uname.length() < 15) }">
		        				<c:choose>
					        			<c:when test="${ validphone and validemail and matchpassword}" >
									        <sql:update dataSource="${dbCon}" var="result">
									            INSERT INTO j2eeproject.user(username,name,password,phone,address,email,isadmin) VALUES (?,?,?,?,?,?,?);
									            <sql:param value="${param.user_name}" />
									            <sql:param value="${param.name}" />
									            <sql:param value="${param.password}" />
									            <sql:param value="${param.phone}" />
									            <sql:param value="${param.email}" />
									            <sql:param value="${param.address}" />
										        <sql:param value="${0}" />
							        		</sql:update>
					        			</c:when>
					        			<c:otherwise>
					        						<c:if test="${not validphone }"><p class="error-field"><c:out  value="Invalid phone number"></p></c:out></c:if>
					        						<c:if test="${not validemail }"><p class="error-field"><c:out  value="Invalid email"></c:out></p></c:if>
					        						<c:if test="${not matchpassword }"><p class="error-field"><c:out  value="Password does not match"></p></c:out></c:if>
					        			</c:otherwise>
					        		</c:choose>	
		        		</c:when>
		        			
		        		<c:otherwise>
		        			<p class="error-field"><c:out  value="User name length must be between 5 charcters and 15"></c:out></p>
		        		</c:otherwise>
		        	
		        	</c:choose>
        	</c:when>
        	<c:otherwise>
        		<p class="error-field"><c:out value="All The fields are required!"></c:out></p>
        	</c:otherwise>
        </c:choose>
		
		
        
 
 </c:if>

	<!-- REGISTER FORM -->
	<h1 style="font-size: 3em;display: block; background-color:#257a5f;color:white;border:1px solid black"> User Register Form</h1>
	<form  method="post">
	<fieldset>
	<legend></legend>
		<div>
				<table>
					 	<tr><td> Name:</td><td><input type="text" name="name"></td></tr>
				     
				 	<tr><td>User Name:</td><td><input type="text" name="user_name"></td></tr>
				     
					<tr><td>Password:</td><td><input type="password" name="password"></td></tr>
					 
					<tr><td>Re-enter Password:</td><td><input type="password" name="check_password"></td></tr>
					 
					<tr><td>Contact Number:</td><td><input type="text" name="phone"></td></tr>
					 
					<tr><td> Email:</td><td><input type="text" name="email"></td></tr>
					 
					<tr><td> Address:</td><td><input type="text" name="address"></td></tr>
					 
					<tr><td> <input type="submit" name="submit" value="Submit">
						<a  href="javascript:confirmCancel('Cancel Registration','login.jsp')"> Cancel Registration</a></tr>
					 <c:if test="${result>=1}">
            			<font size="5" color='green'> Congratulations ! You are now a member.</font>
 						<c:redirect url="userhome.jsp" >
                			<c:param name="susMsg" value="Congratulations ! Account Created!." />
            			</c:redirect>
        			</c:if> 
        		</table>
		</div>
	</fieldset>
	</form>
</center>	

</body>
</html>