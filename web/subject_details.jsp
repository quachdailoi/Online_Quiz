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
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

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
            html, body {margin: 0; height: 100%; overflow-x: hidden}
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
            .goto-top{
                margin-left:-100%;
                position:fixed;
                bottom:20px;
                right:50px;
            }
        </style>
    </head>
    <body>
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
        <div class="row" style="margin-left: 50px" id="here">
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

                <form action="delete-question" method="post">
                    <input type="hidden" name="p_question_id" value=""/>
                    <input type="hidden" name="cur_pos_question" value=""/>
                </form>

                <!--
                Start of subjects and questions
                -->
                <form action="update" method="post" id="MyForm">
                    <input type="hidden" value="details" name="goto"/>
                    <input type="submit" style="display: none" id="updateBtn"/>
                    <div class="well well-small">
                        <hr class="soften"/>
                        <c:set var="list_subject" value="${requestScope.LIST_QUESTION}"/>
                        <c:forEach items="${list_subject}" var="subject">
                            <input type="hidden" name="p_search_subject" value="${subject.subjectID}"/>
                            <input type="hidden" name="p_subject_id" value="${subject.subjectID}"/>
                            <div class="card">
                                <div class="card-header" style="background-color: #aaad44">
                                    <font style="float: top;color: #fff; font-weight: bold; font-size: 20px; margin-left: 150px">${subject.subjectName}</font><a class="btn draw-border" href="#" onclick="addQuestion()" title="Add more" style="float: right; width: 200px; height: 50px">Add Question<span class="icon-plus"></span></a>
                                    <a class="btn draw-border" href="#" onclick="validation()" title="Update" style="float: left; width: 200px; height: 50px" >Update<span class="icon-plus"></span></a>
                                </div>
                                <div class="card-body" id="subject">
                                    <!--  List of questions -->
                                    <c:set var="list_question" value="${subject.listQuestion}"/>
                                    <c:forEach items="${list_question}" var="question" varStatus="counter">

                                        <div class="MyQuestion" style="margin-top: 0px" id="question_${counter.count}">
                                            <%--PARA: name(p_question_id)/value(questionID)--%>
                                            <input type="hidden" name="p_question_id" value="${question.id}"/>
                                            <button title="delete" style="float: right; margin: 5px 5px 0px 0px" onclick="deleteQuestion('${counter.count - 1}')"><i class="fas fa-times-circle"></i></button>
                                            <h2 style="float: left">${counter.count}</h2>
                                            <div class="container mt-sm-5 my-1">
                                                <div class="slideThree" style="margin-top: -50px">  
                                                    <%--PARA: name(p_question_status_questionID)/value('checked')--%>
                                                    <input type="checkbox" value="checked" name="p_question_status_${question.id}" ${question.status ? 'checked' : ''}/> 
                                                    <label for="slideThree" onclick="changeStatus(this)"></label>
                                                </div>
                                                <div class="question ml-sm-5 pl-sm-5 pt-2" style="margin-top: -20px">
                                                    <div class="py-2 h5">
                                                        <%--PARA: name(p_question_content_questionID)/value(innerHTML)--%>
                                                        <textarea name="p_question_content_${question.id}" style="font-size: 12px;font-weight: bold;border:none;resize:none;background-color:#555555;color:white; width: 550px" rows=20 cols=10 spellcheck="false" required>${question.content}</textarea>
                                                    </div>
                                                    <div class="ml-md-3 ml-sm-3 pl-md-5 pt-sm-0 pt-3" id="options">
                                                        <c:set var="list_answer" value="${question.listAnswer}"/>
                                                        <c:forEach items="${list_answer}" var="answer" varStatus="ansCount">
                                                            <c:set var="isCorrect" value="${answer.isCorrect eq true ? 'checked' : ''}"/>
                                                            <label class="options">
                                                                <%--PARA: name(p_answer_correct_questionID)/value(answerID)--%>
                                                                <input type="radio" value="${answer.id}" name="p_answer_correct_${answer.questionId}" ${isCorrect}><span class="checkmark" required></span> 
                                                                <%--PARA: name(p_answer_id_questionID_answerID)/value(innerHTML)--%>
                                                                <input type="hidden" name="p_answer_id_${question.id}" value="${answer.id}"/>
                                                                <textarea name="p_answer_content_${answer.id}" style="border:none;resize:none;background-color:#555555;color:white; margin-left: 20px; width: 400px" rows=3 cols=10 spellcheck="false" required>${answer.content}</textarea>
                                                            </label>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <hr class="soften"/>
                        </c:forEach>
                    </div>
                </form>    
            </div>
        </div>
        <!--      End  Body-->
        <script>
            function validation() {

                var btn = document.getElementById('updateBtn');
                var conf = confirm("Update right?");
                if (conf) {
                    var listTextArea = document.getElementsByTagName("textarea");
                    for (var i = 0; i < listTextArea.length; i++) {
                        var area = listTextArea[i];
                        var content = area.value;

                        if (content === null || content.trim().length === 0) {
                            area.parentNode.scrollIntoView();
                            alert('There is fields with empty content!!!');
                            return;
                        }
                    }
                    btn.click();
                }
            }
            function changeStatus(ele) {
                var parent = ele.parentNode;
                //label is in front of input

                var checkbox = parent.childNodes[1];
                if (checkbox.nodeName !== 'INPUT') {
                    checkbox = parent.childNodes[0];
                }

                var status = checkbox.checked;
                if (status === true) {
                    checkbox.checked = false;
                } else {
                    checkbox.checked = true;
                }
            }
            function deleteQuestion(deletePos) {
                var deletePosNum = parseInt(deletePos);

                document.getElementById("question_" + (deletePosNum + 1)).remove();

                var listH2 = document.getElementsByTagName("h2");
                for (var i = 1; i <= listH2.length; i++) {
                    listH2[i - 1].innerHTML = i;
                }
            }
            function addQuestion() {
                var numberQuestion = document.getElementsByClassName("MyQuestion").length + 1;

                var curTime = new Date().getTime();

                //PARA: name(p_question_id)/value(questionID)
                var questionId = "q" + curTime;
            <%--PARA: name(p_question_content_questionID)/value(innerHTML)--%>
                var questionContentName = "p_question_content_" + questionId;
            <%--PARA: name(p_answer_correct_questionID)/value(answerID)--%>
                var radioName = "p_answer_correct_" + questionId;


                var ansIdA = "ans" + curTime + "-1";
                var ansIdB = "ans" + curTime + "-2";
                var ansIdC = "ans" + curTime + "-3";
                var ansIdD = "ans" + curTime + "-4";
            <%--PARA: name(p_answer_content_questionID_answerID)/value(innerHTML)--%>
                var ansNameA = "p_answer_content_" + ansIdA;
                var ansNameB = "p_answer_content_" + ansIdB;
                var ansNameC = "p_answer_content_" + ansIdC;
                var ansNameD = "p_answer_content_" + ansIdD;

                var fDiv = document.createElement("div");
                fDiv.className = "MyQuestion";
                fDiv.id = "question_" + numberQuestion;

                var hiddeQuestionID = document.createElement("input");
                hiddeQuestionID.type = "hidden";
                hiddeQuestionID.name = "p_question_id";
                hiddeQuestionID.value = questionId;
                fDiv.appendChild(hiddeQuestionID);

                var buttonDelete = document.createElement("button");
                buttonDelete.title = "delete";
                buttonDelete.setAttribute("style", "float: right; margin: 5px 5px 0px 0px");
                buttonDelete.setAttribute('onclick', 'deleteQuestion(\'' + (numberQuestion - 1) + '\')');
                var iconDelete = document.createElement("i");
                iconDelete.className = "fas fa-times-circle";
                buttonDelete.appendChild(iconDelete);

                fDiv.appendChild(buttonDelete);

                var h2 = document.createElement("h2");
                h2.innerHTML = numberQuestion;
                h2.style.float = "left";
                fDiv.appendChild(h2);


                var sDiv = document.createElement("div");
                sDiv.className = "container mt-sm-5 my-1";

                var divSlide = document.createElement("div");
                divSlide.className = "slideThree";
                divSlide.setAttribute("style", "margin-top: -50px");
                var status = document.createElement("input");
                status.type = "checkbox";
                //PARA: name(p_question_status_questionID)/value('checked')
                status.value = "checked";
                status.name = "p_question_status_" + questionId;
                status.setAttribute("checked", "");
                var slider = document.createElement("label");
                slider.setAttribute("for", "slideThree");
                slider.setAttribute("onclick", "changeStatus(this)");
                divSlide.appendChild(status);
                divSlide.appendChild(slider);


                sDiv.appendChild(divSlide);


                var tDiv = document.createElement("div");
                tDiv.className = "question ml-sm-5 pl-sm-5 pt-2";
                tDiv.setAttribute("style", "margin-top: -20px");

                var questionDiv = document.createElement("div");
                questionDiv.className = "py-2 h5";

                var question = document.createElement("textarea");
            <%--PARA: name(p_question_content_questionID)/value(innerHTML)--%>
                question.name = questionContentName;
                question.required = "true";
                question.setAttribute("style", "font-size: 12px;font-weight: bold;border:none;resize:none;background-color:#555555;color:white; width: 550px");
                question.rows = 20;
                question.cols = 10;
                question.required = true;

                var fourthDiv = document.createElement("div");
                fourthDiv.className = "ml-md-3 ml-sm-3 pl-md-5 pt-sm-0 pt-3";
                var label = document.createElement("label");
                label.className = "options";

                var radio = document.createElement("input");
                radio.type = "radio";
                radio.name = radioName;
                radio.required = true;
                var span = document.createElement("span");
                span.className = "checkmark";
                var inputHiddenAnsId = document.createElement("input");
                inputHiddenAnsId.type = "hidden";
                inputHiddenAnsId.name = "p_answer_id_" + questionId;

                var ansContent = document.createElement("textarea");
                ansContent.setAttribute("style", "border:none;resize:none;background-color:#555555;color:white; margin-left: 20px; width: 400px");
                ansContent.cols = "10";
                ansContent.rows = "3";
                ansContent.required = true;

                var ansAContent = ansContent.cloneNode(true);
            <%--PARA: name(p_answer_content_questionID_answerID)/value(innerHTML)--%>
                ansAContent.name = ansNameA;
                var ansBContent = ansContent.cloneNode(true);
            <%--PARA: name(p_answer_content_questionID_answerID)/value(innerHTML)--%>
                ansBContent.name = ansNameB;
                var ansCContent = ansContent.cloneNode(true);
            <%--PARA: name(p_answer_content_questionID_answerID)/value(innerHTML)--%>
                ansCContent.name = ansNameC;
                var ansDContent = ansContent.cloneNode(true);
            <%--PARA: name(p_answer_content_questionID_answerID)/value(innerHTML)--%>
                ansDContent.name = ansNameD;
                //question A
                var labelA = label.cloneNode(true);
                var radioA = radio.cloneNode(true);
                //PARA: name(p_answer_correct_questionID)/value(answerID)
                radioA.value = ansIdA;
                var spanA = span.cloneNode(true);

                var inputHiddenAnsIdA = inputHiddenAnsId.cloneNode(true);
                inputHiddenAnsIdA.value = ansIdA;

                labelA.appendChild(radioA);
                labelA.appendChild(spanA);
                labelA.appendChild(inputHiddenAnsIdA);
                labelA.appendChild(ansAContent);


                //question B
                var labelB = label.cloneNode(true);
                var radioB = radio.cloneNode(true);
                //PARA: name(p_answer_correct_questionID)/value(answerID)
                radioB.value = ansIdB;
                var spanB = span.cloneNode(true);

                var inputHiddenAnsIdB = inputHiddenAnsId.cloneNode(true);
                inputHiddenAnsIdB.value = ansIdB;

                labelB.appendChild(radioB);
                labelB.appendChild(spanB);
                labelB.appendChild(inputHiddenAnsIdB);
                labelB.appendChild(ansBContent);
                //question C
                var labelC = label.cloneNode(true);
                var radioC = radio.cloneNode(true);
                //PARA: name(p_answer_correct_questionID)/value(answerID)
                radioC.value = ansIdC;
                var spanC = span.cloneNode(true);

                var inputHiddenAnsIdC = inputHiddenAnsId.cloneNode(true);
                inputHiddenAnsIdC.value = ansIdC;

                labelC.appendChild(radioC);
                labelC.appendChild(spanC);
                labelC.appendChild(inputHiddenAnsIdC);
                labelC.appendChild(ansCContent);
                //question D
                var labelD = label.cloneNode(true);
                var radioD = radio.cloneNode(true);
                //PARA: name(p_answer_correct_questionID)/value(answerID)
                radioD.value = ansIdD;
                var spanD = span.cloneNode(true);

                var inputHiddenAnsIdD = inputHiddenAnsId.cloneNode(true);
                inputHiddenAnsIdD.value = ansIdD;

                labelD.appendChild(radioD);
                labelD.appendChild(spanD);
                labelD.appendChild(inputHiddenAnsIdD);
                labelD.appendChild(ansDContent);

                fourthDiv.appendChild(labelA);
                fourthDiv.appendChild(labelB);
                fourthDiv.appendChild(labelC);
                fourthDiv.appendChild(labelD);

                questionDiv.appendChild(question);
                tDiv.appendChild(questionDiv);
                tDiv.appendChild(fourthDiv);
                sDiv.appendChild(tDiv);

                fDiv.appendChild(sDiv);

                var subject = document.getElementById("subject");
                subject.insertBefore(fDiv, subject.childNodes[0]);

                var listH2 = document.getElementsByTagName("h2");
                for (var i = 1; i <= listH2.length; i++) {
                    listH2[i - 1].innerHTML = i;
                }
            }

            $(document).ready(function () {
                $(window).scroll(function () {
                    var top = $(".goto-top");
                    if ($('body').height() <= ($(window).height() + $(window).scrollTop() + 200)) {
                        top.animate({"margin-left": "0px"}, 1500);
                    } else {
                        top.animate({"margin-left": "-100%"}, 1500);
                    }
                });

                $(".goto-top").on('click', function () {
                    $("html, body").animate({scrollTop: 0}, 400);
                });
            });
        </script>
        <!-- End       ---- child for appending ------ -->
        <p class="goto-top"><img src="http://i1155.photobucket.com/albums/p559/scrolltotop/arrow66.png" width="20" height="20"></p>
        <!-- Back to top button -->


        <script>

        </script>

        <!-- ALL JS FILES -->
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="assets/js/jquery.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.easing-1.3.min.js"></script>

        <script src="assets/js/jquery.scrollTo-1.4.3.1-min.js"></script>
        <script src="assets/js/shop.js"></script>

        <!--        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>-->
        <script src="js/jquery-3.2.1.min.js"></script>
       
<!--        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>-->
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
