<%-- 
    Document   : student_home
    Created on : Jan 25, 2021, 5:56:58 PM
    Author     : GF65
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/custom.css">
        <link rel="stylesheet" href="css/custom_1.css">
        <link rel="stylesheet" href="css/all.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>

        <!-- Bootstrap styles -->
        <link href="assets/css/bootstrap.css" rel="stylesheet"/>
        <!-- Customize styles -->
        <link href="style.css" rel="stylesheet"/>
        <!-- font awesome styles -->
        <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet">

        <!-- Favicons -->
        <link rel="shortcut icon" href="assets/ico/trophy.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Merriweather:400,900,900i" rel="stylesheet">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <style>
            html, body {margin: 0; height: 100%; overflow-x: hidden; width: 100%}
            /*            --------------------------*/
            @import 'https://fonts.googleapis.com/css2?family=Montserrat&display=swap';

            .container {
                background-color: #555;
                color: #ddd;
                border-radius: 10px;
                padding: 10px;
                font-family: 'Montserrat', sans-serif;
                max-width: 700px
            }

            .container>p {
                font-size: 32px
            }

            .question {
                width: 75%
            }

            .options {
                position: relative;
                padding-left: 10px
            }

            #options label {
                display: block;
                margin-bottom: 15px;
                font-size: 14px;
                cursor: pointer
            }

            .options input {
                opacity: 0
            }

            .checkmark {
                position: absolute;
                top: 20px;
                left: 0;
                height: 25px;
                width: 25px;
                background-color: #555;
                border: 1px solid #ddd;
                border-radius: 50%
            }

            .options input:checked~.checkmark:after {
                display: block
            }

            .options .checkmark:after {
                content: "";
                width: 10px;
                height: 10px;
                display: block;
                background: white;
                position: absolute;
                top: 50%;
                left: 50%;
                border-radius: 50%;
                transform: translate(-50%, -50%) scale(0);
                transition: 300ms ease-in-out 0s
            }

            .options input[type="radio"]:checked~.checkmark {
                background: #21bf73;
                transition: 300ms ease-in-out 0s
            }

            .options input[type="radio"]:checked~.checkmark:after {
                transform: translate(-50%, -50%) scale(1)
            }

            .btn-primary {
                background-color: #555;
                color: #ddd;
                border: 1px solid #ddd
            }

            .btn-primary:hover {
                background-color: #21bf73;
                border: 1px solid #21bf73
            }

            .btn-success {
                padding: 5px 25px;
                background-color: #21bf73
            }

            @media(max-width:576px) {
                .question {
                    width: 100%;
                    word-spacing: 2px
                }
            }


            .draw-border {
                box-shadow: inset 0 0 0 4px #fff;
                color: #fff;
                transition: color 0.25s 0.0833333333s;
                position: relative;
                border-radius: 10px;
            }
            .draw-border::before, .draw-border::after {
                border: 0 solid transparent;
                box-sizing: border-box;
                content: '';
                pointer-events: none;
                position: absolute;
                width: 0;
                height: 0;
                bottom: 0;
                right: 0;
            }
            .draw-border::before {
                border-bottom-width: 4px;
                border-left-width: 4px;
            }
            .draw-border::after {
                border-top-width: 4px;
                border-right-width: 4px;
            }
            .draw-border:hover {
                color: #000;
            }
            .draw-border:hover::before, .draw-border:hover::after {
                border-radius: 10px;
                border-color: #000;
                transition: border-color 0s, width 0.25s, height 0.25s;
                width: 100%;
                height: 100%;
            }
            .draw-border:hover::before {
                transition-delay: 0s, 0s, 0.25s;
            }
            .draw-border:hover::after {
                transition-delay: 0s, 0.25s, 0s;
            }
            .btn {
                background: none;
                border: none;
                cursor: pointer;
                line-height: 1.5;
                font: 300 1.2rem 'Roboto Slab', sans-serif;
                padding: 1em 2em;
                letter-spacing: 0.045rem;
            }
            .btn:focus {
                outline: 2px dotted #fff;
            }

            #back2Top {
                width: 40px;
                line-height: 40px;
                overflow: hidden;
                z-index: 999;
                cursor: pointer;
                -moz-transform: rotate(270deg);
                -webkit-transform: rotate(270deg);
                -o-transform: rotate(270deg);
                -ms-transform: rotate(270deg);
                transform: rotate(270deg);
                position: fixed;
                bottom: 50px;
                right: 0;
                background-color: #DDD;
                color: #555;
                text-align: center;
                font-size: 30px;
                text-decoration: none;
            }
            #back2Top:hover {
                background-color: #DDF;
                color: #000;
            }
        </style>
    </head>
    <body id="here">
        <input type="hidden" value="${requestScope.NOTIFY}" id="notify"/>
        <script>
            var notify = document.getElementById("notify").value;
            if (notify.length !== 0) {
                alert(notify);
            }
        </script>
        <%--Start Header and Search Bar  --%>
        <c:import url="search_nav_bar.jsp"/>
        <%--End Header and Search Bar  --%>

        <!--      Start  Body-->
        <div class="row" style="margin-left: 50px" >
            <div id="sidebar" class="span3">
                <div class="well well-small" style="width: 120%">
                    <ul class="nav nav-list" style="display: inline-block">

                        <c:set var="listSubject" value="${applicationScope.LIST_SUBJECT}"/>
                        <c:forEach items="${listSubject}" var="subject">
                            <li><a href="search?p_search_subject=${subject.subjectID}&goto=details"><span class="icon-chevron-right"></span>${subject.subjectName}</a></li><br/>
                                </c:forEach>
                        <li style="border:0"> &nbsp;</li><br/>
                        <li> <a class="totalInCart" href="+++"><strong><span class="badge badge-warning pull-right" style="line-height:18px;">Add Subject <i class="fa fa-plus-circle"></i></span></strong></a></li>
                    </ul>
                </div>

                <br>
                <br>
            </div>
            <div class="span12" style="margin-left: 120px">
                <div class="well np">
                    <div id="myCarousel" class="carousel slide homCar">
                        <div class="carousel-inner">
                            <div class="item">
                                <img style="width:100%" src="assets/img/bootstrap_free-ecommerce.png" alt="bootstrap ecommerce templates">
                                <div class="carousel-caption">
                                    <h4>Bootstrap shopping cart</h4>
                                    <p><span>Very clean simple to use</span></p>
                                </div>
                            </div>
                            <div class="item">
                                <img style="width:100%" src="assets/img/carousel1.png" alt="bootstrap ecommerce templates">
                                <div class="carousel-caption">
                                    <h4>Bootstrap Ecommerce template</h4>
                                    <p><span>Highly Google seo friendly</span></p>
                                </div>
                            </div>
                            <div class="item active">
                                <img style="width:100%" src="assets/img/carousel3.png" alt="bootstrap ecommerce templates">
                                <div class="carousel-caption">
                                    <h4>Twitter Bootstrap cart</h4>
                                    <p><span>Very easy to integrate and expand.</span></p>
                                </div>
                            </div>
                            <div class="item">
                                <img style="width:100%" src="assets/img/bootstrap-templates.png" alt="bootstrap templates">
                                <div class="carousel-caption">
                                    <h4>Bootstrap templates integration</h4>
                                    <p><span>Compitable to many more opensource cart</span></p>
                                </div>
                            </div>
                        </div>
                        <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                        <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
                    </div>
                </div>
                <!--
                Start of subjects and questions
                -->
                <div class="well well-small">
                    <hr class="soften"/>
                    <c:set var="list_subject" value="${requestScope.LIST_QUESTION}"/>
                    <c:forEach items="${list_subject}" var="subject">
                        <div class="card">
                            <div class="card-header" style="background-color: #aaad44">
                                <font style="color: #fff; font-weight: bold; font-size: 20px">${subject.subjectName}</font><a class="btn draw-border" href="search?p_search_subject=${subject.subjectID}&goto=details" title="View more" style="margin-left:650px; width: 200px; height: 50px">View More<span class="icon-plus"></span></a>
                            </div>
                            <div class="card-body">
                                <!--  List of questions -->
                                <c:set var="list_question" value="${subject.listQuestion}"/>
                                <c:forEach items="${list_question}" var="question" varStatus="counter">
                                    <div class="MyQuestion" style="margin-top: 0px">
                                        <h2 style="float: left">${counter.count}</h2>
                                        <div class="container mt-sm-5 my-1">
                                            <div class="question ml-sm-5 pl-sm-5 pt-2">
                                                <div class="py-2 h5">
                                                    <textarea readonly style="font-size: 12px;font-weight: bold;border:none;resize:none;background-color:#555555;color:white; width: 550px" rows=20 cols=10>${question.content}</textarea>
                                                </div>
                                                <div class="ml-md-3 ml-sm-3 pl-md-5 pt-sm-0 pt-3" id="options">
                                                    <c:set var="list_answer" value="${question.listAnswer}"/>
                                                    <c:forEach items="${list_answer}" var="answer">
                                                        <c:set var="isCorrect" value="${answer.isCorrect eq true ? 'checked' : ''}"/>
                                                        <label class="options">
                                                            <input disabled type="radio" name="answer${answer.questionId}" ${isCorrect}><span class="checkmark"></span> 
                                                            <textarea readonly style="border:none;resize:none;background-color:#555555;color:white; margin-left: 20px; width: 400px" rows=3 cols=10>${answer.content}</textarea>
                                                        </label>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <hr/>
                    </c:forEach>
                </div>

            </div>
        </div>
        <!--      End  Body-->

        <!-- Start       ---- paging and footer ------ -->
        <c:import url="pagingAndFooter.jsp"/>
        <!-- End       ---- paging and footer ------ -->

        <script>
//            var pre = document.getElementById("btnPre");
//            var next = document.getElementById("btnNext");
//
//            var listQuestion = document.getElementsByClassName("MyQuestion");
//            var max = listQuestion.length;
//            for (var i = 1; i < max; i++) {
//                listQuestion[i].style.display = "none";
//            }
//
//            pre.disabled = true;
//            function next(curQuestion) {
//                listQuestion[curQuestion].style.display = "none";
//                listQuestion[curQuestion + 1].style.display = "block";
//                if (max === curQuestion + 1) {
//                    next.disabled = true;
//                }
//                pre.disabled = false;
//            }
        </script>


        <!-- Back to top button -->

        <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>
        <script>
//            window.onscroll = function () {
//                alert('');
//                myFunction();
//            };
//
//            function myFunction() {
//                if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
//                    document.getElementById("back2Top").style.display = "block";
//                } else {
//                    ocument.getElementById("back2Top").style.display = "none";
//                }
//            }

            $(function () {
                $("#back2Top").on('click', function () {
                    $("HTML, BODY").animate({
                        scrollTop: 0
                    }, 1000);
                });
            });
            function toTop(e) {
//                location.href = "#here";

            }
        </script>

        <!-- ALL JS FILES -->
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="assets/js/jquery.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.easing-1.3.min.js"></script>

        <script src="assets/js/jquery.scrollTo-1.4.3.1-min.js"></script>
        <script src="https://code.jquery.com/jquery-2.1.1.js"></script>
        <script src="assets/js/shop.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- ALL PLUGINS -->
        <script src="js/jquery.superslides.min.js"></script>
        <script src="js/bootstrap-select.js"></script>
        <script src="js/inewsticker.js"></script>
        <script src="js/bootsnav.js."></script>
        <script src="js/images-loded.min.js"></script>
        <script src="js/isotope.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/baguetteBox.min.js"></script>
        <script src="js/form-validator.min.js"></script>
        <script src="js/contact-form-script.js"></script>
        <script src="js/custom.js"></script>

    </body>
</html>
