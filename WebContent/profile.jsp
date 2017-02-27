<%@page import="util.MD5Util"%>
<%@page import="entity.Neglet"%>
<%@page import="entity.User,java.util.List,entity.Mapping"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	if (session.getAttribute("login") == null)
		response.sendRedirect("index.jsp");
	User user = (User) request.getAttribute("user");
	List<Mapping> mappings = (List<Mapping>) request.getAttribute("mappings");
	List<Neglet> neglets = (List<Neglet>) request.getAttribute("neglets");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>设置</title>
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
					<li><a href="home">主页</a></li>
					<li class="active"><a>设置</a></li>
				</ul>
				<div class="navbar-right navbar-text">
					你好,<%=session.getAttribute("username")%>
					<a class="btn btn-danger btn-xs" href="logout">退出</a>
				</div>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<div class="container">
		<div class="col-md-8">
			<table class="table">
				<caption>个人信息</caption>
				<tbody>
					<tr>
						<td>Email</td>
						<td><%=user.getEmail()%> <span
							class="label label-<%=user.isEmail_valid() ? "success" : "danger"%>"><%=user.isEmail_valid() ? "已验证" : "未验证"%></span></td>
						<td><a data-toggle="modal" data-target="#change_email">更改</a>
							<%=user.isEmail_valid() ? "" : ("<a href='mail?verify="+MD5Util.getMD5(user.getEmail())+"'>验证</a>") %></td>
					</tr>
					<tr>
						<td>OJ账号</td>
						<td><%=user.getOid()%></td>
						<td><a data-toggle="modal" data-target="#change_oj">更改</a></td>
					</tr>
				</tbody>
			</table>
			<form class="form form-horizontal" id="add" role="form"
				action="setinfo?what=following" method="post">
				<table class="table">
					<caption>Following</caption>
					<tbody>
						<%
							for (Mapping mapping : mappings) {
						%>
						<tr>
							<td><%=mapping.getAlias()%></td>
							<td><%=mapping.getTargetid()%></td>
							<td><a
								href="setinfo?what=delete_following&id=<%=mapping.getMid()%>&verify=<%=MD5Util.getMD5(mapping.getMid()+user.getUsername())%>">删除</a></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td>
								<div class="form-group col-md-12">
									<input name="alias" id="alias" class="form-control"
										placeholder="别名">
								</div>
							</td>
							<td>
								<div class="form-group col-md-12">
									<input name="oj" id="oj" class="form-control"
										placeholder="OJ账号">
								</div>
							</td>
							<td>
								<button type="submit" class="btn btn-success">添加</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="col-md-3 col-md-offset-1">
			<table class="table">
				<caption>忽略列表</caption>
				<tbody>
					<%
						for (Neglet neglet : neglets) {
					%>
					<tr>
						<td><%=neglet.getPid()%></td>
						<td><a
							href="setinfo?what=remove_neglet&nid=<%=neglet.getNid()%>">恢复</a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="modal fade" id="change_email" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">更改Email地址</h4>
				</div>
				<div class="modal-body">
					<form id="change_email_form" action="setinfo?what=change_email"
						method="post">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-envelope"></span>
								</div>
								<input type="text" class="form-control" name="email" id="email"
									placeholder="请输入你的邮箱" />
							</div>
						</div>
						<button type="submit" class="btn btn-primary btn-block">提交信息</button>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<div class="modal fade" id="change_oj" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">更改OJ账号</h4>
				</div>
				<div class="modal-body">
					<form id="change_oj_form" action="setinfo?what=change_oj" method="post">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<span class="glyphicon glyphicon-credit-card"></span>
								</div>
								<input type="text" class="form-control" name="oj" id="oj"
									placeholder="请输入你的OJ账号" />
							</div>
						</div>
						<button type="submit" class="btn btn-primary btn-block">提交信息</button>
					</form>
				</div>
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
			$('#add').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					alias : {
						validators : {
							notEmpty : {

							},
							stringLength : {
								max : 32
							}
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
			//
			$('#change_email_form').bootstrapValidator({
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
				}
			});
			//
			$('#change_oj_form').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
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