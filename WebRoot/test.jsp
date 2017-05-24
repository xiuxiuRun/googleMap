<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>googleMap</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
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
    var myLatlng = new google.maps.LatLng(23.12916667, 113.3033333);
    var myLatlngNew = new google.maps.LatLng(25.12916667, 113.3033333);
    var myOptions = {
      center: myLatlng,
      zoom: 11,
      streetViewControl: false,
      mapTypeControlOptions: {
        		 mapTypeIds: [ ]  //定义地图类型
        }
    };
 
    var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
    map.mapTypes.set('local', localMapType);
    map.setMapTypeId('local');
    //map.panTo(myLatlngNew);
    
    var marker = new google.maps.Marker({
         position: myLatlng, 
         map: map,
         title: '申迪'
     });
     
   var infowindow = new google.maps.InfoWindow(
         { content:"申迪:" + marker.getPosition().toString(),
           size: new google.maps.Size(50,50)
         });
 
     
     
     google.maps.event.addListener(marker, 'click', function() {
       infowindow.setContent("申迪公司坐标:" + marker.getPosition().toUrlValue(6));
       infowindow.open(map,marker);
     }); 
     
     
     window.setTimeout(function(){
         map.panTo(myLatlngNew);
     }, 5000);
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
