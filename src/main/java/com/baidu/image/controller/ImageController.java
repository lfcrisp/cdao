package com.baidu.image.controller;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Import;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.baidu.dept.entity.Dept;
import com.baidu.image.entity.ExportExcel;
import com.baidu.image.entity.Image;
import com.baidu.image.entity.JsonData;
import com.baidu.image.service.ImageServiceI;
import com.baidu.image.utils.FileDownLoad;
import com.baidu.product.entity.Require;
import com.baidu.user.entity.User;
import com.lowagie.text.Cell;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.rtf.RtfWriter2;



@Controller
public class ImageController {

	@Autowired
	private ImageServiceI service;
	
    @RequestMapping("imageFileupload")
    public @ResponseBody Map upload(MultipartHttpServletRequest request, HttpServletResponse response) {
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf;
        List<Image> list = new LinkedList<>();
        
        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            
            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
            String newFilename = newFilenameBase + originalFileExtension;
            String storageDirectory = "F:\\apache-tomcat-6.0.39\\photo";
            String contentType = mpf.getContentType();
            Integer require_id = (Integer) request.getSession().getAttribute("require_id");
            
            InputStream is = null;
            File newFile = new File(storageDirectory + "/" + newFilename);
            try {
            	 is = mpf.getInputStream();       
            	 byte[] bytes = FileCopyUtils.copyToByteArray(is);
            	
                mpf.transferTo(newFile);
                
                BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 290);
                String thumbnailFilename = newFilenameBase + "-thumbnail.png";
                File thumbnailFile = new File(storageDirectory + "/" + thumbnailFilename);
                ImageIO.write(thumbnail, "png", thumbnailFile);
                
                Image image = new Image();
                image.setName(mpf.getOriginalFilename());
                image.setThumbnailFilename(thumbnailFilename);
                image.setNewFilename(newFilename);
                image.setContentType(contentType);
                image.setSize(mpf.getSize());
                image.setThumbnailSize(thumbnailFile.length());
                
                image.setUrl("/picture/"+image.getId());
                image.setThumbnailUrl("/thumbnail/"+image.getId());
                image.setDeleteUrl("/delete/"+image.getId());
                image.setDeleteType("DELETE");
                image.setPhoto(bytes);
                image.setRequire_id(require_id);
                
                service.insertImage(image);
                
                list.add(image);
                
            } catch(IOException e) {
            	
            }
            
        }
        
        request.getSession().removeAttribute("require_id");
        Map<String, Object> files = new HashMap<>();
        files.put("files", list);
        return files;
    }
    
    
    /*
     * 倒出excel
     */
	@RequestMapping("exportExcel")
    public void Export() throws IOException{
    	
    	String tableName="需求表";
    	
    	String fileName="E:\\"+tableName+".xls";
    	
    	FileOutputStream outputStream = new FileOutputStream(fileName);
    	
    	
    	HSSFWorkbook workbook = new HSSFWorkbook();
    	
    	HSSFSheet sheet = workbook.createSheet(tableName);
    	
    	//设置第几行的宽
    	sheet.setColumnWidth(8, 100 * 70);
    	
    	
    	HSSFRow row1 = sheet.createRow(0);
    	
    	
    	HSSFCellStyle style = workbook.createCellStyle(); // 样式对象      
    	
    	style.setFillForegroundColor((short) 13);// 设置背景色
        
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直      
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平    
        //生成一个字体
        HSSFFont font=workbook.createFont();
        font.setColor(HSSFColor.RED.index);//HSSFColor.VIOLET.index //字体颜色
        font.setFontHeightInPoints((short)10);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);         //字体增粗
        font.setFontName("楷体");
       //把字体应用到当前的样式
        style.setFont(font);
    	
    	sheet.addMergedRegion(new Region(0,(short)0,3,(short)8)); 
    	HSSFCell cell1 = row1.createCell((short) 0);      
        cell1.setCellValue("需求管理"); // 跨单元格显示的数据 
        cell1.setCellStyle(style); // 样式 
    	
       //画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）  
        HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
    	
    	
        //创建列头
    	HSSFRow row = sheet.createRow(4);
    	double height= 19.5*25; 
    	row.setHeight((short)height);
    	 
    	//查询字段的注释信息
    	List<Map> cList=service.getComments();
    	
    	
    	
    	for (int i = 0; i < cList.size(); i++) {
    		HSSFCell cell = row.createCell(i);
    		cell.setCellValue(cList.get(i).get("COMMENTS").toString());
    		cell.setCellStyle(style); // 样式 
		}
    	
    	//翻译所属产品的集合
    	Map<String,String> proMap=new HashMap<String,String>();
    	List<Map> proList = service.getPro();
    	for (Map map : proList) {
    		proMap.put(map.get("ID").toString(), map.get("NAME").toString());
		}
    	//翻译所属模块
    	Map<String,String> promodelMap=new HashMap<String,String>();
    	List<Map> promodelList = service.getPromodel();
    	for (Map map : promodelList) {
    		promodelMap.put(map.get("ID").toString(), map.get("NAME").toString());
		}
    	//翻译所属计划模块
    	Map<String,String> planMap=new HashMap<String,String>();
    	List<Map> planList = service.getPlan();
    	for (Map map : planList) {
    		planMap.put(map.get("ID").toString(), map.get("NAME").toString());
		}
    	//翻译需求来源模块
    	Map<String,String> fromMap=new HashMap<String,String>();
    	List<Map> fromList = service.getFrom();
    	for (Map map : fromList) {
    		fromMap.put(map.get("ID").toString(), map.get("NAME").toString());
		}
    	//翻译由谁评审模块
    	Map<String,String> examuserMap=new HashMap<String,String>();
    	List<Map> examuserList = service.getExamuser();
    	for (Map map : examuserList) {
    		examuserMap.put(map.get("ID").toString(), map.get("NAME").toString());
		}
    	
    	//查询所有信息
    	List<Map> datas = service.getRequire();
    	
    	//创建行并赋值
    	for (int i = 0; i < datas.size(); i++) {
    		 row = sheet.createRow(i+5);
    		// double height= 19.5*25; 
    	     row.setHeight((short)height);
    		 Map<String,Object> data = datas.get(i);
    		 for (int j = 0; j < cList.size(); j++) {
    			 HSSFCell cell = row.createCell(j);
	    		if(j==2){
	    			String proId=data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString();
	    			cell.setCellValue(proMap.get(proId));
	    			continue;
	    		}
	    		if(j==3){
	    			String promodelId=data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString();
	    			cell.setCellValue(promodelMap.get(promodelId));
	    			continue;
	    		}
	    		if(j==4){
	    			String planId=data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString();
	    			cell.setCellValue(planMap.get(planId));
	    			continue;
	    		}
	    		if(j==5){
	    			String fromlId=data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString();
	    			cell.setCellValue(fromMap.get(fromlId));
	    			continue;
	    		}
	    		if(j==6){
	    			String examuserId=data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString();
	    			cell.setCellValue(examuserMap.get(examuserId));
	    			continue;
	    		}
	    		cell.setCellValue(data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString());
    		 }
    		 
    		 
    		 Object object = data.get("ID");
    		 Integer reqid =Integer.valueOf(object.toString());
    		 List<Image> imagelist = service.getImageListByReqid(reqid);
    		 if(imagelist!=null&&imagelist.size()>0){
					for (int j = 0; j < imagelist.size(); j++) {
						HSSFCell cell = row.createCell(cList.size()+j);
						Image image = imagelist.get(j);
						byte[] bs = image.getPhoto();
						// 有图片时，设置行高为60px;
						//row.setHeightInPoints(60);
						double height1= 19.5*50; 
				    	row.setHeight((short)height1);
	                    // 设置图片所在列宽度为80px,注意这里单位的一个换算
	                    sheet.setColumnWidth(i, (short) (35.7 * 80));
	                    HSSFClientAnchor an = new HSSFClientAnchor(0, 0,
	                            1023, 255, (short)(cList.size()+j), i+5, (short)(cList.size()+j), i+5);
	                    an.setAnchorType(2);
	                    patriarch.createPicture(an, workbook.addPicture(
	                             bs, HSSFWorkbook.PICTURE_TYPE_JPEG));
					}
    		 }
    		 
		}
    	
    	workbook.write(outputStream);
    	
    	outputStream.close();
    	
    }
    
    
	@RequestMapping("exportPdf")
    public void exportPdf(){
		    Document document = new Document();
	        
	        try {
	            PdfWriter.getInstance(document, new FileOutputStream("E:\\需求.pdf"));
	            
	            // 生成字体
	            BaseFont bfChinese = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1",BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
	            
	            // 标题字体
	            //, Color.BLACK
	            Font f30 = new Font(bfChinese, 30, Font.NORMAL, Color.BLACK);
	            // 正文字体
	            Font f12 = new Font(bfChinese, 12, Font.NORMAL);
	            Font f6 = new Font(bfChinese, 6, Font.NORMAL);
	            Font f8 = new Font(bfChinese, 8, Font.NORMAL);
	            
	            document.open();
	            
	            // 标题
	            document.add(new Paragraph("需求报表", f30));
	            // 换行
	            document.add(new Chunk("\n"));
	            // 
	            document.add(
	                    new Paragraph(
	                    new Chunk("点击查看报表", f12)
	                    .setLocalGoto("table")));
	            // 换行
	            document.add(new Chunk("\n\n\n\n\n\n\n\n\n"));
	            // 报表位置
	            document.add(new Chunk("报表实例", f12).setLocalDestination("table"));
	            
	            //查询字段的注释信息
	        	List<Map> cList=service.getComments();
	        	//查询图片最大张数
	        	int number = service.getImageSize();
	        	
	            // 添加table实例
	            PdfPTable table = new PdfPTable(cList.size()+number);
	            table.setWidthPercentage(100);
	            table.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
	            PdfPCell cell = new PdfPCell();
	            //cell.setBackgroundColor(new Color(213, 141, 69));
	            cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
	            
	            // 表格标题
	            for (int i = 0; i < cList.size(); i++) {
	        		cell.setPhrase(new Paragraph(cList.get(i).get("COMMENTS").toString(), f8));
		            table.addCell(cell);
	    		}
	            cell.setColspan(number);  
	            cell.setPhrase(new Paragraph("上传附件", f8));
	            table.addCell(cell);
	            
	           //查询所有信息
	           List<Map> datas = service.getRequireList();
	            
	            // 表格数据
	            PdfPCell newcell = new PdfPCell();
	            newcell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
	          //创建行并赋值
	        	for (int i = 0; i < datas.size(); i++) {
	        		 Map<String,Object> data = datas.get(i);
	        		 for (int j = 0; j < cList.size(); j++) {
	        			newcell.setPhrase(new Paragraph(data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString(), f8));
	     	            table.addCell(newcell);
	        		 }
	        		 
	        		 Object object = data.get("ID");
	        		 Integer reqid =Integer.valueOf(object.toString());
	        		 
	        		 List<Image> imagelist = service.getImageListByReqid(reqid);
	        		 if(imagelist!=null&&imagelist.size()>0){
	    					for (int j = 0; j < imagelist.size(); j++) {
	    						Image image = imagelist.get(j);
	    						com.lowagie.text.Image img = com.lowagie.text.Image.getInstance(image.getPhoto());
	    						img.scalePercent(70f);  
	    						img.setAlignment(Element.ALIGN_CENTER);  
	    						newcell.setImage(img);
	    	     	            table.addCell(newcell);
	    					}
	    					for (int j = 0; j < number-imagelist.size(); j++) {
	    						newcell.setPhrase(new Paragraph("", f8));
		        				table.addCell(newcell);
							}
	        		 }else{
	        			 for (int j = 0; j < number; j++) {
	        				 newcell.setPhrase(new Paragraph("", f8));
	        				 table.addCell(newcell);
	        			 }
	        		 }
	    		}
	            
	            document.add(table);
	            
	            document.close();
	        } catch (Exception e) {
	        	e.printStackTrace();
	            // TODO: handle exception
	        }
	}
	
	
	@RequestMapping("exportWord")
    public void exportWord(HttpServletRequest request,HttpServletResponse response){
		    Document document = new Document(PageSize.A4);
	        
	        try {
	        	RtfWriter2.getInstance(document, new FileOutputStream("E:/需求管理.doc"));
	            
	            // 生成字体
	            BaseFont bfChinese = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1",BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
	            
	            // 标题字体
	            //, Color.BLACK
	            Font f30 = new Font(bfChinese, 30, Font.NORMAL, Color.BLACK);
	            // 正文字体
	            Font f12 = new Font(bfChinese, 12, Font.NORMAL);
	            Font f6 = new Font(bfChinese, 6, Font.NORMAL);
	            Font f8 = new Font(bfChinese, 8, Font.NORMAL);
	            
	            document.open();
	            
	            // 标题
	            document.add(new Paragraph("需求报表", f30));
	            
	           //查询字段的注释信息
	        	List<Map> cList=service.getComments();
	        	//查询图片最大张数
	        	int number = service.getImageSize();
	            
	            Table table=new Table(cList.size()+number);//列数必须设置，而行数则可以按照个人要求来决定是否需要设置  
	            table.setAlignment(Element.ALIGN_CENTER);// 居中显示  
	            table.setAlignment(Element.ALIGN_MIDDLE);// 纵向居中显示  
	            table.setAutoFillEmptyCells(true);// 自动填满  
	            table.setBorderColor(new Color(0, 125, 255));// 边框颜色  
	            table.setBorderWidth(1);// 边框宽度  
	            table.setSpacing(2);// 衬距，  
	            table.setPadding(2);// 即单元格之间的间距  
	            table.setBorder(20);// 边框  
	            for (int i = 0; i < cList.size(); i++) {  
	                table.addCell(new Cell(new Paragraph(cList.get(i).get("COMMENTS").toString(), f8)));  
	            }  
	            Cell cell = new Cell(new Paragraph("上传附件", f8));
	            cell.setColspan(number);
	            table.addCell(cell);  
	            
	           //查询所有信息
	           List<Map> datas = service.getRequireList();
	            
	            // 表格数据
	            PdfPCell newcell = new PdfPCell();
	            newcell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
	          //创建行并赋值
	        	for (int i = 0; i < datas.size(); i++) {
	        		 Map<String,Object> data = datas.get(i);
	        		 for (int j = 0; j < cList.size(); j++) {
	     	            table.addCell(new Cell(new Paragraph(data.get(cList.get(j).get("COLUMN_NAME"))==null?"":data.get(cList.get(j).get("COLUMN_NAME")).toString(), f8)));
	        		 }
	        		 
	        		 Object object = data.get("ID");
	        		 Integer reqid =Integer.valueOf(object.toString());
	        		 
	        		 List<Image> imagelist = service.getImageListByReqid(reqid);
	        		 if(imagelist!=null&&imagelist.size()>0){
	    					for (int j = 0; j < imagelist.size(); j++) {
	    						Image image = imagelist.get(j);
	    						com.lowagie.text.Image img = com.lowagie.text.Image.getInstance(image.getPhoto());
	    						img.scaleAbsolute(30, 50);  
	    						img.setAlignment(Element.ALIGN_CENTER);  
	    	     	            table.addCell(new Cell(img));
	    					}
	    					for (int j = 0; j < number-imagelist.size(); j++) {
		        				table.addCell(new Cell(new Paragraph("", f8)));
							}
	        		 }else{
	        			 for (int j = 0; j < number; j++) {
	        				 	table.addCell(new Cell(new Paragraph("", f8)));
	        			 }
	        		 }
	    		}
	            
	            document.add(table);
	            document.close();
	            
	            FileDownLoad.download("E:/需求管理.doc", request, response);
	        } catch (Exception e) {
	        	e.printStackTrace();
	            // TODO: handle exception
	        }
	}
	
	
    
    /*@RequestMapping("exportExcel")
    public void Export(@RequestBody List<Require> rowsString){
        //声明一个工作薄
        HSSFWorkbook wb = new HSSFWorkbook();
        //声明一个单子并命名
        HSSFSheet sheet = wb.createSheet("需求表");
        //给单子名称一个长度
        sheet.setDefaultColumnWidth((short)15);
        // 生成一个样式  
        HSSFCellStyle style = wb.createCellStyle();
        //创建第一行（也可以称为表头）
        HSSFRow row = sheet.createRow(0);
        //样式字体居中
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        //给表头第一行一次创建单元格
        HSSFCell cell = row.createCell((short) 0);
		         cell.setCellValue("模块编号"); 
		         cell.setCellStyle(style);
		         cell = row.createCell( (short) 1);  
                 cell.setCellValue("模块名称");  
                 cell.setCellStyle(style);  
		         cell = row.createCell((short) 2);  
		         cell.setCellValue("所属产品");  
		         cell.setCellStyle(style); 
         
        //添加一些数据，这里先写死，大家可以换成自己的集合数据
        List<Require> list = new ArrayList<Require>();
        for (Require require : rowsString) {
       	   list.add(require);
		}
 
        //向单元格里填充数据
        for (short i = 0; i < list.size(); i++) {
            row = sheet.createRow(i + 1);
            row.createCell(0).setCellValue(list.get(i).getId());
            row.createCell(1).setCellValue(list.get(i).getName());
            row.createCell(2).setCellValue(list.get(i).getProname());
        }
 
        try {
            //默认导出到E盘下
            FileOutputStream out = new FileOutputStream("E://需求表.xls");
            wb.write(out);
            out.close();
            JOptionPane.showMessageDialog(null, "导出成功!");
         } catch (FileNotFoundException e) {
            JOptionPane.showMessageDialog(null, "导出失败!");
            e.printStackTrace();
         } catch (IOException e) {
            JOptionPane.showMessageDialog(null, "导出失败!");
            e.printStackTrace();
         }
               
    }*/
    
    @RequestMapping("checkImage")
    public String checkImage(int require_id,HttpServletRequest request){
    	List list=service.checkImage(require_id);
    	request.setAttribute("list", list);
		return "Product/imageList";
    }
    
    @RequestMapping("imageList/{image_id}")
    public void imageList(@PathVariable Integer image_id,HttpServletResponse response) throws IOException{
    	 Image image=service.imageListById(image_id);
    	 
    	 OutputStream os =response.getOutputStream();
 		 byte[] img = image.getPhoto();
 		 os.write(img);
         os.close(); 
    }
    
    @RequestMapping("impExcel")
    @ResponseBody
    public boolean impExcel(HttpServletRequest request) throws Exception{
    	    int a=0;
			//获取一个支持文件上传的request的对象(SpringMVC提供)
			MultipartHttpServletRequest req=(MultipartHttpServletRequest) request;
			//获取页面中的文件对象
			MultipartFile file = req.getFile("myFile");
			//读取文件的流
			InputStream inputStream = file.getInputStream();
			
			HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
			
			//查询字段的注释信息
        	List<Map> cList=service.getComments();
        	//创建一个翻译的集合
        	Map map = new HashMap();
        	//将注释与字段名存放在集合中
        	for (int i = 0; i < cList.size(); i++) {
				map.put(cList.get(i).get("COMMENTS"), cList.get(i).get("COLUMN_NAME"));
			}
        	//创建一个存放中文字段的集合 
        	ArrayList zhList = new ArrayList();
        	//获取User类中所有的方法
        	Method[] methods = Require.class.getDeclaredMethods();
			//获取Sheet的数量
			int numberOfSheets = workbook.getNumberOfSheets();
			
			//翻译所属产品的集合
	    	Map<String,String> proMap=new HashMap<String,String>();
	    	List<Map> proList = service.getPro();
	    	for (Map map2 : proList) {
	    		proMap.put( map2.get("NAME").toString(),map2.get("ID").toString());
			}
	    	//翻译所属模块
	    	Map<String,String> promodelMap=new HashMap<String,String>();
	    	List<Map> promodelList = service.getPromodel();
	    	for (Map map2 : promodelList) {
	    		promodelMap.put(map2.get("NAME").toString(),map2.get("ID").toString());
			}
	    	//翻译所属计划模块
	    	Map<String,String> planMap=new HashMap<String,String>();
	    	List<Map> planList = service.getPlan();
	    	for (Map map2 : planList) {
	    		planMap.put(map2.get("NAME").toString(),map2.get("ID").toString());
			}
	    	//翻译需求来源模块
	    	Map<String,String> fromMap=new HashMap<String,String>();
	    	List<Map> fromList = service.getFrom();
	    	for (Map map2 : fromList) {
	    		fromMap.put(map2.get("NAME").toString(),map2.get("ID").toString());
			}
	    	//翻译由谁评审模块
	    	Map<String,String> examuserMap=new HashMap<String,String>();
	    	List<Map> examuserList = service.getExamuser();
	    	for (Map map2 : examuserList) {
	    		examuserMap.put(map2.get("NAME").toString(),map2.get("ID").toString());
			}
			
			for (int i = 0; i < numberOfSheets; i++) {
				HSSFSheet sheet = workbook.getSheetAt(i);
				//获取当前sheet的第一行
				HSSFRow row = sheet.getRow(4);
				//循环该行有效的单元格列数
				for (int j = 0; j < row.getPhysicalNumberOfCells(); j++) {
					//System.out.println(row.getCell(j).getStringCellValue());
					zhList.add(row.getCell(j).getStringCellValue());
				}
				
				int numberOfRows = sheet.getPhysicalNumberOfRows();
				//创建一个存放每行数据的集合
				ArrayList<Require> requireList = new ArrayList<Require>();
				for (int j = 5; j < numberOfRows+3; j++) {
					//每行数据创建一个User对象
					Require require = new Require();
					HSSFRow row2 = sheet.getRow(j);
					for (int k = 0; k <zhList.size(); k++) {
						String  zhName=map.get(zhList.get(k)).toString();
						String cellValue = row2.getCell(k).getStringCellValue();
						if(cellValue!=null&&!cellValue.equals("")){
							for (Method method : methods) {
								if(method.getName().toUpperCase().equals(("set"+zhName).toUpperCase())){
									if(zhName.toUpperCase().equals("ID")){
										method.invoke(require, Integer.parseInt(cellValue));
									}else if(zhName.toUpperCase().equals("NAME")){
										//System.out.println(cellValue);
										method.invoke(require,cellValue);
									}else if(zhName.toUpperCase().equals("PROID")){
										method.invoke(require, Integer.parseInt(proMap.get(cellValue)));
									}else if(zhName.toUpperCase().equals("MODELID")){
										method.invoke(require, Integer.parseInt(promodelMap.get(cellValue)));
									}else if(zhName.toUpperCase().equals("PLANID")){
										method.invoke(require, Integer.parseInt(planMap.get(cellValue)));
									}else if(zhName.toUpperCase().equals("FROMID")){
										method.invoke(require, Integer.parseInt(fromMap.get(cellValue)));
									}else if(zhName.toUpperCase().equals("EXAMUSER")){
										method.invoke(require,examuserMap.get(cellValue));
									}else if(zhName.toUpperCase().equals("LEVELS")){
										method.invoke(require, Integer.parseInt(cellValue));
									}else if(zhName.toUpperCase().equals("CONTENTS")){
										method.invoke(require, cellValue);
									}
									//if(method.getParameterTypes()[0].getSimpleName().equals("Integer")){
										//method.invoke(require, Integer.parseInt(cellValue));
									//}else{
										//method.invoke(require, cellValue);
									//}
								}
							}
						}
					}
					requireList.add(require);
				}
				
				for (Require require : requireList) {
					//System.out.println(require.toString());
					//a=service.insertCopyReq(require);
				}
				
				a=service.insertAllReq(requireList);
				
			}
			if(a>0){
				return true;
			}else{
				return false;
			}
    }
    
    @RequestMapping("checkProData")
    @ResponseBody
    public JsonData checkProData(){
    	JsonData jsonData=service.checkProData();
    	return jsonData;
    }
      
    @RequestMapping("checkFrom")
    @ResponseBody
    public List checkFrom(){
    	List list=service.checkFrom();
    	return list;
    }
   
    @RequestMapping("checkPlan")
    @ResponseBody
    public List checkPlan(){
    	List list=service.checkPlan();
    	return list;
    }
      
}
