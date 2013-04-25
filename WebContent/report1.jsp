<%@page import="java.sql.ResultSet"%>
<%@page import="sagam.DBQuery"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>SAGAM Log In</title>
	<link rel="stylesheet" href="html5reset.css" type="text/css" />
	<link rel="stylesheet" href="html5semanticmarkup.css" type="text/css" />
 	<!--[if lt IE 9]>
 		<script src="html5.js"></script>
 	<![endif]-->
</head>
<body>

	<header>
 		<hgroup>
		<img src="Sagam_Logo.png" id="logo" /> 
 		<h1>מערכת לבקרת הפחת </h1>
 		<h2>  </h2>
 		</hgroup>
 	</header>
	
<nav>	
		<ul>
	 		<li><a href="report.html">דוחות </a></li>
 			<li><a href="#">הגדרות</a></li>
 			<li><a href="#">עזרה</a></li>
			<li><a href="#">יציאה</a></li>
 			
 		</ul>
 	</nav>
<article>
<header>
 	<h1> 
	<P> <font color="grey">דוחות </P> 
	<P>  דוח 1 - פחת כולל <font color="black"></P>
	</h1>
</header>

 <section class='report-container'>


<table id="report1">

	<thead>
		<th> חומר גלם  </th>
		<th> עלות $ </th>
		<th> סה"כ יוצר ביחידות </th>
		<th> סה"כ פגומים </th>
		<th> סה"כ פחת </th>
		<th> אחוז פחת </th>
		<th> עלות הפחת $ </th>

	</thead>


	<tbody>
		<%DBQuery query = new DBQuery();
		  int result = query.runUpdate("create table Amortization as " + 
				  "SELECT material, cost,count(*) as amount_of_amortization, (cost*count(*)) as Total_Cost "+
				  "FROM sagam.faults f,sagam.workorder wo,sagam.row_materials m " +
				  "Where " +
				  "f.Workorder_ID=wo.ID_Workorder and " +
				  "wo.material_name=m.material and " +
				  "f.is_amortization=1 " +
				  "group by material ;");
		  query.runUpdate(" create table Ordered_Materials as  "+
				 " SELECT Material, cost as Cost,count(*) Total_Ordered, (cost*count(*)) as Total_Cost "+
				 " FROM sagam.row_materials m, sagam.workorder wo "+
				 " WHERE "+
				 " 	m.material = wo.material_name "+
				 " group by material "+
				 " ;  ");
		  query.runUpdate(" create table number_of_faults as  "+
				 " SELECT material, cost,count(*) as amount_of_faults, (cost*count(*)) as Total_Cost "+ 
				 " FROM sagam.faults f,sagam.workorder wo,sagam.row_materials m "+
				 " Where "+
				 " f.Workorder_ID=wo.ID_Workorder and "+
				 " wo.material_name=m.material "+ 
				 " group by material "+
				 " ; ");
		  query.close();
		  
		  DBQuery selectQuery = new DBQuery();
		  ResultSet rs = selectQuery.runQuery(" select nof.material, nof.cost, r.Total_ordered, nof.amount_of_faults,a.amount_of_amortization, "+
					 " 	round((a.amount_of_amortization/r.total_ordered)*100) as Percentage, a.Total_cost as Amortization_Cost "+
					 " from number_of_faults nof "+
					 " left join amortization a on (a.material=nof.material) "+
					 " left join ordered_materials r on (r.material=nof.material) "+
					 " ; ");
		
		DBQuery dropQuery = new DBQuery();
		int dropResult = dropQuery.runUpdate(" drop table `sagam`.`amortization`; ");
		dropQuery.runUpdate(" drop table `sagam`.`number_of_faults`; ");
		dropQuery.runUpdate(" drop table `sagam`.`ordered_materials`;");
		dropQuery.close();
		
		  while (rs.next()){
			  %> <tr>
			  		<td><%= rs.getString(1) %> </td>
			  		<td> <%= rs.getInt(2) %> </td>
			  		<td> <%= rs.getInt(3) %> </td>
			  		<td> <%= rs.getInt(4) %> </td>
			  		<td> <%= rs.getInt(5) %> </td>
			  		<td> <%= rs.getInt(6) %> </td>
			  		<td> <%= rs.getInt(7) %> </td>
		  		</tr> <%
		  }
		  selectQuery.close();
		%>
	<!-- 
		<tr>
			<td>זכוכית 65  </td>
			<td>  47</td>
			<td>4  </td>
			<td> 3 </td>
			<td>  2</td>
			<td>  66</td>
			<td>  94</td>
		</tr>

 -->	</tbody>
	</Table>

 </section>
</article>
<footer>

 </footer>

</body>
</html>
