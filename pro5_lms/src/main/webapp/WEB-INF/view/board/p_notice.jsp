<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.notice_boardDTO"%>

<%
int n_num = (Integer) request.getAttribute("n_num");
int pageNum = (Integer) request.getAttribute("pageNum");
notice_boardDTO nbDTO = (notice_boardDTO) request.getAttribute("nbDTO");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 상세보기 - 교수</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Noto+Sans:wght@200;400;600;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/10dae3550b.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../resource/CSS/p_notice.css">
</head>
<script language = "JavaScript">
    function func()
        {
        if (confirm("정말로 삭제하시겠습니까?"))
            {
            document.delete_form.submit()
            }
            
        else
            {
            return false
            }
        }
</script>

<body>
<!--nav 시작-->
    <nav id = "navbar">
        <div class = "nav_container">
            <div class = "nav_logo_container">
                <a href = "http://localhost:8080/pro5_lms/professor/p_main.per"><img src="../resource/images/logo.png" alt="ITUNIVERSITY"></a>
            </div>
            <div class = "nav_user_container">
                <a>${remember.getName()}</a>
            </div>
            <div class = "nav_ul_container information">
                <ul>
                    <input type="checkbox" name="box" id="box1">
                    <div>
                        <i class="fa-brands fa-blogger"></i>
                        <label for="box1">교원 정보</label>
                    </div>
                    
                    <li><a href="http://localhost:8080/pro5_lms/professor/p_info.per">기본 정보 조회</a></li>
                </ul>
            </div>

            <hr>

            <div class = "nav_ul_container enrolment">
                <ul>
                    <input type="checkbox" name="box" id="box2">
                    <div>
                        <i class="fa-brands fa-blogger"></i>
                        <label for="box2">수강 신청 현황</label>
                    </div>
                    
                    <li><a href="http://localhost:8080/pro5_lms/professor/p_lecture.per">수강 신청 현황</a></li>
                </ul>
            </div>

            <hr>

            <div class = "nav_ul_container test">
                <ul>
                    <input type="checkbox" name="box" id="box3">
                    <div>
                        <i class="fa-brands fa-blogger"></i>
                        <label for="box3">시험 관리</label>
                    </div>
                   
                    <li><a href="http://localhost:8080/pro5_lms/professor/p_exam.per">시험 출제</a></li>
                </ul>
            </div>

            <hr>

            <div class = "nav_ul_container gradecheck">
                <ul>
                    <input type="checkbox" name="box" id="box4">
                    <div>
                        <i class="fa-brands fa-blogger"></i>
                        <label for="box4">성적 관리</label>
                    </div>
                    
                    <li><a href="http://localhost:8080/pro5_lms/professor/p_score.per">성적 산출</a></li>
                </ul>
            </div>
        </div>
    </nav>
<!--nav 끝-->
<!--틀 시작-->
   <section id="main">
       <!--배너 시작-->
        <div class ="banner">
            <input type="button" value="로그아웃" onClick="location.href='http://localhost:8080/pro5_lms/member/logout.do'">
        </div>
        <!--배너 끝-->
<!--기본 틀 안에 내용 작성-->
        <div class ="container">
            <!--프레임 시작 // class명(frame)은 페이지에 맞게 수정-->
            <div class="frame">
                <div class="frame_top">
                    <div class="title">상세보기</div>
                    <!--수정은 기본 display-none 필요하면 사용-->
                    <div class="title_sub">수정</div>
                </div>
                <div class="frame_bottom">
                    <div class = "title">
                        <div class = "title_title">
                            <p><%= nbDTO.getN_subject() %></p>
                        </div>
                        <div class = "title_sub">
                            <div class = "sub sub1">
                                <div class = "right"><p>등록일</p></div>
                                <div class = "left"><p><%= nbDTO.getN_date() %></p></div>
                            </div>
                            <div class = "sub sub2">
                                <div class = "right"><p>부서</p></div>
                                <div class = "left"><p><%= nbDTO.getP_department() %></p></div>
                            </div>
                            <div class = "sub sub3">
                                <div class = "right"><p>연락처</p></div>
                                <div class = "left"><p><%= nbDTO.getP_oNumber() %></p></div>
                            </div>
                        </div>
                    </div>
                    <form action="#" name = "form_update">
	                    <div class = "contents">
	                        <div class = "contents_text">
	                            <p>
									<%= nbDTO.getN_contents() %>
	                            </p>
	                        </div>
	                        <div class = "contents_file">
	                            <div class = "right"><p>첨부파일</p></div>
	                            <%
	                            if (nbDTO.getN_filename() != null)
	                            	{
	                            %>
	                            	<div class = "left"><a class="btn" href="http://localhost:8080/pro5_lms/board/download.notice?n_filename=<%= nbDTO.getN_filename() %>&n_realname=<%= nbDTO.getN_realname() %>"><i class="fa-solid fa-circle-down"></i><%= nbDTO.getN_realname() %></a></div>
	                            <%
	                            	}
	                            %>
	                        </div>
	                    </div>
	                    <div class = "buttons">
	                    	<div class = "a_container">
								<a href="http://localhost:8080/pro5_lms/board/p_noticeboardlist.notice?pageNum=<%= pageNum%>"><p>목록</p></a>
							</div>
	                    	<div class = "form_container">
	                    		<%
	                    		String sessionId = (String) session.getAttribute("p_id");
	                    		String userId = nbDTO.getP_id();
	                        	
	                        	if (sessionId.equals(userId))
	                        		{
	                    		%>
	                    			<a href = "http://localhost:8080/pro5_lms/board/p_editnotice.notice?n_num=<%=n_num%>&pageNum=<%=pageNum%>"><input type="button" value = "수정"></a>
	                    			<a href = "http://localhost:8080/pro5_lms/board/p_deletenotice.notice?n_num=<%=n_num%>&pageNum=<%=pageNum%>"><input type="button" value = "삭제" name = "button" onclick = "func()"></a>
								<%
	                        		}
	                        	%>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!--프레임 끝-->    
		</div>
<!--기본 틀 안에 내용 작성 끝-->
	</section>
<!--틀 끝-->
</body>

</html>