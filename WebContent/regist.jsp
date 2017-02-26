<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>欢迎注册OJ-Follow</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/bootstrapValidator.css" rel="stylesheet" />
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
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
				<a class="navbar-brand">OJ-Follow</a>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<div class="container">
		<div class="jumbotron">
			<h1>感谢您的注册!</h1>
			<p>来完善下信息吧~</p>
			<p>PS:你即将进入你的主页，点击右上角的用户名即可更改设置</p>
			<form id="setinfo" action="setinfo?what=init" method="post">
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-envelope"></span>
						</div>
						<input type="text" class="form-control" name="email" id="email"
							placeholder="请输入你的邮箱" />
					</div>
				</div>
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-credit-card"></span>
						</div>
						<input type="text" class="form-control" name="oj" id="oj"
							placeholder="请输入你的OJ账号" />
					</div>
				</div>
				<div class="pull-right">
					<a href="home" class="btn btn-default">暂不设置</a>
					<button type="submit" class="btn btn-primary">提交信息</button>
				</div>
			</form>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/language/zh_CN.js"></script>
	<script>
		$(function() {/* 文档加载，执行一个函数*/
			$('#setinfo').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					email : {
						validators : {
							notEmpty : {},
							emailAddress : {}
						}
					},
					oj : {
						validators : {
							notEmpty : {},
							remote : {
								url : 'exist?what=oid',
								message : '不存在此用户，请检查输入是否有误',
								delay : 1000,
								type : 'GET'
							}
						}
					},

				}
			});
		});
	</script>
</body>
</html>