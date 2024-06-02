<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body{
      display:flex;
      justify-content:center;
      align-items:center;
      height:100vh;
      background-color:#f4f4f4;
      font-family:Arial,sans-serif;
    }
    .container{
       text-align:center;
       background-color:#fff;
       padding:20px;
       border-radius:10px;
       box-shadow:0 0 10px rgba(0,0,0,0.1);
    }
    .logo{
      font-size:100px;
      color:#007bff;
      padding-bottom:30px;
    }
    .firstp{
    margin-bottom:0px;}
    .secondp{
     
      margin-top:2px;
    }
     #formdata {
    padding-top:10px;
    width: 300px; /* Adjust width as needed */
    margin: auto;
    
  }
  /* Style for the label */
  label {
    display: block;
    margin-bottom: 5px;
    font-size: 12px; 
    text-align:left;/* Small font size */
    
  }
  /* Style for the input */
  .in{
  background-color:green;
     text-align: left;
    width:100%; /* Occupy div width, considering margin */
    margin-bottom: 10px;
    padding:5px;
    box-sizing: border-box;
    border: 1px solid #ccc; /* Add a light gray border */
    border-radius: 5px; /* Rounded corners */
    background-color: #f9f9f9; /* Light gray background */
    transition: border-color 0.3s; /* Smooth border color transition */
    font-size: 14px; /* Match label font size */
  }
  /* Style for the button */
  .subbutton{
    text-align:center;
    width: 50%; /* Occupy div width */
    padding: 10px;
    background-color: #007bff; /* Blue color */
    color: white;
    border: none;
    cursor: pointer;
    border-radius:20px;
  }
    
</style>
</head>
<body>

<div class="container" id="container">
   <h1 id="title">Forgot password</h1>
   <div class="logo" id="logo">&#128274;</div>
   <p class="firstp" id="fp">Please Enter your Email Address To</p>
   <p class="secondp" id="sd"> Receive a Verification code</p>
   <form id="formdata">
    <label>Email Address:</label>
    <input name="email" id="email" class="in" placeholder="enter registered email"/><br>
    <input type="button" id="subbutton" class="subbutton" value="send">
   </form>
</div>

<script>
$(document).ready(function() {
    $('#subbutton').click(function() {
    	
        var em=$("#email").val();
        console.log("hi hello")
        console.log(em);
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/sendemail', 
            data:{email:em},
            success: function(response) {
                alert(response);
                enterotpdata(em);
            },
            error: function(xhr) {
                alert(xhr.responseText);
                $("#email").val("");
            }
        });
    });
    function enterotpdata(email){
    	console.log("hi");
    	$("#container").empty();
    
    	var formdata=$("<form>");
    	var label1=$("<label>").text("Enter the otp:");
    	formdata.append(label1);
    	var input1=$("<input>").attr("type","text").attr("id","otp").attr("name","otp").attr('class','in');
    	formdata.append(input1);
    	formdata.append("<br>")
    	var subbutton=$("<input>").attr("type","submit").attr("id","subbutton").attr('class','subbutton');
    	formdata.append(subbutton);
    	
    	var h1tag=$("<h1>").text("Verify your email");
    	$("#container").append(h1tag);
    	var logoDiv = $("<div>").addClass("logo").attr("id", "logo").html("&#128231;");
    	$("#container").append(logoDiv);
    	var p1tag=$("<p>").text("Please enter the six digit code that send to ").attr('class','firstp');
    	var p2tag=$("<p>").text("your "+email+" address").attr('class','secondp');
    	$("#container").append(p1tag);
    	$("#container").append(p2tag);
    	$("#container").append(formdata);
    	formdata.submit(function(event){
    		event.preventDefault();
    		var cotp=parseInt($("#otp").val());
    		$.ajax({
    			type:"POST",
    			url:"${pageContext.request.contextPath}/otpverification",
    			data:{otp:cotp},
    			success:function(response){
    				alert(response);
    				resetpassword();
    			},
    			error:function(responsemsg){
    				alert(responsemsg);
    				$("#otp").val("");
    			}
    		})
    	})
    }
    function resetpassword(){
    	$("#container").empty();
    	var formdata=$("<form>");
    	var label1=$("<label>").text("Reset Password:");
    	formdata.append(label1);
    	var input1=$("<input>").attr('type','password').attr("id","newpwd").attr("name","newpwd").attr("placeholder","Enter new password").attr('class','in');
    	formdata.append(input1);
    	formdata.append("<br>");
    	var label2=$("<label>").text("Confirm Password:");
    	formdata.append(label2);
    	var input2=$("<input>").attr('type','password').attr("id","conpwd").attr("name","conpwd").attr("placeholder","confirm password").attr('class','in');
    	formdata.append(input2);
    	var subbutton=$("<input>").attr("type","submit").attr("id","subbutton").attr('class','subbutton');
    	formdata.append("<br>");
    	
    	var h1tag=$("<h1>").text("Create New Password");
    	$("#container").append(h1tag);
    	var logoDiv = $("<div>").addClass("logo").attr("id", "logo").html("&#128275;");
    	$("#container").append(logoDiv);
    	var p1tag=$("<p>").text("Your New password must be Different").attr('class','firstp');
    	var p2tag=$("<p>").text("from your previously used password").attr('class','secondp');
    	$("#container").append(p1tag);
    	$("#container").append(p2tag);
    	
    	
    	formdata.append(subbutton);
    	$("#container").append(formdata);
    	
    	formdata.submit(function(event){
    	   event.preventDefault();
    	   var newpwd=$("#newpwd").val();
    	   var conpwd=$("#conpwd").val();
    	   if(newpwd==conpwd){
    		   formdata.attr("action","resetpassword");
    		   formdata.attr("method","POST");
    		   formdata.off("submit").submit();
    	   }else{
    		   alert("please check your password once");
    		   $("#newpwd").val("");
    		   $("#conpwd").val("");
    	   }
    	})
    }
});
</script>
</body>
</html>