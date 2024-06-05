<%-- 
    Document   : privacyPolicy
    Created on : Jun 16, 2023, 12:26:53 AM
    Author     : Yui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Privacy Policy</title>
        <%@include file="/components/headCommon.jspf" %>
    </head>
    <body>
        <%@include file="/components/header.jspf" %>
        <div class="pp" >
            <h1>Privacy Policy Statement</h1>
            <video autoplay="autoplay"  controls muted loop src="${pageContext.request.contextPath}/assets/video/laughing-frog.mp4" style="margin: auto; width: 100%"></video>
            <p>Copyright PEPE Team Summer 2024</p>
            <p>Feel free to use the code as you like as long as you keep our copyright</p>
        </div>

        <%@include file="/components/footer.jspf" %>

    </body>
    <style>
        @media (min-width: 768px) {
            .pp {
                width: 50vw;
                margin: auto;
            }
        }
        .pp p {
            margin-bottom: 1rem;
        }
    </style>
</html>
