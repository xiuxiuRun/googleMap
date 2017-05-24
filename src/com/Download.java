package com;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class Download extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		PrintWriter out=response.getWriter();
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		String z = request.getParameter("z");
		
		//http://mt0.googleapis.com/vt?lyrs=m@174000000&src=apiv3&hl=zh-CN&x=3434&y=1673&z=12&s=Galileo&style=api%7Csmartmaps
		//http://mt0.google.cn/vt?lyrs=m@160000000&hl=zh-CN&gl=CN&x=856&y=419&z=10&s=Gal&style=api%7Csmartmaps
		//http://mt0.google.cn/vt?lyrs=m@160000000&hl=zh-CN&gl=CN&x=856&y=417&z=10&s=G&style=api%7Csmartmaps
		//http://mt1.google.cn/vt?lyrs=m@160000000&hl=zh-CN&gl=CN&x=3427&y=1674&z=12&s=Gal&style=api%7Csmartmaps
		
		
		String imageUrl = "http://mt0.googleapis.com/vt?src=apiv3&hl=zh-CN&x="+x+"&y="+y+"&z="+z;
		//String imageUrl = "http://mt0.google.cn/vt?style=api%7Csmartmaps&hl=zh-CN&gl=CN&x="+x+"&y="+y+"&z="+z;
		
		System.out.println("url="+imageUrl);
		
		String path = "D:/sendi/sendiSoft/tomcat6/apache-tomcat-6.0.36-windows-x64/apache-tomcat-6.0.36/webapps/googleMap/expotile/"+z+"/"+x+"/";
        
        File dir = new File(path);
        if(!dir.exists()){
        	System.out.println("start createNewFiles");
        	dir.mkdirs();
        }
        
        path += y + ".png";
        download(imageUrl,path);
        //out.print("zoom="+z);
		
		
		

	}
	
	 public  void download(String strUrl,String path){
	       URL url = null;
	       try {
	              url = new URL(strUrl);
	       } catch (MalformedURLException e2) {
	             e2.printStackTrace();
	             return;
	       }

	       InputStream is = null;
	        try {
	            is = url.openStream();
	        } catch (IOException e1) {
	            e1.printStackTrace();
	            return;
	        }

	        OutputStream os = null;
	        try{
	            os = new FileOutputStream(path);
	            int bytesRead = 0;
	            byte[] buffer = new byte[8192];
	            while((bytesRead = is.read(buffer,0,8192))!=-1){
	            os.write(buffer,0,bytesRead);
	       }
	       }catch(FileNotFoundException e){
	           e.printStackTrace();
	           return;
	       } catch (IOException e) {
	           e.printStackTrace();
	           return;
	      }
	    }

}
