<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Semester</title>
    <link rel="stylesheet" href="C:\Users\ADMIN\Documents\GitHub\SWP391_SU24\SWP391_SU24\build\web\assets\css">
    <!-- Add your other CSS links here -->
</head>
<body>
    <%@include file="/components/header.jspf" %>
    <div class="grid">
        <div class="admin-sidebar">
            <!-- Add your sidebar content here if any -->
        </div>
        <div class="admin-content">
            <div class="form-container">
                <h1>Create Semester</h1>
                <form action="${pageContext.request.contextPath}/manager/create-semester" method="post">
                    <div>
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name">
                    </div>
                    <div>
                        <label for="description">Description:</label>
                        <textarea id="description" name="description"></textarea>
                    </div>
                    <div>
                        <label for="startdate">Start Date:</label>
                        <input type="date" id="startdate" name="startdate">
                    </div>
                    <div>
                        <label for="enddate">End Date:</label>
                        <input type="date" id="enddate" name="enddate">
                    </div>
                    <div>
                        <button type="submit">Create Semester</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@include file="/components/footer.jspf" %>
</body>
</html>
