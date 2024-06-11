<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Semester</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <%@include file="/components/header.jspf" %>
    <div class="grid">
        <div class="admin-sidebar">
            <!-- Add your sidebar content here -->
        </div>
        <div class="admin-content">
            <h1>Edit Semester</h1>
            <form action="${pageContext.request.contextPath}/manager" method="post">
                <input type="hidden" name="action" value="updateSemester">
                <input type="hidden" name="id" value="${semester.id}">
                <div>
                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description" value="${semester.description}" required>
                </div>
                <div>
                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" name="startDate" value="${semester.startDate}" required>
                </div>
                <div>
                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" name="endDate" value="${semester.endDate}" required>
                </div>
                <div>
                    <button type="submit">Update Semester</button>
                </div>
            </form>
        </div>
    </div>
    <%@include file="/components/footer.jspf" %>
</body>
</html>
