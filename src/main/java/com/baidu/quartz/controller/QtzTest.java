package com.baidu.quartz.controller;

import java.awt.Font;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.jfree.chart.ChartColor;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import com.baidu.image.entity.EcharData;
import com.baidu.quartz.service.QtzServiceI;

public class QtzTest {

	@Autowired
	private QtzServiceI service;
	
	 //定时器
    public void work() throws Exception{
    	System.out.println("开始");
    	this.createBarChart3D();
    	this.zhuzhuangtu();
    	this.Sendmail();
    	System.out.println("结束");
    }
    
    //生成饼状图
    @RequestMapping("createBarChart3D")
    public void createBarChart3D() throws IOException {
        DefaultPieDataset data = getDataSet();
        JFreeChart chart = ChartFactory.createPieChart3D("产品分析图", // 图表标题
                data, // 数据集
                true, // 是否显示图例(对于简单的柱状图必须是 false)
                false, // 是否生成工具
                false // 是否生成 URL 链接
                );

        chart.setBackgroundPaint(ChartColor.WHITE);
        PiePlot mChartPlot = (PiePlot)chart.getPlot();
		mChartPlot.setLabelFont(new Font("黑体", Font.BOLD, 15));
		
		TextTitle mTextTitle = chart.getTitle();  
        mTextTitle.setFont(new Font("黑体", Font.BOLD, 20)); 
        
        //设置图表下方的图例说明字体
        chart.getLegend().setItemFont(new Font("微软雅黑",Font.BOLD,12));
        // 获得图表对象
        //CategoryPlot p = chart.getCategoryPlot();
        // 设置图的背景颜色
        //p.setBackgroundPaint(ChartColor.WHITE);
        // 写图表对象到文件，参照柱状图生成源码
        FileOutputStream fos_jpg = null;
        
        try {
            fos_jpg = new FileOutputStream("D:\\产品统计图.jpg");
            ChartUtilities.writeChartAsJPEG(fos_jpg, chart, 400, 300,
                    null);
        } finally {
            try {
                fos_jpg.close();
            } catch (Exception e) {
            }
        }
        ChartFrame chartFrame=new ChartFrame("",chart); 
        chartFrame.pack(); //以合适的大小展现图形
        //chartFrame.setVisible(true);//图形是否可见
    }

    /**
     * 获取需求的数据对象
     * 
     * @return
     */
    private DefaultPieDataset getDataSet() {
        DefaultPieDataset dataset = new DefaultPieDataset();
        List<EcharData> list=service.checkPlan();
        for (EcharData echarData : list) {
        	dataset.setValue(echarData.getName(), echarData.getValue());
		}
        return dataset;
    }
    //生成柱状图
    @RequestMapping("zhuzhuangtu")
    public void zhuzhuangtu(){
    	// 创建柱状图  
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();  
        //装载数据
        List<EcharData> list=service.checkPlan();
        for (EcharData echarData : list) {
        	dataset.setValue(echarData.getValue(),"",echarData.getName());
		}
        // 3D柱状图  
        JFreeChart chart = ChartFactory.createBarChart3D("产品统计图", "", "", dataset, PlotOrientation.VERTICAL, true, true, false);  
       
       //1. 图形标题文字设置
        TextTitle textTitle = chart.getTitle();   
        textTitle.setFont(new Font("宋体",Font.BOLD,20));
        
        //2. 图形X轴坐标文字的设置
        CategoryPlot plot = (CategoryPlot) chart.getPlot();
        CategoryAxis axis = plot.getDomainAxis();
        axis.setLabelFont(new Font("宋体",Font.BOLD,22));  //设置X轴坐标上标题的文字
        axis.setTickLabelFont(new Font("宋体",Font.BOLD,15));  //设置X轴坐标上的文字
        
       //2. 图形Y轴坐标文字的设置
        ValueAxis valueAxis = plot.getRangeAxis();
        valueAxis.setLabelFont(new Font("宋体",Font.BOLD,15));  //设置Y轴坐标上标题的文字
        valueAxis.setTickLabelFont(new Font("sans-serif",Font.BOLD,12));//设置Y轴坐标上的文字
        	
        
        
        try {  
            // 创建图形显示面板  
            ChartFrame cf = new ChartFrame("柱状图", chart);  
            cf.pack();  
            // 设置图片大小  
            cf.setSize(800, 600);  
            // 设置图形可见  
            //cf.setVisible(true);  
            // 保存图片到指定位置  
             ChartUtilities.saveChartAsJPEG(new File("D:\\产品统计柱状图.png"), chart,  500,  300);  
        } catch (Exception e) {  
        }  
    }
    
    //发送邮件
    @RequestMapping("Sendmail")
    public void Sendmail(){
    	  try {
			  Properties prop = new Properties();
			  prop.setProperty("mail.host", "smtp.qq.com");
			  prop.setProperty("mail.transport.protocol", "smtp");
			  prop.setProperty("mail.smtp.auth", "true");
			  prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			  prop.setProperty("mail.smtp.port", "465");
			  prop.setProperty("mail.smtp.socketFactory.port", "465");
			  //使用JavaMail发送邮件的5个步骤
			  //1、创建session
			  Session session = Session.getInstance(prop);
			  //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
			  session.setDebug(true);
			  //2、通过session得到transport对象
			  Transport ts = session.getTransport();
			  //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
			  //xsxryjelinlhbhgc
			  ts.connect("smtp.qq.com", "1361010303@qq.com", "cjwkdraogmzgiege");
			  //4、创建邮件
			  Message message = createImageMail(session);
			  //5、发送邮件
			  ts.sendMessage(message, message.getAllRecipients());
			  ts.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public MimeMessage createImageMail(Session session) throws Exception {
          //创建邮件
          MimeMessage message = new MimeMessage(session);
          // 设置邮件的基本信息
          //发件人
          message.setFrom(new InternetAddress("1361010303@qq.com"));
          //收件人
          message.setRecipient(Message.RecipientType.TO, new InternetAddress("599937798@qq.com"));
          //邮件标题
          message.setSubject("产品报表的统计");
  
          // 准备邮件数据
          // 准备邮件正文数据
          MimeBodyPart text = new MimeBodyPart();
          text.setContent("产品报表的统计", "text/html;charset=UTF-8");
          // 准备图片数据
          MimeBodyPart image = new MimeBodyPart();
          DataHandler dh = new DataHandler(new FileDataSource("D:\\产品统计图.jpg"));
          image.setDataHandler(dh);
          image.setFileName(MimeUtility.encodeText("产品统计图.jpg"));
          
          MimeBodyPart image2 = new MimeBodyPart();
          DataHandler dh2 = new DataHandler(new FileDataSource("D:\\产品统计柱状图.png"));
          image2.setDataHandler(dh2);
          image2.setFileName(MimeUtility.encodeText("产品统计柱状图.png"));
          // 描述数据关系
          MimeMultipart mm = new MimeMultipart();
          mm.addBodyPart(text);
          mm.addBodyPart(image);
          mm.addBodyPart(image2);
          mm.setSubType("related");
  
          message.setContent(mm);
          message.saveChanges();
          //将创建好的邮件写入到E盘以文件的形式进行保存
          message.writeTo(new FileOutputStream("E:\\ImageMail.eml"));
          //返回创建好的邮件
          return message;
      }
}
