<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

<head>
<%@include file="/common/common.jsp"%>
</head>
<body>

<!-- header start here -->
<%@include file="/header.jsp"%>
<!-- header end here -->
<!-- breadcrumb start here -->
<section id="breadcrumb-wrapper">
    <div id="breadcrumb-content">
        <ul>
        	<li><a href="${ctx }/">首页</a></li>
            <li><a href="#">精品分享</a></li>
        </ul>
    </div>
</section>
<!-- breadcrumb end here -->

<!-- maincontent start here -->
<section id="content-wrapper">   
    <div class="row">
        <div class="eight columns">   
        
        <c:forEach items="${all }" var="resource">
            <div class="blog-post">
                <div class="post-info">
            		<img src="${ctx}/images/file-ico/${resource.sysImg }.png" alt="blog-img" >
                    <div class="big-date"><fmt:formatDate value="${resource.publishTime}" pattern="dd"/></div>
                    <div class="small-month"><fmt:formatDate value="${resource.publishTime}" pattern="MM"/> <fmt:formatDate value="${resource.publishTime}" pattern="yyyy"/></div>
                    <ul>
                        <li class="author-icon"><a href="#">${resource.author }</a></li>
                        <li class="tag-icon"><a href="#">${resource.categoryStr }</a></li>
                    </ul>
                </div>
                <div class="post-content">            	                  
                    <h4><a href="single.html">${resource.title }</a></h4>
                    <p>${resource.summary }</p>
                     <div>
                     	<c:forEach items="${resource.tagList }" var="tagName">
		                    <a name="tag" class="button small blue" href="#">${tagName }</a>
	                    </c:forEach>
                    </div>
                </div>     
            </div>
            </c:forEach>  
            
            <!-- begin of pagination -->
            <div class="blog-pagination">
                <div class="pages blogpages">
                    <span class="pageof">Page ${pager.pageNumber } of ${pager.pageCount }</span>
                    	<c:forEach var="item" varStatus="status" begin="${pager.pageNumber-3<1?1:pager.pageNumber-3 }" end="${pager.pageNumber+5>=pager.pageCount?pager.pageCount:pager.pageNumber+5 }">
						  <a href='${requestScope['javax.servlet.forward.request_uri']}?pager.pageNumber=${item}' ${pager.pageNumber==item?"class='current'":"" }>${item }</a>
						</c:forEach>
					<c:if test="${pager.pageNumber != pager.pageCount}">
						<a href="${requestScope['javax.servlet.forward.request_uri']}?pager.pageNumber=${pager.pageNumber+1}">&raquo;</a>
					</c:if>
                    
                </div>
            </div>
            <!-- end of pagination -->            
        </div>
                
        <div class="four columns">
        	<aside>
            	<form id="search" action="#" method="get" />
                    <fieldset class="search-fieldset">
                        <input type="text" id="search-form" value="Search here..." onblur="if (this.value == ''){this.value = 'Search here...'; }" onfocus="if (this.value == 'Search here...') {this.value = ''; }" />
                        <button type="submit" value="Submit">Submit</button>
                    </fieldset>      						
                </form>
            </aside>
        
        	<aside>
                <h5>Categories</h5>
                <ul class="sidebar-list">
                	<c:forEach var="category" items="${APP_CATEGORYS }">
	                    <li><a href="/resource/list/${category.id }">${category.name }</a></li>                    
                    </c:forEach>
                </ul>
            </aside>
            
            
            <aside>
            	<h5>Tag Cloud</h5>
                <div class="tag-cloud">
                	<c:forEach items="${APP_TAGS }" var="tag">
                    <a title="Link title" href="#">${tag.name }</a>
                    </c:forEach>                        
                </div>
            </aside>
        </div>
    </div>
</section>
<!-- maincontent end here -->

<script type="text/javascript">
	var style = ["white","blue","green","orange","red","gray"] ;
	var tags = document.getElementsByName("tag") ;
	var i = 0 ;
	for(i = 0 ; i<tags.length ;i++){
		tags[i].className = "button small "+style[i%style.length] ;
	}
</script>

<!-- footer start here -->
<%@include file="foot.jsp"%>
<!-- footer end here -->
</body>
</html>