<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//28.7 104.3165
if(session.getAttribute("Longitude")==null){
	session.setAttribute("Longitude",28.7f);
}
if(session.getAttribute("Latitude")==null){
	session.setAttribute("Latitude",104.3165f);
}

Float Longitude = (Float)session.getAttribute("Longitude");//经度
Float Latitude = (Float)session.getAttribute("Latitude");//纬度
Float neweLongitude = Longitude-0.087f;
Float newLatitude = Latitude;

if(neweLongitude<3.85f){
	try{
		File tofile=new File("C:/Users/dell2/Desktop/googleLog/12/rightBelow.txt");

		FileWriter fw=new FileWriter(tofile);
		BufferedWriter buffw=new BufferedWriter(fw);
		PrintWriter pw=new PrintWriter(buffw);

		String str="纬度newLatitude="+newLatitude;
		pw.println(str);

		pw.close();
		buffw.close();
		fw.close();
	}catch(Exception e){
		System.out.println("写入文件时出错");
	}finally{
		neweLongitude = 28.7f;
		newLatitude = Latitude + 0.23f;
	}
	
}
session.setAttribute("neweLongitude",neweLongitude);
session.setAttribute("newLatitude",newLatitude);



System.out.println("Longitude=="+session.getAttribute("Longitude"));
System.out.println("Latitude=="+session.getAttribute("Latitude"));
System.out.println("neweLongitude=="+session.getAttribute("neweLongitude"));
System.out.println("newLatitude=="+session.getAttribute("newLatitude"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>右下角</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="refresh" content="1">
	<script type="text/javascript" src="mapfiles/mapapi.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-1.4.2.js"></script>
	<script>
	
  function LocalMapType() {}
  
  LocalMapType.prototype.tileSize = new google.maps.Size(256, 256);
  LocalMapType.prototype.maxZoom = 19;
  LocalMapType.prototype.minZoom = 1;
  LocalMapType.prototype.name = "本地";
  LocalMapType.prototype.alt = "显示本地地图";
  LocalMapType.prototype.getTile = function(coord, zoom, ownerDocument) {  	
      var zoomdisplay = document.getElementById("zoomdisplay");
      zoomdisplay.innerHTML = '当前级别为'+zoom;
      var div = ownerDocument.createElement('div');
      div.innerHTML = '<img name="" src="expotileTest/' + zoom +'/'+ coord.x +'/'+ coord.y + '.png"  onerror="errpic(this, '+coord.x+', '+coord.y+', '+zoom+')"/>';
	  div.style.width = this.tileSize.width + 'px';
	  div.style.height = this.tileSize.height + 'px';
	  return div;
  };
  
  
  function errpic(thepic, x, y, z){
		$.ajax({
		   type: "POST",
		   url:"<%=request.getContextPath()%>/download",
		   data:{
             "x":x,
             "y":y,
             "z":z
		   }
		});
	}
  
  
  
  var localMapType = new LocalMapType(); 
 
  function initialize() {
  
    //var myLatlng = new google.maps.LatLng(23.117055306224895, 113.2759952545166);
    
    var Longitude='<%=Longitude%>';
    var Latitude='<%=Latitude%>';
    var newLatitudeT = '<%=newLatitude%>';
    
    
    <%
    	session.setAttribute("Longitude",neweLongitude);
    	session.setAttribute("Latitude",newLatitude);
    %>
    
    if(parseFloat(newLatitudeT) > parseFloat(119.5)){
    	alert("out of border");
    	alert("右下角已经下载完毕");
    }

    var myLatlng = new google.maps.LatLng(Longitude, Latitude);
    var myOptions = {
      center: myLatlng,
      zoom: 12,
      streetViewControl: false,
      mapTypeControlOptions: {
        		 mapTypeIds: [ ]  //定义地图类型
        }
    };
 
    var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
    map.mapTypes.set('local', localMapType);
    map.setMapTypeId('local');
  }
 
  </script>
	
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body onload="initialize()">
	  <div id="map_canvas" style="width: 100%; height: 98%; margin: 0px;"></div>
	  <div id="zoomdisplay"></div>
  </body>
</html>
