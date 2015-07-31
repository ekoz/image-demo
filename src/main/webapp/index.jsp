<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>image_01</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!--
			<link rel="stylesheet" type="text/css" href="styles.css">
		-->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resource/js/image/css/imgareaselect-default.css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/image/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/image/jquery.imgareaselect.pack.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/image/html2canvas.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/image/html2canvas.svg.min.js"></script>
		<script type="text/javascript">
			$(function(){
				var _width = 0;
				var _height = 0;
				var _borderCss;
				
				function imageCutCancel(){
					alert(_borderCss)
					
				}
				
				$("#btnCut").on('click', function(){
					_borderCss = $('#photo01').get(0).style.border;
					$('#photo01').css('border', '1px solid #FF0000').imgAreaSelect({
				        handles: true,
				        onSelectEnd: function (img, selection) {
					        _width = selection.width;
					        _height = selection.height;
					        $('input[name="x1"]').val(selection.x1);
							$('input[name="y1"]').val(selection.y1);
							$('input[name="x2"]').val(selection.x2);
							$('input[name="y2"]').val(selection.y2);
					    }
				    });
				    
				    
				});
				
				
				$("#btnCancel").on('click', function(){
					_width = 0;
					_height = 0;
					$('#photo01').css('border', _borderCss).imgAreaSelect({remove: true});
				});
				
				$("#btnOk").on('click', function(){
					if (_width<10 && _height<10) return false;
					
					html2canvas($('div#photo01'), {
						onrendered: function(canvas) {
							var imgCxt = canvas.toDataURL();
							
							$.post('${pageContext.request.contextPath}/servlet/FileAction', {"action":"FILE_UPLOAD", "data":imgCxt}, function(json){
								alert(json.msg);
							}, 'json');
							
							document.body.appendChild(canvas);
						},
						width: _width,
						height: _height
					});
					
					$("#btnCancel").click();
				});
			});
		</script>
	</head>

	<body>
		<!-- 
		<img id="photo" src="${pageContext.request.contextPath }/image/flower2.jpg" />
		 -->
		
		<div id="photo01" style="border:1px solid #ddd;width:500px;height:400px;">
			麦蒂说<br/>
			你好<br/>
			我说<br/>
			卡特扣篮很棒<br/>
			麦蒂说<br/>
			我去年买了个表<br/>
			我说<br/>
			擦擦擦<br/>
			卡特说<br/>
			火箭主帅拒绝球员轮休：歇一场你也不会变21岁<br/>
			我说<br/>
			魔兽亲承非常接近复出 不会出战背靠背比赛<br/>
			麦蒂说<br/>
			骑士下赛季或签俄中锋 KD缺训伤势恢复或倒退<br/>
			科比说<br/>
			老鱼与相爱10年妻子离婚 情场球商双失意<br/>
			麦蒂说<br/>
			勇士依赖投篮赢球？ 爆冷绝杀!NCAA今天嗨了<br/>
		</div>
		<br>
		<button id="btnCut">截图</button>
		<button id="btnOk">确定</button>
		<button id="btnCancel">取消</button>
		
		<form action="" method="post">
			<input type="text" name="x1" value="" />
			<input type="text" name="y1" value="" />
			<input type="text" name="x2" value="" />
			<input type="text" name="y2" value="" />
		</form>
	</body>
</html>