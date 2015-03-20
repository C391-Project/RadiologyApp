<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.*" %>

<%  
	DataSource ds = new DataSource();
	if (ds.isNotConfigured()) {
		//redirect to oracle login page and remember this page.
		session.setAttribute("returnPage", "UserManage/persons-view.jsp");
		response.sendRedirect("/oracle-login");
	}
%>

<header id="top">
	<h1>User Management</h1>
	<nav>
		<ul>
			<li><a href="/usermanage/persons">Persons</a></li>
			<li><a href="/usermanage/users">Users</a></li>
			<li><a href="/usermanage/familydoctor">Family Doctor</a></li>
		</ul>
	</nav>
</header>