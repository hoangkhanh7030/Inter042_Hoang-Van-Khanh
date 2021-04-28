<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 4/28/2021
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Category list</h1>
<table border="1">
  <c:forEach items="${categoryList}" var="category">
    <tr>
      <td>${category.id}</td>
      <td>${category.code}</td>
      <td>
        ${category.name}
      </td>
    </tr>
  </c:forEach>
</table>

</body>
</html>
