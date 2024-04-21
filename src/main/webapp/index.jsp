<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/styles.css">

<title>Lab03 | Formulario de Registro</title>
</head>
<body>
	<!-- Contenedor de elementos -->
	<div class="container d-flex align-items-center justify-content-center"
		style="height: 100vh;">

		<!-- 		Elementos ordenados en filas -->
		<div class="row">

			<!-- 		Determina el ancho de los elementos -->
			<div class="col-md-12 mx-auto card-extended">

				<!-- 			Agregamos el logotipo -->
				<div class="logo text-center">
					<img alt="" src="images/logo-cibertec.svg">
				</div>

				<!-- 				Agregamos el card -->
				<div class="card mt-3 card-extended">

					<!-- 				Agregamos el título al card -->
					<div class="card-header">
						<h2>Formulario de Registro</h2>
					</div>

					<!-- 					Agregamos contenido al card -->
					<div class="card-body">

						<!-- Agregamos el form al card dentro del body -->
						<!-- En post se hace referencia al servlet mapeado en web.xml -->
						<!-- El parámetro name es el que reconoce los servlets, en todo caso que el id sea igual al name -->
						<form action="register" method="post"
							onsubmit="return validateForm()">
							<div class="mb-3">
								<div class="row">
									<div class="col">
										<label for="firstName" class="form-label">Nombres*</label> <input
											type="text" class="form-control" name="firstName" id="firstName">
									</div>
									<div class="col">
										<label for="lastName" class="form-label">Apellidos*</label> <input
											type="text" class="form-control" name="lastName" id="lastName">
									</div>
								</div>
							</div>

							<div class="mb-3">
								<div class="row">
									<div class="col">
										<label for="documentDNI" class="form-label">Documento
											DNI*</label> <input type="text" name="documentDNI" class="form-control" id="documentDNI">
									</div>
									<div class="col">
										<label for="celphone" class="form-label">Celular*</label> <input
											type="text" class="form-control" name="celphone" id="celphone">
									</div>
								</div>
							</div>

							<div class="mb-3">

								<label for="email" class="form-label">Email address*</label> <input
									type="email" class="form-control" name="email" id="email">
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">Password*</label> <input
									type="password" class="form-control" name="password" id="password">
							</div>

							<button type="submit" class="btn btn-primary btn-custom w-100">Enviar*</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

	<script>
		function validateForm() {
			var firstName = document.getElementById("firstName").value;
			var lastName = document.getElementById("lastName").value;
			var documentDNI = document.getElementById("documentDNI").value;
			var celphone = document.getElementById("celphone").value;
			var email = document.getElementById("email").value;
			var password = document.getElementById("password").value;

			// Check if required fields are empty
			if (firstName.trim() === '' || lastName.trim() === ''
					|| documentDNI.trim() === '' || celphone === ''
					|| email.trim() === '' || password.trim() === '') {
				alert("Todos los campos son requeridos");
				return false;
			}

			// Validar nombres y apellidos
			var nameRegex = /^[A-Za-z]+(?: [A-Za-z]+)*$/;

			if (!nameRegex.test(firstName.trim())) {
				alert("Los nombres sólo pueden contener letras");
				return false;
			}

			if (!nameRegex.test(lastName.trim())) {
				alert("Los apellidos sólo pueden contener letras");
				return false;
			}

			// Validamos los números de DNI así como los 8 digitos que contiene
			var dniRegex = /^\d{8}$/;

			if (!dniRegex.test(documentDNI.trim())) {
				alert("Debe ingresar los 8 números de su DNI");
				return false;
			}

			// Validar que sean 9 digitos y que el primero sea 9
			var celphoneRegex = /^9\d{8}$/;

			if (!celphoneRegex.test(celphone.trim())) {
				alert("Debe ingresar nueve dígitos, empieza con 9");
				return false;
			}

			// Validate password format
			if (!isValidPassword(password)) {
				alert("Sólo permite 8 números");
				return false;
			}

			// Si todas las validaciones son exitosas, mostrar un mensaje de felicitaciones
			alert("¡Felicidades! Ha sido registrado");

			// Redirigir a una nueva página JSP
			window.location.href = "congratulations.jsp";

			return true; // El formulario es válido
		}

		function isValidPassword(password) {
			// Password must be at least 8 characters long and contain at least one letter, one number, and one special character
			var regex = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/
			return regex.test(password);
		}
	</script>

</body>
</html>