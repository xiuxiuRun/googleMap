<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

if(session.getAttribute("Longitude")==null){
	session.setAttribute("Longitude",20.2f);
}
if(session.getAttribute("Latitude")==null){
	session.setAttribute("Latitude",110.60499f);
}

Float Longitude = (Float)session.getAttribute("Longitude");//经度
Float Latitude = (Float)session.getAttribute("Latitude");//纬度
Float neweLongitude = Longitude+0.025f;
Float newLatitude = Latitude;

if(neweLongitude>25.52f){
	try{
		File tofile=new File("C:/Users/dell2/Desktop/googleLog/15/left.txt");

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
		neweLongitude = 20.2f;
		newLatitude = Latitude + 0.057f;
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
    
    <title>左边</title>
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
      div.innerHTML = '<img name="" src="expotileTest2/' + zoom +'/'+ coord.x +'/'+ coord.y + '.png"  onerror="errpic(this, '+coord.x+', '+coord.y+', '+zoom+')"/>';
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
    
    if(parseFloat(newLatitudeT) > parseFloat(111.60)){
    	alert("out of border");
    	alert("左边已经下载完毕");
    }

    var myLatlng = new google.maps.LatLng(Longitude, Latitude);
    var myOptions = {
      center: myLatlng,
      zoom: 15,
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
