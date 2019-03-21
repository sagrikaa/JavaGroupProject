<!-- User Login Page-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    
<!DOCTYPE html>
<html>
<head>
		<meta charset="ISO-8859-1">
		<title>Login User</title>
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
		<script type="text/javascript">
				function showalert(u) {
					alert("username:"+u);
				}
		</script>
</head>
<body >
<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/j2eeproject"
                           user="root"  password="123"/>
		<center>
			<div style="font-size: 3em;display: block; background-color:#257a5f;color:white;border:1px solid black;">
				
					<strong>
					Welcome to ABC
					</strong>
				</h1>
			</div>
			<p>Please log in to register the product (s)</p>
		</center>
	<div >
	<form method="post">
		<fieldset >
			<legend >Login</legend>
			<br>
			<center>
			<table>
				<tr>
					<td>User Id :</td>
					<td><input type="text" name="username" placeholder="user name"></td>
				</tr>
				<tr>
					<td>Password :</td>
					<td><input type="password" name="password" placeholder="Password"></td>
				</tr>
				<tr>
					<td><input type="submit" name="login" value="Log In"></td>
					<td><a href="registeruser.jsp"> do not have an account, create one!.</a></td>
					
					<!-- Checking the submit is Pressed -->
					<c:if test="${param.login != null }">
					
					<!--assign the values to variables -->
						<c:set var="userName" value="${ param.username}"></c:set>
						<c:set var="password" value="${ param.password}"></c:set>
						<c:choose>
							<c:when test="${(not empty userName) and ( not empty password)}">
								
								<!--check weather the user exists or not using database-->
								<sql:query var="result" dataSource="${dbsource}">
									SELECT * FROM j2eeproject.user; 
								</sql:query>
								<c:forEach var="row" items="${result.rows }">
									<c:choose>
										<c:when test="${userName eq row.username }">
											<c:if test="${row.isadmin eq 1 }">
												
												<!-- redirecting to admin-->
												<c:redirect url="adminhome.jsp">
													<c:param name="uname" value="${userName }"></c:param>
												</c:redirect>
											</c:if>
											<c:if test="${row.isadmin eq 0 }">
												<!-- redirecting to general user-->
												<c:redirect url="userhome.jsp">
													<c:param name="uname" value="${ row.username}"></c:param>
												</c:redirect>
											</c:if>
										</c:when>		
									</c:choose>
								</c:forEach>
									<span class="error-field"><c:out value="Invalid Credentials! Try again."></c:out></span>
									<br><br><br>
								</c:when>	
							<c:otherwise>
								<span class="error-field">
									* Username and Password cannot be less than 2 characters.
								</span>	
								<br><br><br>
							</c:otherwise>
						</c:choose>		
					</c:if>
				</tr>
			</table>
			</center>
		</fieldset>
	</form>
	
	
</div>
</body>
</html>