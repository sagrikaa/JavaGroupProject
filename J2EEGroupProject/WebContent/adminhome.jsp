<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/j2eeproject"
                           user="root"  password="123"/>
<sql:query var="result" dataSource="${dbsource}">
	SELECT * FROM j2eeproject.user; 
</sql:query>
<c:forEach var="row" items="${ result.rows}">
	<c:if test="${param.uname eq row.username}">
		<c:set var="userName" value="${row.username }"></c:set>
		<c:set var="Name" value="${row.name }"></c:set>
		<c:set var="email" value="${row.email }"></c:set>
		<c:set var="address" value="${row.address }"></c:set>
	</c:if>
</c:forEach>
								
<title>Welcome! <c:out value="${Name }"></c:out></title></head>
<style>
  * {
    box-sizing: border-box; 
  }
  body {
    display: flex;
    min-height: 100vh;
    flex-direction: row;
    margin: 0;
  }
  .col-1 {
    background: #D7E8D4;
    flex: 1;
  }
  .col-2 {
    display: flex;
    flex-direction: column;
    flex: 5;
  }
  .content {
    display: flex;
    flex-direction: row;
  }
  .content > article {
    flex: 4;
    min-height: 60vh;
  }
  header, footer {
    background: Grey;
    height: 20vh;
  }
  header, footer, article, nav {
    padding: 1em;
  }
</style>
</head>
<body>
  <nav class="col-1">Nav
  	bsdjsjdn
  	<br>
  	<c:out value="${Name }"></c:out>  </nav>
  <div class="col-2">
  	<header>Header</header>
    <main class="content">
    <article>Article</article>
    </main>
  </div>
</body>
</html>