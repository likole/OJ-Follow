<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="dao.ProblemDAO"%>
<%if(session.getAttribute("login")!=null) response.sendRedirect("home"); %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>OJ-Follow</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/bootstrapValidator.css" rel="stylesheet" />
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
body {
	margin-bottom: 30px;
}

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
				<a class="navbar-brand">OJ-Follow</a>
			</div>
			<div class="collapse navbar-collapse" id="navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">首页</a></li>
					<li class="active"><a>演示</a></li>
				</ul>
				<form class="navbar-form navbar-right" role="form" id="login"
					action="login" method="post">
					<div class="form-group">
						<label class="sr-only" for="login_username">用户名</label> <input
							type="text" class="form-control" name="login_username"
							id="login_username" placeholder="请输入用户名">
					</div>
					<div class="form-group">
						<label class="sr-only" for="login_password">密码</label> <input
							type="password" class="form-control" name="login_password"
							id="login_password" placeholder="请输入登陆密码">
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-success">
							<span class="glyphicon glyphicon-log-in"></span> 登陆
						</button>
					</div>
				</form>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<div class="container">
		<table class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th class="text-center">序号</th>
					<th class="text-center">题号</th>
					<th class="text-center">题目</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					String[] str = (String[]) request.getAttribute("data");
					for (int i = 0; i < str.length; i++) {
				%>
				<tr>
					<td class="text-center" style="width: 48px; vertical-align: middle"><%=i + 1%></td>
					<td class="text-center" style="width: 48px; vertical-align: middle"><%=str[i]%></td>
					<td class="td-responsive" style="vertical-align: middle"><a
						href="http://acm.imudges.com:666/JudgeOnline/problem.php?id=<%=str[i]%>"  target="_blank"><%=ProblemDAO.getTitle(str[i])%></a></td>
					<td style="width: 300px;">
						<div class="col-sm-8">
							<a class="btn btn-success btn-sm btn-block"
								href="http://acm.imudges.com:666/JudgeOnline/problem.php?id=<%=str[i]%>"
								target="_blank"><span class="glyphicon glyphicon-new-window"></span>
								前往</a>
						</div>
						<div class="col-sm-4">
							<button class="btn btn-sm btn-danger btn-block"
								data-toggle="tooltip" data-placement="right" title="登陆后即可使用">忽略</button>
						</div>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<div class="container">
		<div class="page-header">
			<h1>觉得好用？</h1>
		</div>
		<form role="form" id="regist" action="regist" method="post">
			<div class="form-group">
				<label class="sr-only" for="regist_username">用户名</label> <input
					type="text" class="form-control" name="regist_username"
					id="regist_username" placeholder="请输入用户名">
			</div>
			<div class="form-group">
				<label class="sr-only" for="regist_password">密码</label> <input
					type="password" class="form-control" name="regist_password"
					id="regist_password" placeholder="请设置密码">
			</div>
			<div class="form-group">
				<label class="sr-only" for="regist_repassword">密码</label> <input
					type="password" class="form-control" name="regist_repassword"
					id="regist_repassword" placeholder="请再次输入密码">
			</div>
			<button type="submit" class="btn btn-primary pull-right">创建账号，发掘更多功能</button>
		</form>

	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/language/zh_CN.js"></script>
	<script>
		$(function() {
			//
			$("[data-toggle='tooltip']").tooltip();
			//
			$("#regist_username").bind(
					'input propertychange',
					function() {
						if ($("#regist_password").val() != null
								&& $("#regist_password").val() != "") {
							$("#regist").bootstrapValidator('revalidateField',
									'regist_password');
							$("#regist").bootstrapValidator('revalidateField',
									'regist_repassword');
						}

					});

			$('#regist').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					regist_username : {
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
							},
							threshold : 6,
							remote : {
								url : 'exist?what=username',
								message : '用户已存在',
								delay : 1000,
								type : 'GET'
							}
						}
					},
					regist_password : {
						message : '密码无效',
						validators : {
							notEmpty : {},
							stringLength : {
								min : 6,
								max : 16
							},
							identical : {
								field : 'regist_repassword',
								message : '两次密码不一致'
							},
							different : {
								field : 'regist_username',
								message : '不能和用户名相同'
							},
							regexp : {
								regexp : /^[a-zA-Z0-9_]+$/,
								message : '密码只能由数字字母下划线组成'
							}
						}
					},
					regist_repassword : {
						message : '密码无效',
						validators : {
							notEmpty : {},
							stringLength : {
								min : 6,
								max : 16
							},
							identical : {
								field : 'regist_password',
								message : '两次密码不一致'
							},
							different : {
								field : 'regist_username',
								message : '不能和用户名相同'
							},
							regexp : {
								regexp : /^[a-zA-Z0-9_]+$/,
								message : '密码只能由数字字母下划线组成'
							}
						}
					},
				}
			});
		});
	</script>
</body>
</html>