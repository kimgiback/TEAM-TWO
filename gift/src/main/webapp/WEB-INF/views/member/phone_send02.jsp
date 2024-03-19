<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://www.gstatic.com/firebasejs/10.4.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.4.0/firebase-firestore-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.4.0/firebase-auth-compat.js"></script>
<script>


   const firebaseApp = firebase.initializeApp({ /* Firebase config */ });
   const db = firebaseApp.firestore();
   const auth = firebaseApp.auth();

   import firebase from "firebase/compat/app";
   import "firebase/compat/auth";

	const phoneNumber = getPhoneNumberFromUserInput();
	const appVerifier = window.recaptchaVerifier;

	const auth = getAuth();
	
	window.recaptchaVerifier = new RecaptchaVerifier(auth, 'sign-in-button', {
		  'size': 'invisible',
		  'callback': (response) => {
		    // reCAPTCHA solved, allow signInWithPhoneNumber.
		    onSignInSubmit();
		  }
	});
	
	signInWithPhoneNumber(auth, phoneNumber, appVerifier).then((confirmationResult) => {
	      // SMS sent. Prompt user to type the code from the message, then sign the
	      // user in with confirmationResult.confirm(code).
	      window.confirmationResult = confirmationResult;
	      // ...
	    }).catch((error) => {
	      // Error; SMS not sent
	      // ...
	    });



</script>


</head>
<body>
테스트
<form action="">
	
	<input type="text" name="phoneNumber">
	<input type="button" onclick="getPhoneNumberFromUserInput(this.form)">

</form>
</body>
</html>