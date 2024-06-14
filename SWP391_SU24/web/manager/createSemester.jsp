<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Semester</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">  
    <!-- Add your other CSS links here -->
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #f4f4f4;
            border-radius: 8px;
        }

        .form-container h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-container div {
            margin-bottom: 15px;
        }

        .form-container label {
            display: block;
            margin-bottom: 5px;
        }

        .form-container input[type="text"],
        .form-container input[type="date"],
        .form-container textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-container button {
            background-color: #333333;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #444444;
        }
    </style>
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
