<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="dao.ProblemDAO"%>
<%
	if (session.getAttribute("login") == null)
		response.sendRedirect("index.jsp");
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
					<li class="active"><a>主页</a></li>
				</ul>
                <div class="navbar-right navbar-text">
                	你好,<a href="profile"><%=session.getAttribute("username") %></a>
                    <a class="btn btn-danger btn-xs" href="logout">退出</a>
                </div>
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
						href="http://acm.imudges.com:666/JudgeOnline/problem.php?id=<%=str[i]%>" target="_blank"><%=ProblemDAO.getTitle(str[i])%></a></td>
					<td style="width: 300px;">
						<div class="col-sm-8">
							<a class="btn btn-success btn-sm btn-block"
								href="http://acm.imudges.com:666/JudgeOnline/problem.php?id=<%=str[i]%>"
								target="_blank"><span class="glyphicon glyphicon-new-window"></span>
								前往</a>
						</div>
						<div class="col-sm-4">
							<a class="btn btn-sm btn-danger btn-block" href="setinfo?what=add_neglet&pid=<%=str[i]%>">忽略</a>
						</div>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/language/zh_CN.js"></script>
</body>
</html>