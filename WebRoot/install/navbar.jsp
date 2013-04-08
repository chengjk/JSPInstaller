<%@page contentType="text/html;charset=utf-8"%>
<style type="text/css">
div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,ul,fieldset,legend,input,button,textarea,p,blockquote{margin:0; padding:0;}
body { font:18px "5B8B4F53",san-serif; color:#404040;   }
a { text-decoration:none; color:#808080 }
a:hover { text-decoration:underline; color:#ba2636 }
ul, li { list-style:none; }
	#nav{height:30px;width:542px; overflow:hidden;  float:left; margin-right:17px;position:relative ;}
	#nav ul{ height:27px; width:100%; }
	#nav ul li{width:100px; height:24px; float:left; padding-right:1px; display:inline; cursor:pointer; }
	#nav a{background:#999;width:100%; height:24px; display:block; float:left; outline:none; color:#fff; line-height:24px; text-align:center; font-size:16px; font-weight:bold; overflow:hidden}
	#navCur{ position:absolute; left:0; bottom:0; height:3px; color:#F00; width:100px; margin:0; padding:0; display: block; float:none; background:#FF0000; cursor:pointer;  overflow:hidden}

</style>

<div id="nav">
	<ul>
		<li id="p1">
			<a href="install/index.jsp">说明</a>
		</li>
		<li id="p2">
			<a href="install/setting.jsp">系统参数</a>
		</li>
		<li id="p3">
			<a href="install/db.jsp">数据库</a>
		</li>
	</ul>
	<span id="navCur"></span>
</div>
<script type="text/javascript">

function init(id){
	var navCur = getId('navCur');
	var item=getId(id);
	item.className="cur";
	navCur.style.left = item.offsetLeft + "px";
}
function getId(id){
	return document.getElementById(id)
}
</script>
