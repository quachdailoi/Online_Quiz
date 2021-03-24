<%-- START SEARCH BAR --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Start Main Top -->
<div class="main-top" style="margin-left:1px">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 user-name-welcome"> 
                <c:set var="role" value="${sessionScope.USER.role}"/>
                <c:choose>
                    <c:when test="${not empty role}">
                        <c:choose>
                            <c:when test="${role eq true}">
                                <p style="display:inline; color: #ffffff; font-family: 'Raleway',sans-serif;text-transform: uppercase;"> Welcome Teacher - </p>
                            </c:when>
                            <c:otherwise>
                                <p style="display:inline; color: #ffffff; font-family: 'Raleway',sans-serif;text-transform: uppercase;"> Welcome Student - </p>
                            </c:otherwise>
                        </c:choose>
                        <i class="fas fa-user s_color" style="color:#DDDDDD;"></i> <font class="user-name">${sessionScope.USER.name} </font>       
                    </c:when>
                </c:choose>
            </div>
            <div class="col-sm-5" style="text-align: right">
                <div class="text-slid-box">
                    <div id="offer-box" class="carouselTicker">

                    </div>
                </div>
            </div>
            <c:set var="is_hidden" value="style=\"display: none\""/>
            <div class="col-sm-2" style="text-align: right">
                <form action="index">
                    <button type="submit" name="btnAction" value="Log in" class='glow-on-hover' ${not empty sessionScope.USER ? is_hidden : ''}>Log in</button>
                </form>
            </div>
            <div class="col-sm-2">
                <form action="logout">
                    <button type="submit" name="btnAction" value="Log out" class='glow-on-hover' ${empty sessionScope.USER ? is_hidden : ''}>Log out</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End Main Top -->

<!-- Start Main Top -->
<header class="main-header">
    <!-- Start Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
        <div class="" style="width: 1525px; padding: 20px; background-color: rgb(26, 26, 26); float: top">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="SearchServlet"><img src="images/logo.png" class="logo" alt=""></a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
            <c:set var="role" value="${sessionScope.USER.role}"/>
            <div class="collapse navbar-collapse" id="navbar-menu">
                <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                    <li class="nav-item active">
                        <a class="nav-link" href="home" style="float: top; margin-right: 1500px">Home</a>
                    </li>
                    <c:if test="${not role eq true}">
                        <li class="side-menu">
                            <a class="nav-link" href="history">Test History</a>
                        </li>
                    </c:if>
                </ul>
            </div>
            <!-- /.navbar-collapse -->

            <!-- Start Atribute Navigation -->
            <c:if test="${sessionScope.USER.role eq true}">
                <div style="float: right; padding-bottom: 15px; padding-left: 50px; border-radius: 20px">
                    <form style="padding: 10px; background-color: rgb(136, 139, 39); border-radius: 20px" action="search" method="POST">
                        <input name="p_cur_page" value="1" type="hidden"/>
                        <!-- para for scroll down: NAME="p_is_click_page" / VALUE="true" -->
                        <input type="hidden" value="true" name="p_is_scroll_down"/>
                        <input type="hidden" name="p_cur_page" value="${requestScope.CUR_PAGE}"/>
                        <c:set var="search_question_content" value="${param.p_search_content}"/>
                        <%-- para for name searching: name="p_search_name" / VALUE="${not empty search_name ? search_name : ''}" --%>
                        <font style="padding-left: 5px; font-weight: bold; color: rgb(249, 249, 235)">Question Content</font> <input type="text" name="p_search_content" value="${param.p_search_content}" style="height: 30px; border-radius: 20px"/>
                        <c:set var="search_subject" value="${param.p_search_subject}"/>
                        <font style="font-weight: bold; color: rgb(249, 249, 235)">Subject</font> <select name="p_search_subject" style="height: 30px; float: top; border-style: solid">
                            <option value="none" selected style="">---None---</option>
                            <c:set var="list_subject" value="${applicationScope.LIST_SUBJECT}"/>
                            <c:forEach items="${list_subject}" var="subject">
                                <option ${subject.subjectID eq search_subject ? 'selected' : ''} value="${subject.subjectID}">${subject.subjectName}</option>
                            </c:forEach>
                        </select>
                        <c:set var="search_status" value="${param.p_search_status}"/>    
                        <font style="font-weight: bold; color: rgb(249, 249, 235)">Status</font> <select name="p_search_status" style="height: 30px; width: 100px; float: top; border-style: solid">
                            <option style="border-radius: 20px; align-content: center" value="none" selected>---None---</option>
                            <option style="border-radius: 20px" value="active" ${search_status eq 'active' ? 'selected' : ''}>Active</option>
                            <option style="border-radius: 20px" value="inactive" ${search_status eq 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <button style="border-radius: 10px; margin-bottom: 5px" type="submit" value="Search" name="btnAction"><i class="fa fa-search" style="height: 20px"></i></button>
                    </form> 
                </div>
            </c:if>

            <!-- End Atribute Navigation -->
        </div>

    </nav>
    <!-- End Navigation -->
</header>
<!-- End Main Top -->

<%-- END SEARCH BAR --%>