package com.baidu.image.entity;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;
 
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.formula.functions.T;


public class ExportExcel<t> {
	 private static final String[] unchecked = null;

	/**
     * 这是一个通用的方法，利用了JAVA的反射机制，可以将放置在JAVA集合中并且符号一定条件的数据以EXCEL 的形式输出
     * 
     * @param title
     *            表格标题名
     * @param headersName
     *            表格属性列名数组
     * @param headersId
     *            表格属性列名对应的字段
     * @param dataset
     *            需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象
     * @param out
     *            与输出设备关联的流对象，可以将EXCEL文档导出到本地文件或者网络中
     */
    @SuppressWarnings("unchecked")
    public void exportExcel(String title, String[] headersName,String[] headersId,
            List<t> dtoList) {
        //表头
        Map<Integer, String> map = new HashMap<Integer, String>();
        int key=0;
        for (int i = 0; i < headersName.length; i++) {
            if (!headersName[i].equals(null)) {
                map.put(key, headersName[i]);
                key++;
            }
        }
        //字段
        Map<Integer, String> zdMap = new HashMap<Integer, String>();
        int value = 0;
        for (int i = 0; i < headersId.length; i++) {
            if (!headersId[i].equals(null)) {
                zdMap.put(value, headersId[i]);
                value++;
            }
        }
        // 声明一个工作薄
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet(title);
        sheet.setDefaultColumnWidth((short)15);
        // 生成一个样式  
        HSSFCellStyle style = wb.createCellStyle();
        HSSFRow row = sheet.createRow(0);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        HSSFCell cell;
        Collection c = map.values();
        Iterator<String> it = c.iterator();
        //根据选择的字段生成表头
        short size = 0;
        while (it.hasNext()) {
                cell = row.createCell(size);
            cell.setCellValue(it.next().toString());
            cell.setCellStyle(style);
            size++;
        }
        //字段        
        Collection zdC = zdMap.values();
        Iterator<t> labIt = dtoList.iterator();
        int zdRow =0;
        while (labIt.hasNext()) {
            int zdCell = 0;
            zdRow++;
            row = sheet.createRow(zdRow);
            T l = (T) labIt.next();
            // 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
            Field[] fields = l.getClass().getDeclaredFields();
            for (short i = 0; i < fields.length; i++) {
                Field field = fields[i];
                String fieldName = field.getName();
//              System.out.println(fieldName);
                Iterator<String> zdIt = zdC.iterator();
                while (zdIt.hasNext()) {
                    if (zdIt.next().equals(fieldName)) {
                        String getMethodName = 
                        		/*get  +*/ fieldName.substring(0, 1).toUpperCase()
                            + fieldName.substring(1);
                        Class tCls = l.getClass();
                        try {
                            Method getMethod = tCls.getMethod(getMethodName,
                                    new Class[] {});
                            Object val = getMethod.invoke(l, new Object[] {});
//                          System.out.println(fields[i].getName());
//                          System.out.println(val);
                            String textVal = null;
                            if (val!= null) {
                                textVal = val.toString();
                            }else{
                                textVal = null;
                            }
                            row.createCell((short) zdCell).setCellValue(textVal);
                            zdCell++;
                        } catch (SecurityException e) {
                            e.printStackTrace();
                        } catch (IllegalArgumentException e) {
                            e.printStackTrace();
                        } catch (NoSuchMethodException e) {
                            e.printStackTrace();
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } catch (InvocationTargetException e) {
                            e.printStackTrace();
                        }
                    }
                }
                 
            }
        }
         
        try {
            FileOutputStream xls = new FileOutputStream("C://Users//Administrator//Desktop//实验室.xls");
            wb.write(xls); 
            xls.close();
            JOptionPane.showMessageDialog(null, "导出成功!");
        } catch (FileNotFoundException e) {
            JOptionPane.showMessageDialog(null, "导出失败!");
            e.printStackTrace();
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, "导出失败!");
            e.printStackTrace();
        }
    }
    
    

    @SuppressWarnings("unchecked")
    public void exportLabType(HttpServletRequest request){
    	//以下是从前台获取参数
        String typeId = request.getParameter("typeId");
        String typeName = request.getParameter("typeName");
        String buildingArea = request.getParameter("buildingArea");
        String ability = request.getParameter("ability");
        String personTime = request.getParameter("personTime");
        String usingHours = request.getParameter("usingHours");
        String evaluate = request.getParameter("evaluate");
        String establishNumber = request.getParameter("establishNumber");
        String actualNumber = request.getParameter("actualNumber");
        //把他们都存成数组格式
        //这是需要导出的excel表头
        String[] col = {typeId,typeName,buildingArea,ability,personTime,usingHours,evaluate,establishNumber,actualNumber};
        String[] zd = col;//这是需要导出的字段
        //下面用到上面的类，需要传递实体参数
       // ExportExcel<laboratorydto> ee = new ExportExcel<laboratorydto>();
       //最后一个参数是你的数据集合，我这里是查询出来直接填充上去
       // ee.exportExcel("实验室类型", col, zd, this.laboratoryService.queryAllLab());
    }
}

