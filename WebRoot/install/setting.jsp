<%@ page language="java" import="java.util.*" import="java.io.*" pageEncoding="UTF-8"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
<%@page import="javax.xml.ws.Response"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<title>系统参数设置</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="jsp,install,component">
	<meta http-equiv="description" content="This is a install component for web project,implement by jsp.">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	
	<style type="text/css">

	#config{ position: relative; padding-top: 50px;padding-left: 10;border: 1px}
	#btns{padding-left: 350px;}
	</style>
	<script type="text/javascript">
		function load(){
		   init("p2");
		}
		function check(){
			var iputs = getId('frm').getElementsByTagName('input');
			var len=iputs.length;
			while(len--){
				var p=iputs[len];
				
				if(p.value=="")
				{
					//alert(p.name+":无效的参数！");
					document.getElementById("errmsg").innerHTML=p.name+":无效的参数！";
					return false;
				}
			}
			return true;
		}
	</script>
  </head>
  
<body onload="load()">
<%@ include file="navbar.jsp" %> <p><font id="errmsg" color="red"></font> </p>
<div id="config">
    <p>系统参数设置</p>
    <hr>
   <form id="frm"   action="install/setting.jsp" method="GET" onsubmit="return check()">
		<table border="0">
			<tbody>
				<!--item 开始-->
				<tr>
					<td align="right">应用服务器:</td>
					<td align="left"><input type="text" name="mapServer" size="90" value="192.168.116.47"></td></tr>
				<tr>
					<td align="right"></td>
					<td align="left"><font color="#c0c0c0">输入应用服务器IP。</font></td></tr>
				<!--item 结束-->
				
				<tr>
					<td align="right">数据服务器:</td>
					<td align="left"><input type="text" name="dataBaseIP" size="90" value="192.168.116.47"></td></tr>
				<tr>
					<td align="right"></td>
					<td align="left"><font color="#c0c0c0">输入数据服务器IP。</font></td></tr>
					
			</tbody>
		</table>
		<div id="btns" title="按钮">
		<input type="hidden" name="flag" value="check"/>
		<input type="button" style=" height:30px;width: 100px;" onclick="window.location.href='<%=basePath %>install/index.jsp'" value="上一步"/>
		<input type="button" style=" height:30px;width: 100px;" onclick="window.location.href='<%=basePath %>install/db.jsp'" value="下一步"/>
		<input type="submit" style=" height:30px;width: 100px;" value="提交"/>	
		</div>		
	</form>
</div>
<%
	if (request.getParameter("flag") == null)
		return;

	List<String> names=getParaNames(request,response);
	if(names==null||names.size()<1) return;

	String filePathDir = this.getServletContext().getRealPath("install");//+ request.getRequestURI().substring(srequest.getContextPath().length());
	//	System.out.println(filePathDir);
	String msg="";
	File file = new File(filePathDir + "/template/");

	List<File> fileList = showAllFiles(file);
	int i = fileList.size();
	while (i-- > 0) {
		String fileContext = getFileContext(fileList.get(i));
		try {
			int j = names.size();
			while (j-- > 0) {
				String pName = names.get(j);
				String value = request.getParameter(pName);
				pName = "$" + "{" + pName + "}";
				fileContext = fileContext.replace(pName, value);
			}
			
			String newFilePath = fileList.get(i).getAbsolutePath()
					.replace("install\\template\\", "");
			createNewFile(newFilePath, fileContext);
			//4test
			System.out.println("Intall***" + newFilePath);
			//System.out.println("---------" + fileContext);
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
			msg=e.getMessage();
			throw e;
		}
		msg+=fileList.get(i).getPath()+"<br>";
	}
	msg+="执行完毕，配置成功！";
	//response.getWriter().println(msg);
%>

<p><%=msg %></p>
<!--	以下是定义的方法	-->
<%!

	

private List<String> getParaNames(HttpServletRequest req,HttpServletResponse rep) throws IOException{
	Enumeration<?> pNames = req.getParameterNames();
	List<String> names = new ArrayList<String>();
	//执行结果消息	
	String msg="";
	String name="";
	String value="";
	while (pNames.hasMoreElements()) {
		name= pNames.nextElement().toString();
		if (name.equalsIgnoreCase("flag"))continue;
		value = req.getParameter(name);
		if (value == null || value.trim() == "") {
			msg+=name+":无效的参数输入，请检查！<br>";
			continue;
		}
		names.add(name);
	}
	if(!msg.equals("")){
			rep.getWriter().println(msg);
			return null;
	}
	return names;
}
//获取文件内容
	public String getFileContext(File fileName) {
		String fileContext = "";
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					new FileInputStream(fileName),"utf-8"));
			String data = null;
			while ((data = br.readLine()) != null) {
				fileContext += data + "\n";
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileContext;
	}

	//创建新文件
	public void createNewFile(String fileDirectoryAndName, String fileContent) {
		try {
			String fileName = fileDirectoryAndName;
			int end = fileDirectoryAndName.lastIndexOf("\\") + 1;
			String fileDir = fileName.substring(0, end);
			File myFileDir = new File(fileDir);//文件夹
			File myFile = new File(fileName);// 文件
			// 判断文件夹是否存在,创建文件夹
			if (!myFileDir.exists()) {
				myFileDir.mkdirs();
			}
			//判断文件是否存在,创建文件	
			if (!myFile.exists()) {
				myFile.createNewFile();
			}
			OutputStreamWriter write = new OutputStreamWriter(
					new FileOutputStream(myFile), "UTF-8");
			BufferedWriter writer = new BufferedWriter(write);
			writer.write(fileContent);
			writer.close();
		} catch (IOException ex) {
			System.out.println("无法创建新文件！");
			ex.printStackTrace();
		}
	}

	//获取文件,返回文件绝对路径+文件名数组
	public List<File> showAllFiles(File dir) throws Exception {
		File[] fs = dir.listFiles();
		List<File> result = new ArrayList<File>();
		for (int i = 0; i < fs.length; i++) {
			if (fs[i].isFile()) {
				String fileName = fs[i].getName();
				String fileExtends = fileName.substring(fileName
						.lastIndexOf(".") + 1, fileName.length());

				//目前只支持这三种格式的文件
				if (fileExtends.toLowerCase().equals("txt")
						|| fileExtends.toLowerCase().equals("xml")
						|| fileExtends.toLowerCase().equals("properties")
						|| fileExtends.toLowerCase().equals("propertie")) {

					result.add(fs[i]);
				}
			}
			if (fs[i].isDirectory()) {
				try {
					result.addAll(showAllFiles(fs[i]));
				} catch (Exception e) {
					System.out.println(e.getStackTrace());
					throw e;
				}
			}
		}
		return result;
	}%>

	</body>
</html>
