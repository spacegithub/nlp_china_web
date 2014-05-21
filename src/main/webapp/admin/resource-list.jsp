<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!doctype html>
<html lang="cn">
<head>
<meta charset="utf-8">
<title>nlpChina 有组织无纪律</title>
<meta name="description" content="">

<meta name="viewport" content="width=device-width">

<link rel="stylesheet" href="${ctx }/admin/css/bootstrap.css">
<link rel="stylesheet" href="${ctx }/admin/css/bootstrap-responsive.css">
<link rel="stylesheet" href="${ctx }/admin/css/jquery.fancybox.css">
<link rel="stylesheet" href="${ctx }/admin/css/uniform.default.css">
<link rel="stylesheet" href="${ctx }/admin/css/bootstrap.datepicker.css">
<link rel="stylesheet" href="${ctx }/admin/css/jquery.cleditor.css">
<link rel="stylesheet" href="${ctx }/admin/css/jquery.plupload.queue.css">
<link rel="stylesheet" href="${ctx }/admin/css/jquery.tagsinput.css">
<link rel="stylesheet" href="${ctx }/admin/css/jquery.ui.plupload.css">
<link rel="stylesheet" href="${ctx }/admin/js/tableTools/css/TableTools.css">
<link rel="stylesheet" href="${ctx }/admin/css/chosen.css">
<link rel="stylesheet" href="${ctx }/admin/css/chosen.css">
<link rel="stylesheet" href="${ctx }/admin/css/style.css">
</head>
<body>
<div class="main">

	<div class="content">
			<div class="row-fluid">
				<div class="span12">
					<div class="box">
						<div class="box-head tabs">
							<h3>资源管理</h3>
							<ul class='nav nav-tabs'>
								<li>
									<a href="${ctx }/admin/resource/editer">新增资源</a>
								</li>
							</ul>
						</div>
						<div class="box-content box-nomargin">
							<div class="tab-content">
									<div class="tab-pane active" id="basic">
										<table class='table table-striped table-bordered'>
											<thead>
												<tr>
													<th>id</th>
													<th>标题</th>
													<th>发布时间</th>
													<th>作者</th>
													<th>分类</th>
													<th>标签</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${obj }" var="resource">
												<tr>
													<td>${resource.id }</td>
													<td>${resource.title }</td>
													<td>${resource.publishTime }</td>
													<td>${resource.author }</td>
													<td>${resource.categoryStr }</td>
													<td>${resource.tags }</td>
													<td>
														<a href="${ctx }/admin/resource/editer/${resource.id }">修改</a> 
														<a href="${ctx }/admin/resource/delete/${resource.id }">删除</a>
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										<div class="dataTables_info" id="DataTables_Table_3_info">Showing ${pager.pageNumber }  to ${pager.pageCount }</div>
										<div class="dataTables_paginate paging_bootstrap pagination">
											<ul>
												<c:if test="${pager.pageNumber>1}">
													<li class="prev disabled"><a href="${requestScope['javax.servlet.forward.request_uri']}?pager.pageNumber=${pager.pageNumber-1}">← Previous</a></li>
												</c:if>
												<c:forEach var="item" varStatus="status" begin="${pager.pageNumber-3<1?1:pager.pageNumber-3 }" end="${pager.pageNumber+5>=pager.pageCount?pager.pageCount:pager.pageNumber+5 }">
												<li ${pager.pageNumber==item?"class='active'":"" }><a href='${requestScope['javax.servlet.forward.request_uri']}?pager.pageNumber=${item}'>${item }</a></li>
													
												</c:forEach>
												<c:if test="${pager.pageNumber != pager.pageCount}">
													<li class="next"><a href="${requestScope['javax.servlet.forward.request_uri']}?pager.pageNumber=${pager.pageNumber+1}">Next → </a></li>
												</c:if>
											</ul>
										</div>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
</div>	
<script src="${ctx}/admin/js/jquery.js"></script>
<script src="${ctx}/admin/js/less.js"></script>
<script src="${ctx}/admin/js/bootstrap.min.js"></script>
<script src="${ctx}/admin/js/jquery.uniform.min.js"></script>
<script src="${ctx}/admin/js/bootstrap.timepicker.js"></script>
<script src="${ctx}/admin/js/bootstrap.datepicker.js"></script>
<script src="${ctx}/admin/js/chosen.jquery.min.js"></script>
<script src="${ctx}/admin/js/jquery.fancybox.js"></script>
<script src="${ctx}/admin/js/plupload/plupload.full.js"></script>
<script src="${ctx}/admin/js/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script src="${ctx}/admin/js/jquery.cleditor.min.js"></script>
<script src="${ctx}/admin/js/jquery.inputmask.min.js"></script>
<script src="${ctx}/admin/js/jquery.tagsinput.min.js"></script>
<script src="${ctx}/admin/js/jquery.mousewheel.js"></script>
<script src="${ctx}/admin/js/jquery.dataTables.min.js"></script>
<script src="${ctx}/admin/js/jquery.dataTables.bootstrap.js"></script>
<script src="${ctx}/admin/js/jquery.textareaCounter.plugin.js"></script>
<script src="${ctx}/admin/js/ui.spinner.js"></script>
<script src="${ctx}/admin/js/jquery.cookie.js"></script>
<script src="${ctx}/admin/js/tableTools/js/TableTools.min.js"></script>
<script src="${ctx}/admin/js/custom.js"></script>
<script src="${ctx}/admin/js/demo.js"></script>
</body>
</html>