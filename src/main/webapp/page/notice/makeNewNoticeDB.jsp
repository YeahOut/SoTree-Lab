<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
	<body>
	<%
	int temp = 0, cnt;
	int new_notice_num = 0, refer_num = 0;
	String title, notice_date, writer, id, passwd, reply;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql_update;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/sotree?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "sotree", "0119");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		String sql = "select count(*) as cnt, max(notice_num) as max_id from table_notice";
		rs = stmt.executeQuery(sql);
	}
	catch(Exception e){
		out.println("DB 연동 오류입니다.:" + e.getMessage());
	}
	
	while(rs.next()){
		cnt = Integer.parseInt(rs.getString("cnt"));
		if(cnt != 0)
			new_notice_num = Integer.parseInt(rs.getString("max_id"));
	}
	new_notice_num++;
	title = request.getParameter("title");
	notice_date = request.getParameter("notice_date");
	writer = request.getParameter("writer");
	id = request.getParameter("id");
	passwd = request.getParameter("passwd");
	reply = request.getParameter("reply");
	
	if("y".equals(reply)){
		refer_num = Integer.parseInt(request.getParameter("refer_num"));
	} else {
		refer_num = new_notice_num;
	}
	
	sql_update = "insert into table_notice values (" + new_notice_num + ",'" + title + "','"
		+ notice_date + "','" + writer + "','" + refer_num + "','" + id + "'," + passwd + ")";
	try{
		stmt.executeUpdate(sql_update);
	}
	catch(Exception e){
		out.println("DB 연동 오류입니다.:" + e.getMessage());
	}
	%>
	<center>
		<h2>작성한 글이 등록되었습니다.</h2>
		<a href="mainNotice.jsp">게시글 목록 보기</a>
	</center>
	</body>
</html>