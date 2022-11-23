<%
    String message = (String) session.getAttribute("message"); //get value from session in RegisterServlet
    if (message != null) {
        //print message

        // out.println(message);

%>

<div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong><%= message%></strong> 
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>


<%             session.removeAttribute("message");
    }


%>