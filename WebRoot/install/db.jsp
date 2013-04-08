<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.io.IOException"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>数据库配置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	#content{ position: relative; padding-top: 50px;padding-left: 10;border: 1px}
	#btns{padding-left: 360px}
	</style>
	<script type="text/javascript">
		function load(){
		   init("p3");
		}
		function check(){
			var type=getId('dbtype');
			if(type.value=="sqlserver"){
				document.getElementById("errmsg").innerHTML="SqlServer数据库还未实现,需要您参与...";
				return false;
			}
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
		
		function onSelect(){
			var type=getId('dbtype');
			var un=getId("username"),pw=getId("password"); 
			if(type.value=="oracle"){
				un.value="sys";
				pw.value="orcl";
			}else if(type.value=="mysql"){
				un.value="root";
				pw.value=" ";
			}else if(type.value=="sqlserver"){
			un.value="sa";
				pw.value="123456";
			}
		}
	</script>
  </head>
	<body onload="load()">
		<%@ include file="navbar.jsp"%><p><font id="errmsg" color="red"></font> </p>
		<div id="content">
			<p>系统数据库配置</p>
			<hr/>
			<form id="frm" action="install/db.jsp" method="get" onsubmit="return check()">
				<table border="0">
					<tbody><tr>
					<td align="right">数据库地址：<br></td>
					<td align="left"><input type="text" name="address" size="90" value="localhost"></td></tr>
					<tr>
					<td align="right"></td>
					<td align="left"><font color="#c0c0c0">输入数据库服务器IP，例如192.168.116.47、localhost。</font></td></tr>
					<tr>
					<td align="right">数据库类型：</td>
					<td align="left"><select id="dbtype" name="dbtype" style="width:300px;" onchange="onSelect()"> 
											<option value="oracle" selected> 
												Oracle 
											</option> 
											<option value="mysql"> 
												MySql 
											</option> 
											<option value="sqlserver"> 
												SQLServer 
											</option> 
											
										</select>
									</td></tr>
					<tr>
					<td align="right">&nbsp;</td>
					<td align="left"><font color="#c0c0c0">选择数据库类型，需要对应的sql脚本支持（/install/db/*.sql）。</font></td></tr>
					<tr>
					<td align="right">管理员用户：</td>
					<td align="left"><input id="username" type="text" name="username" size="90" value="sys"></td></tr>
					<tr>
					<td align="right">&nbsp;</td>
					<td align="left"><font color="#c0c0c0">数据库的管理员用户如sys（oracle）、root（MySql）。</font></td></tr>
					<tr >
					<td align="right">管理员密码：</td>
					<td align="left"><input id="password" type="text" name="password" size="90" value="orcl"></td></tr>
					<tr>
					<td align="right">&nbsp;</td>
					<td align="left"><font id="tipPwd" color="#c0c0c0">管理员密码，若为空，用空格“ ”代替。</font></td></tr>
					
					</tbody></table>
					
					<div id="btns" title="按钮">
					<input type="hidden" name="flag"  value="check"/>
					<input type="button" style=" height:30px;width: 100px; right: 5px" onclick="window.location.href='<%=basePath %>install/setting.jsp'" value="上一步"/>
					<input type="submit" style=" height:30px;width: 100px; right: 5px" value="提交"/>
					<input type="button" style=" height:30px;width: 100px; right: 5px" onclick="window.location.href='<%=basePath %>'" value="完成"/>
					</div>
			</form>
			<p><font color="#ff8000">Oracle创建表空间语句</font><br>
					CREATE TABLESPACE test_data LOGGING <br>
					DATAFILE 'C:\ORACLE\PRODUCT\10.1.0\ORADATA\ORCL\TEST_DATA01.DBF' <br>
					SIZE 32M  <br>
					AUTOEXTEND ON NEXT 32M MAXSIZE 2048M <br>
					EXTENT MANAGEMENT LOCAL</p>
		</div>
		<%
			if (request.getParameter("flag") == null)
			return;
			List<String> names=getParaNames(request,response);
			if(names==null||names.size()<1) return;
			String add=request.getParameter("address");
			String type=request.getParameter("dbtype");
			String un=request.getParameter("username");
			String pw=request.getParameter("password");
			
			String cmd=getCommond(add,type,un,pw);
			if(cmd.equals("")){
				System.out.println("SqlServer数据库还未实现，需要您参与。。。");
				response.getWriter().println("<font color='#ff0000'>SqlServer数据库还未实现,需要您参与。。。</font>");
				return;
			}
			Runtime run=Runtime.getRuntime();
			try {
				System.out.println(cmd);
				run.exec(cmd);
			} catch (IOException e) {
				e.printStackTrace();
			}
		 %>
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
				//System.out.println(name);
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
		
		private String getCommond(String address,String dbtype,String username,String password){
			String cmd="";
			
			if(dbtype.trim().equalsIgnoreCase("oracle")){
				String filePath = this.getServletContext().getRealPath("install")+"/db/sample_oracle.sql";
				//cmd="cmd /c start sqlplus sys/orcl as sysdba @e:/2.sql";
				if(address.equalsIgnoreCase("localhost")||address.equalsIgnoreCase("127.0.0.1")){
					cmd="cmd /c start sqlplus "+username+"/"+password+" as sysdba @"+filePath;
				}else{
					cmd="cmd /c start sqlplus "+username+"/"+password+"@"+address+" as sysdba @"+filePath;
				}
				
			}else if(dbtype.trim().equalsIgnoreCase("mysql")){
				String filePath = this.getServletContext().getRealPath("install")+"/db/sample_mysql.sql";
				filePath=filePath.replace(" ","\" \"");
				//cmd="cmd /c mysql -u root -p''<e:3.sql";
				if(password.trim().equalsIgnoreCase("")){
					cmd="cmd /c mysql -u "+username+" <"+filePath;
				}else{
					cmd="cmd /c mysql -u "+username+" -p "+password+" <"+filePath;
				}
			}else if(dbtype.trim().equalsIgnoreCase("sqlserver")){
				cmd="";
				//TODO: something.
			}
			return cmd;
		}
		 %>
	</body>
</html>
