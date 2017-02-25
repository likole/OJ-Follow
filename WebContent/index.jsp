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
<title>OJ-Follow</title>
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
			<div class="collapse navbar-collapse" id="navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a>首页</a></li>
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
					<div class="form-group">
						<a class="btn btn-info" data-toggle="modal"
							data-target="#registModal"><span
							class="glyphicon glyphicon-user"></span> 注册</a>
					</div>
				</form>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<div class="container">
		<div class="jumbotron">
			<h1>欢迎来到OJ-Follow</h1>
			<p>在这里，你可以Follow他人，迅速找出他人完成而你尚未完成的题目，让你更加迅速的刷OJ。</p>
			<a class="btn btn-primary btn-lg" data-toggle="modal"
				data-target="#registModal">创建账号</a>
		</div>
	</div>
	<div class="container">
		<div class="col-md-6">
			<div class="page-header">
				<h1>先尝试一下？</h1>
			</div>
			<form class="form-inline" id="try" action="try" method="post">
				<div class="form-group">
					<input type="text" class="form-control" id="yourid" name="yourid"
						placeholder="你的OJ账号">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" id="othersid"
						name="othersid" placeholder="他人OJ账号(一个)">
				</div>
				<button class="form-control btn btn-primary" type="submit">尝试一下</button>
			</form>
		</div>
		<div class="col-md-6">
			<div class="page-header">
				<h1>注册后......</h1>
			</div>
			<ul>
				<li>一次可以跟多人比较</li>
				<li>......</li>
			</ul>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="registModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">注册</h4>
				</div>
				<form role="form" id="regist" action="regist" method="post">
					<div class="modal-body">
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
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit" class="btn btn-primary">注册</button>
					</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/language/zh_CN.js"></script>
	<script>
		$(function() {
			//
			//	    $('#registModal').on('hidden.bs.modal', function() {
			//        $("#regist").data('bootstrapValidator').destroy();
			//        $('#regist').data('bootstrapValidator', null);
			//        formValidator();
			//    });
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
			$('#login').bootstrapValidator({
				container: 'tooltip',
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
		});
	</script>
</body>
</html>