<%-- 
    Document   : ModifyTransporter
    Created on : 11 Jun, 2015, 12:37:10 PM
    Author     : Ankit
--%>

<%@page import="EditTransporter.editTransporter"%>
<%@page import="java.util.Map"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Transporter</title>
        <link rel="stylesheet" href="css/table.css">
        <script src="js/deleteTransporter.js"></script>
    </head>
    <body>
        <div><jsp:include page="Menu.jsp"/></div>
        <%
            Map sesion = (Map)ActionContext.getContext().getSession();
            if(sesion.get("user")==null)
            {
                RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                rd.forward(request, response);
            }
            hibernate.pojo.TblUsers user = (hibernate.pojo.TblUsers)sesion.get("user");
            EditTransporter.editTransporter e = new editTransporter();
            out.println(e.getTransporter(user));
        %>
        <form action="">
            <input type="hidden" id="hide" name="id" value="">
            <input type="hidden" id="Id" name="Id" value="">
        </form>
    </body>
</html>
