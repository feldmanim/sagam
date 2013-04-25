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
	<P>   דוח 4- דוח פגומים ע"פ סיבת כשל <font color="black"></P>
	</h1>
</header>

 <section class='report-container'>


<table id="report1">

	<thead>
		<th> שם תקלה  </th>
		<th> מספר תקלות </th>
		<th> סה"כ פחת </th>
		


	</thead>


	<tbody>
		<%DBQuery query = new DBQuery();
		  int result = query.runUpdate("CREATE TABLE tmp_faults SELECT e.name as Error_Name, count(*) as amount_of_faults FROM error e, faults f, workorder wo, workstation ws, row_materials rm WHERE wo.ID_workorder=f.workorder_ID and rm.material=wo.material_name and e.ID_workstation=ws.ID_workstation and e.error_barcode=f.fault_barcode group by e.name ;") ;
		  query.runUpdate("CREATE TABLE tmp_Amortization SELECT e.name as Error_Name, count(*) as amount_of_Amortization FROM error e, faults f, workorder wo, workstation ws, row_materials rm WHERE wo.ID_workorder=f.workorder_ID and rm.material=wo.material_name and e.ID_workstation=ws.ID_workstation and e.error_barcode=f.fault_barcode  and f.is_amortization=1 group by e.name ;");
		  query.close();
		  
		  DBQuery selectQuery = new DBQuery();
		  ResultSet rs = selectQuery.runQuery("SELECT tf.error_name, tf.amount_of_faults, ta.amount_of_amortization FROM tmp_faults tf LEFT JOIN tmp_amortization ta on (tf.error_name=ta.error_name) ;");
		
		DBQuery dropQuery = new DBQuery();
		int dropResult = dropQuery.runUpdate("drop table `sagam`.`tmp_faults`;");
		dropQuery.runUpdate("drop table `sagam`.`tmp_amortization`;");
		dropQuery.close();
		
		  while (rs.next()){
			  %> <tr>
			  		<td><%= rs.getString(1) %> </td>
			  		<td> <%= rs.getInt(2) %> </td>
			  		<td> <%= rs.getInt(3) %> </td>
			  		
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
