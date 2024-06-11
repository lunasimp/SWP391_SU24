<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Semesters</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        .action-buttons a {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <%@include file="/components/header.jspf" %>
    <div class="grid">
        <div class="admin-sidebar">
            <!-- Add your sidebar content here -->
        </div>
        <div class="admin-content">
            <div class="title">
                <h1>Semesters</h1>
                <a href="${pageContext.request.contextPath}/manager?action=showCreateSemesterForm">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i> New Semester
                </a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="semester" items="${semesters}">
                        <tr>
                            <td>${semester.description}</td>
                            <td>${semester.startDate}</td>
                            <td>${semester.endDate}</td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/manager?action=showEditSemesterForm&id=${semester.id}">
                                    <i class="fa fa-edit" aria-hidden="true"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/manager?action=deleteSemester&id=${semester.id}" 
                                   onclick="return confirm('Are you sure you want to delete this semester?');">
                                    <i class="fa fa-trash" aria-hidden="true"></i> Delete
                                </a>
                                <a href="${pageContext.request.contextPath}/manager?action=hideSemester&id=${semester.id}">
                                    <i class="fa fa-eye-slash" aria-hidden="true"></i> Hide
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <%@include file="/components/footer.jspf" %>
</body>
</html>
