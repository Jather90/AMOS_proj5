<!-- 
 - Copyright (c) 2014 by Sven Huprich, Dimitry Abb, Jakob H�bler, Cindy Wiebe, Ferdinand Niedermayer, Dirk Riehle, http://dirkriehle.com
 -
 - This file is part of the Green Energy Cockpit for the AMOS Project.
 -
 - This program is free software: you can redistribute it and/or modify
 - it under the terms of the GNU Affero General Public License as
 - published by the Free Software Foundation, either version 3 of the
 - License, or (at your option) any later version.
 -
 - This program is distributed in the hope that it will be useful, 
 - but WITHOUT ANY WARRANTY; without even the implied warranty of
 - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 - GNU Affero General Public License for more details.
 -
 - You should have received a copy of the GNU Affero General Public
 - License along with this program. If not, see
 - <http://www.gnu.org/licenses/>.
 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="de.fau.amos.*"%> 
 <%@ page import="java.util.ArrayList"%>

 <% User.init(getServletConfig()); %>

<!DOCTYPE html>
<html>

				


<head>
<title>AMOS-Cockpit</title>
<link rel="stylesheet" href="../styles/style.css" type="text/css" />
</head>

<body>

<script>
					
function changeStartDays(){
	var day=document.getElementById("startDay").value;
	var month=document.getElementById("startMonth").value;
	var year=document.getElementById("startYear").value;
	
	var endDay=document.getElementById("endDay").value;
	var endMonth=document.getElementById("endMonth").value;
	var endYear=document.getElementById("endYear").value;
	
	var days;
	
	switch(month){
	case "1":
	case "3":
	case "5":
	case "7":
	case "8":
	case "10":
	case "12":
		days=31;
		break;
	case "2":
		if((year%4==0&&year%100!=0)||year%400==0){
			days=29;
		}else{
			days=28;
		}
		break;
	default:
		days=30;
	}
	
	document.getElementById("startDay").options.length = days;

	for(var i=1; i<=days; i++){
		document.getElementById("startDay").options[i-1].innerHTML=i;
		document.getElementById("startDay").options[i-1].value=i;
	}
	
	/*
	if(endYear<year){
		document.getElementById("endYear").selectedIndex=document.getElementById("startYear").selectedIndex;
		document.getElementById("endMonth").selectedIndex=document.getElementById("startMonth").selectedIndex;
		document.getElementById("endDay").selectedIndex=document.getElementById("startDay").selectedIndex;
	}else if(endYear==year&&endMonth<month){
		document.getElementById("endMonth").selectedIndex=document.getElementById("startMonth").selectedIndex;
		document.getElementById("endDay").selectedIndex=document.getElementById("startDay").selectedIndex;		
	}else if(endYear==year&&endMonth==month&&endDay<day){
		document.getElementById("endDay").selectedIndex=document.getElementById("startDay").selectedIndex;				
	}
	*/

}

function changeEndDays(){
	var startDay=document.getElementById("startDay").value;
	var startMonth=document.getElementById("startMonth").value;
	var startYear=document.getElementById("startYear").value;

	var day=document.getElementById("endDay").value;
	var month=document.getElementById("endMonth").value;
	var year=document.getElementById("endYear").value;

	var days;
	
	switch(month){
	case "1":
	case "3":
	case "5":
	case "7":
	case "8":
	case "10":
	case "12":
		days=31;
		break;
	case "2":
		if((year%4==0&&year%100!=0)||year%400==0){
			days=29;
		}else{
			days=28;
		}
		break;
	default:
		days=30;
	}
	
	document.getElementById("endDay").options.length = days;

	for(var i=1; i<=days; i++){
		document.getElementById("endDay").options[i-1].innerHTML=i;
		document.getElementById("endDay").options[i-1].value=i;
	}
	
	/*
	if(startYear>year){
		document.getElementById("startYear").selectedIndex=document.getElementById("endYear").selectedIndex;
		document.getElementById("startMonth").selectedIndex=document.getElementById("endMonth").selectedIndex;
		document.getElementById("startDay").selectedIndex=document.getElementById("endDay").selectedIndex;
	}else if(startYear==year&&startMonth>month){
		document.getElementById("startMonth").selectedIndex=document.getElementById("endMonth").selectedIndex;
		document.getElementById("startDay").selectedIndex=document.getElementById("endDay").selectedIndex;		
	}else if(startYear==year&&startMonth==month&&startDay>day){
		document.getElementById("startDay").selectedIndex=document.getElementById("endDay").selectedIndex;				
	}
	*/
}

</script>

	<header>
		<h1>AMOS PROJECT</h1>
 		<h2>Green Energy Cockpit</h2>
	</header>
	<div id="loginStateBox">
	Logged in as "<%out.print(session.getAttribute(Const.SessionAttributs.LOGGED_IN_USERNAME));%>"
	
	</div>
	    <nav id="menue">
        <ul>
    		<%out.println(Header.getHeaderButtons()); %>
        </ul>
    </nav>   

	<div id="completeContentBox">
		<div id="content">
			
			<%
			int selected=0;
			try{
				selected=Integer.parseInt(request.getParameter("selChart"));
			}catch(NumberFormatException e){
				selected=0;
			}
			int startDay=0;
			try{
				startDay=Integer.parseInt(request.getParameter("startDay"));
			}catch(NumberFormatException e){
				startDay=0;
			}
			int startMonth=0;
			try{
				startMonth=Integer.parseInt(request.getParameter("startMonth"));
			}catch(NumberFormatException e){
				startMonth=0;
			}
			int startYear=0;
			try{
				startYear=Integer.parseInt(request.getParameter("startYear"));
			}catch(NumberFormatException e){
				startYear=0;
			}
			int endDay=0;
			try{
				endDay=Integer.parseInt(request.getParameter("endDay"));
			}catch(NumberFormatException e){
				endDay=0;
			}
			int endMonth=0;
			try{
				endMonth=Integer.parseInt(request.getParameter("endMonth"));
			}catch(NumberFormatException e){
				endMonth=0;
			}
			int endYear=0;
			try{
				endYear=Integer.parseInt(request.getParameter("endYear"));
			}catch(NumberFormatException e){
				endYear=0;
			}
			int granularity=0;
			try{
				granularity=Integer.parseInt(request.getParameter("granularity"));
			}catch(NumberFormatException e){
				granularity=2;
			}		
			%>
			

						<form method="post" action="">
						Chart type:
							<select name="selChart">

								<option value="0"<% out.print(((selected==0)?" selected":"")+""); %>></option>
								<option value="1"<% out.print(((selected==1)?" selected":"")+""); %>>Area Chart</option>
								<option value="2"<% out.print(((selected==2)?" selected":"")+""); %>>Bar Chart</option>
								<option value="3"<% out.print(((selected==3)?" selected":"")+""); %>>Bar Chart 3D</option>
								<option value="4"<% out.print(((selected==4)?" selected":"")+""); %>>Line Chart</option>
								<option value="5"<% out.print(((selected==5)?" selected":"")+""); %>>Pie Chart</option>
								<option value="6"<% out.print(((selected==6)?" selected":"")+""); %>>Graph Chart</option>
							</select>		
							<br>			
						Start:
						
						<select name="startDay" id="startDay" onchange="changeStartDays();">
							<%for(int i=1;i<=31;i++){ %>
							<option value="<%=i %>"><%=i %></option>
							<%} %>
						</select>
						<select name="startMonth" id="startMonth" onchange="changeStartDays();">
							<%for(int i=1;i<=12;i++){ %>
							<option value="<%=i %>"><%=i %></option>
							<%} %>
						</select>
						<select name="startYear" id="startYear" onchange="changeStartDays();">
							<%for(int i=2000;i<=2020;i++){ %>
							<option value="<%=i %>"><%=i %></option>
							<%} %>
						</select>

						End:
						<select name="endDay" id="endDay" onchange="changeEndDays();">
							<%for(int i=1;i<=31;i++){ %>
							<option value="<%=i %>"><%=i %></option>
							<%} %>
						</select>
						<select name="endMonth" id="endMonth" onchange="changeEndDays();">
							<%for(int i=1;i<=12;i++){ %>
							<option value="<%=i %>"><%=i %></option>
							<%} %>
						</select>
						<select name="endYear" id="endYear" onchange="changeEndDays();">
							<%for(int i=2000;i<=2020;i++){ %>
							<option value="<%=i %>"><%=i %></option>
							<%} %>
						</select>
						Granularity:
						<select name="granularity" id = "granularity">
						    <option value="1"<% out.print(((granularity==1)?" selected":"")+""); %>>Hour</option>
						    <option value="2"<% out.print(((granularity==2)?" selected":"")+""); %>>Day</option>
						    <option value="3"<% out.print(((granularity==3)?" selected":"")+""); %>>Month</option>
						    <option value="4"<% out.print(((granularity==4)?" selected":"")+""); %>>Year</option>
						</select>
						
						
										
						<input type="submit" value="Show">
						
						</form>
	

				
	
			
			
			<%if(selected!=0){%>
			<img src="../ChartRenderer?param1=<%=selected %>&startDay=<%=startDay %>&startMonth=<%=startMonth %>&startYear=<%=startYear %>&endDay=<%=endDay %>&endMonth=<%=endMonth %>&endYear=<%=endYear %>&granularity=<%=granularity %>"/>
			<%}else{ %>

			<%} %>
					
		</div>
	</div>
</body>
</html>