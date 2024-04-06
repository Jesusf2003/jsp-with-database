<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
	<h1>Employee Register Form</h1>
	<form action="employeedetail.jsp" method="post"
		onsubmit="return validateForm()">
		<table style="with: 50%">
			<tr>
				<td>First Name</td>
				<td><input type="text" name="firstName" id="firstName" /></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" name="lastName" id="lastName" /></td>
			</tr>
			<tr>
				<td>UserName</td>
				<td><input type="text" name="username" id="username" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password" id="password" /></td>
			</tr>
			<tr>
				<td>Address</td>
				<td><input type="text" name="address" id="address" /></td>
			</tr>
			<tr>
				<td>Contact No</td>
				<td><input type="text" name="contact" id="contact" /></td>
			</tr>
		</table>
		<input type="submit" value="Submit" />
	</form>
	<script>
		function validateForm() {
			var firstName = document.getElementById("firstName").value;
			var lastName = document.getElementById("lastName").value;
			var username = document.getElementById("username").value;
			var password = document.getElementById("password").value;
			var address = document.getElementById("address").value;
			var contact = document.getElementById("contact").value;
			console.log(password)

			// Check if required fields are empty
			if (firstName.trim() === '' || lastName.trim() === ''
					|| username.trim() === '' || password === ''
					|| address.trim() === '' || contact.trim() === '') {
				alert("All fields are required");
				return false;
			}

			// Validate password format
			if (!isValidPassword(password)) {
				alert("Password must be at least 8 characters long and contain at least one letter, one number, and one special character");
				return false;
			}

			return true; // Form is valid
		}

		function isValidPassword(password) {
			// Password must be at least 8 characters long and contain at least one letter, one number, and one special character
			var regex = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/
			return regex.test(password);
		}
	</script>
</body>

</html>
