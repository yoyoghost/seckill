<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="common/tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>秒杀列表</title>
<%@include file="common/head.jsp" %>
</head>
<body>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading text-center">
				<h2>秒杀列表</h2>
			</div>
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<td>名称</td>
							<td>库存</td>
							<td>开始时间</td>
							<td>结束时间</td>
							<td>创建时间</td>
							<td>详情页</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="sk" items="${list }">
							<tr>
								<td>${sk.name }</td>
								<td>${sk.number }</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sk.startTime }"></fmt:formatDate>
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sk.endTime }"></fmt:formatDate>
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sk.createTime }"></fmt:formatDate>
								</td>
								<td>
									<a class="btn btn-info" href="/seckill/seckill/${sk.seckillId}/detail" target="_blank">详情</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>