<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	if (session.getAttribute("login") != null)
		response.sendRedirect("home");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>登陆失败</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/bootstrapValidator.css" rel="stylesheet" />
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
.td-responsive {
	max-width: 500px;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
}
</style>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar-collapse"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">OJ-Follow</a>
			</div>
			<div class="collapse navbar-collapse" id="navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">首页</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
    <div class="container">
    <div class="col-md-6 col-md-offset-3">
    <div class="alert alert-danger">用户名或密码错误</div>
    				<form class="form" role="form" id="login"
					action="login" method="post">
					<div class="form-group">
						<label class=" sr-only" for="login_username">用户名</label> <input
							type="text" class="form-control" name="login_username"
							id="login_username" placeholder="请输入用户名">
					</div>
					<div class="form-group">
						<label class=" sr-only" for="login_password">密码</label> <input
							type="password" class="form-control" name="login_password"
							id="login_password" placeholder="请输入登陆密码">
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-success pull-right">
							<span class="glyphicon glyphicon-log-in"></span> 登陆
						</button>
					</div>
				</form>
    </div>  	
    </div>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/language/zh_CN.js"></script>
    <script>
	$('#login').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					login_username : {
						validators : {
							notEmpty : {

							},
							stringLength : {
								min : 6,
								max : 32
							},
							regexp : {
								regexp : /^[a-zA-Z0-9_]+$/,
								message : '用户名只能由数字字母下划线组成'
							}
						}
					},
					login_password : {
						validators : {
							notEmpty : {},
							stringLength : {
								min : 6,
								max : 16
							},
							regexp : {
								regexp : /^[a-zA-Z0-9_]+$/,
								message : '密码只能由数字字母下划线组成'
							}
						}
					},
				}
			});
	</script>
</body>
</html>