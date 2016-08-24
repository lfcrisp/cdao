package com.baidu.image.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDownLoad {

	public static String download(String filepath,HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		OutputStream fos = null;
		InputStream fis = null;

		try {
		// 如果是从服务器上取就用这个获得系统的绝对路径方法。
		//String filepath = request.getRealPath(filepatha);//方法过时了
		//String filepathall = request.getSession().getServletContext().getRealPath(filepath);
		String filepathall=filepath;
		File uploadFile = new File(filepathall);

		fis = new FileInputStream(uploadFile);
		bis = new BufferedInputStream(fis);
		fos = response.getOutputStream();
		bos = new BufferedOutputStream(fos);
		
		//得到文件名
		String filename = filepath.substring(filepath.lastIndexOf("/")+1);

		// 这个就就是弹出下载对话框的关键代码
		response.setHeader("Content-disposition", "attachment;filename="+ URLEncoder.encode(filename, "utf-8"));
		
		int bytesRead = 0;
		// 用输出流去写，缓冲输入输出流
		byte[] buffer = new byte[8192];
		while ((bytesRead = bis.read(buffer, 0, 8192)) != -1) {
		bos.write(buffer, 0, bytesRead);
		}

		} catch (FileNotFoundException e) {
		e.printStackTrace();
		} catch (IOException e) {
		e.printStackTrace();
		} catch (NumberFormatException e) {
		e.printStackTrace();
		} finally {
		try {
		if (bos != null) {
		bos.flush();
		}
		if (fis != null) {
		fis.close();
		}
		if (bis != null) {
		bis.close();
		}
		if (fos != null) {
		fos.close();
		}
		if (bos != null) {
		bos.close();
		}
		} catch (IOException e) {
		e.printStackTrace();
		}
		}
		return null;
	}
}
