/*
 * Power by www.xiaoi.com
 */
package com.zokee.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;


/**
 * @author <a href="mailto:eko.z@outlook.com">eko.zhan</a>
 * @date Jul 23, 2015 9:36:25 AM
 * @version 1.0
 */
public class FileAction extends HttpServlet {

	 
	 private final static String FILE_UPLOAD = "FILE_UPLOAD";
	 private final static String FILE_DOWNLOAD = "FILE_DOWNLOAD";
	 private final static String FILE_DELETE = "FILE_DELETE";
	 private final static String Encoding_UTF8 = "UTF-8";
	
	/**
	 * Constructor of the object.
	 */
	public FileAction() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		if (StringUtils.isBlank(action)){
			System.out.println(request.getContextPath());
			Properties props = System.getProperties();
			for (Object key : props.keySet()){
				System.out.println( key + " -----> " + props.get(key));
			}
		}else{
			if (action.equals(FILE_UPLOAD)){
				upload(request, response);
			}
		}
		
		
		
	}

	
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	private void upload(HttpServletRequest request, HttpServletResponse response){
		String data = request.getParameter("data");
		
		int result = 1;
		String msg = "上传成功";
		
		
		Base64 base64 = new Base64();
		//base64 decode image
		byte[] b = base64.decode(data.substring("data:image/png;base64,".length()).getBytes());
		String fileName = String.valueOf(System.currentTimeMillis());
		//image path
		String filePath = System.getProperty("user.home") + File.separator + "DATAS" + File.separator + fileName + ".png";
		System.out.println(filePath);
		//write image
		File file = new File(filePath);
		try {
			FileUtils.writeByteArrayToFile(file, b);
		} catch (IOException e) {
			result = 0;
			msg = "上传失败";
			e.printStackTrace();
		}
		
		response.setContentType("text/json");
		response.setCharacterEncoding("utf-8");
		try {
			PrintWriter out = response.getWriter();
			out.print("{\"result\":\""+result+"\", \"msg\":\""+msg+"\"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
