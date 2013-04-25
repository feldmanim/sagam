﻿<%@page import="java.sql.ResultSet"%>
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
	<P>   דוח 2 - פחת לפי סוג חומר 1.56 70 mm <font color="black"></P>
	</h1>
</header>

 <section class='report-container'>


<table id="report1">

	<thead>
		<th> מספר עמדה  </th>
		<th> שם עמדה </th>
		<th> שם תקלה </th>
		<th> סה"כ פגומים </th>
		<th> סה"כ פחת </th>
		<th> עלות הפחת $ </th>


	</thead>


	<tbody>
		<%DBQuery query = new DBQuery();
		  int result = query.runUpdate("create table faults_per_material_and_station as SELECT ws.ID_workstation,ws.station_name, e.name, count(*) as amount_of_faults  FROM error e, faults f, workorder wo, workstation ws, row_materials rm WHERE wo.ID_workorder=f.workorder_ID and wo.material_name=\"1.56 70 mm\" and rm.material=wo.material_name and e.ID_workstation=ws.ID_workstation and e.error_barcode=f.fault_barcode  group by ws.id_workstation ;") ;
		  query.runUpdate("create table amortization_per_material_and_station as SELECT ws.ID_workstation,ws.station_name, e.name, count(*) as amount_of_amortization, (rm.cost*count(*)) as amortization_cost FROM error e, faults f, workorder wo, workstation ws, row_materials rm WHERE wo.ID_workorder=f.workorder_ID and wo.material_name=\"1.56 70 mm\" and rm.material=wo.material_name and e.ID_workstation=ws.ID_workstation and e.error_barcode=f.fault_barcode  and f.is_amortization=1 group by ws.id_workstation ;");
		  query.close();
		  
		  DBQuery selectQuery = new DBQuery();
		  ResultSet rs = selectQuery.runQuery(" SELECT fpmas.ID_Workstation, fpmas.station_name, fpmas.name as Error_name, fpmas.amount_of_faults, apmas.amount_of_amortization, apmas.amortization_cost FROM faults_per_material_and_station fpmas LEFT JOIN amortization_per_material_and_station apmas on (fpmas.ID_workstation=apmas.ID_workstation) ;");
		
		DBQuery dropQuery = new DBQuery();
		int dropResult = dropQuery.runUpdate("drop table `sagam`.`faults_per_material_and_station`;");
		dropQuery.runUpdate("drop table `sagam`.`amortization_per_material_and_station`;");
		dropQuery.close();
		
		  while (rs.next()){
			  %> <tr>
			  		<td><%= rs.getInt(1) %> </td>
			  		<td> <%= rs.getString(2) %> </td>
			  		<td> <%= rs.getString(3) %> </td>
			  		<td> <%= rs.getInt(4) %> </td>
			  		<td> <%= rs.getInt(5) %> </td>
			  		<td> <%= rs.getInt(6) %> </td>
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
