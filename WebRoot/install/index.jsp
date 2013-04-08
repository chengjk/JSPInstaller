<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>系统安装开始</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<style type="text/css">
	#content{ position: relative; padding-top: 50px;padding-left: 10px;}
	#btns{padding-left: 500px; padding-top: 50px}
	</style>
	<script type="text/javascript">
		function load(){
		   init("p1");
		}
	</script>
  </head>
  <body onload="load()">
   <%@ include file="navbar.jsp" %>
   <div id="content">
   <p>简介</p>
   <hr/>
    <p>系统简介：</p>
    <p>安装说明：</p>
    <ol><li>&nbsp;&nbsp;&nbsp;欢迎来到系统安装界面。</li>
    <li>&nbsp;&nbsp;&nbsp;参数设置后请点击&ldquo;提交&rdquo;按钮完成该步骤的配置工作，再进行下一步操作。</li>
    <li>&nbsp;&nbsp;&nbsp;所有步骤都非必须，按实际情况操作。<br>
    </li></ol>
    
   	<div id="btns" title="按钮">
  		 <input type="button" style=" height:30px;width: 100px;" onclick="window.location.href='<%=basePath %>install/setting.jsp'" value="安装"/>
  	</div>
  	<%=basePath %>
   </div>
  </body>
</html>
