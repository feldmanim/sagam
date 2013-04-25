<%@page import="java.sql.ResultSet"%>
<%@page import="sagam.DBQuery"%>
<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<LINK href="mystyle.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th> Fault ID </th>
			<th> Time </th>
		</tr>
		<%DBQuery query = new DBQuery();
		  ResultSet rs = query.runQuery("select * from faults");
		  while (rs.next()){
			  %> <tr><td><%= rs.getInt(1) %> </td> <td> <%= rs.getTimestamp(3) %> </td></tr> <%
		  }
		  query.close();
		%>
 	</table>
</body>
</html>