<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="common/tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>秒杀详情</title>
<%@include file="common/head.jsp" %>
<script type="text/javascript">
	var ctx = '${ctx}', ctxStatic='${ctxStatic}';
</script>
</head>
<body>
<div class="container">
		<div class="panel panel-default text-center">
			<div class="panel-heading">
				<h1>${seckill.name }</h1>
			</div>
			<div class="panel-body">
				<h2 class="text danger">
					<span class="glyphicon glyphicon-time"></span>
					<span class="glyphicon" id="seckill-box"></span>
				</h2>
			</div>
		</div>
	</div>
	<!-- Button trigger modal 
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
	  Launch demo modal
	</button>
	-->
	<!-- Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h3 class="modal-title text-center" id="myModalLabel">
	        	<span class="glyphicon  glyphicon-phone"></span>秒杀电话：
	        </h3>
	      </div>
	      <div class="modal-body">
	      	<div class="row">
	      		<div class="col-xs-8 col-xs-offset-2">
	      			<input type="text" name="killPhone" id="killPhoneKey" placeholder="请填写手机号^_^" class="form-control"/>
	      		</div>
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <span id="killPhoneMessage" calss="glyphicon "></span>
	        <button type="button" id="killPhonebtn" class="btn btn-success">
				<span class="glyphicon  glyphicon-phone"></span>
				Submit
			</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<td>名称</td>
							<td>库存</td>
							<td>开始时间</td>
							<td>结束时间</td>
							<td>创建时间</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${seckill.name }</td>
							<td>${seckill.number }</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${seckill.startTime }"></fmt:formatDate>
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${seckill.endTime }"></fmt:formatDate>
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${seckill.createTime }"></fmt:formatDate>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script src="http://cdn.bootcss.com/jquery.countdown/2.2.0/jquery.countdown.min.js"></script>
<script type="text/javascript" src="<c:url value='/resource/script/seckill.js'/>"></script>
<script type="text/javascript">
$(function(){
	seckill.detail.init({
		seckillId:${seckill.seckillId},
		startTime:${seckill.startTime.time},//直接将时间转化为毫秒
		endTime:${seckill.endTime.time}
	});
});
</script>
</html>