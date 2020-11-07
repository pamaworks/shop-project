<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증 코드 전송</title>
</head>
<body>
	
	<h2>이메일 인증 코드 전송</h2>
	<form method="post" action="/email/send.do"><%-- EmailController : @RequestMapping("send") --%>
		발신자 이름:<input name="senderName" type="text" class="form-control"><br>
		발신자 이메일:<input name="senderMail" type="text" class="form-control"><br>
		수신자 이메일:<input name="receiveMail" type="text" class="form-control"><br>
		제목:<input name="subject" type="text" class="form-control"><br>
		내용:<textarea name="message" rows="5" cols="80"></textarea><br><br>
		<%-- 전송 버튼 --%><input type="submit" value="전송" class="btn btn-secondary"/>
	</form>
	
	<%-- EmailService : MimeMessage msg = mailSender.createMimeMessage(); --%>
	<span style="color:blue;">${msg}</span>
</body>
</html>