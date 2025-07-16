<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Banking - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <style>
        body {
            background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            position: relative;
        }

        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 0;
            width: 100%;
            max-width: 380px;
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 25px 20px;
            text-align: center;
            position: relative;
        }

        .login-header h1 {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 5px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .login-header h2 {
            font-size: 1rem;
            font-weight: 300;
            margin-bottom: 0;
            opacity: 0.9;
        }

        .bank-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
        }

        .login-body {
            padding: 30px 25px 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            display: block;
            font-size: 14px;
        }

        .form-control {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 12px;
            font-size: 15px;
            transition: all 0.3s ease;
            width: 100%;
        }

        .form-control:focus {
            border-color: #4682B4;
            box-shadow: 0 0 0 0.2rem rgba(70,130,180,.25);
            outline: none;
        }

        .btn-login {
            background: linear-gradient(135deg, #4682B4 0%, #87CEEB 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #2a5298 0%, #4682B4 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(70,130,180,0.3);
        }

        .toggle-password {
            color: #4682B4;
            text-decoration: none;
            font-size: 13px;
            transition: color 0.3s ease;
        }

        .toggle-password:hover {
            color: #2a5298;
            text-decoration: underline;
        }

        .login-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }

        .subject-reference {
            position: absolute;
            bottom: 15px;
            right: 15px;
            color: rgba(255,255,255,0.7);
            font-size: 11px;
            font-style: italic;
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            z-index: 2;
        }

        .form-control.with-icon {
            padding-left: 40px;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 10px;
                max-width: none;
            }
            
            .login-header h1 {
                font-size: 1.6rem;
            }
            
            .login-body {
                padding: 25px 20px 20px;
            }
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <i class="bi bi-bank bank-icon"></i>
        <h1>Home Banking</h1>
        <h2>GRUPO 14</h2>
    </div>
    
    <div class="login-body">
        <% 
        String error = request.getParameter("error");
        if (error != null) {
        %>
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <% if ("credenciales".equals(error)) { %>
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <strong>Error:</strong> Usuario o contraseña incorrectos.
                <% } else if ("inactivo".equals(error)) { %>
                    <i class="bi bi-person-x-fill me-2"></i>
                    <strong>Cliente inactivo:</strong> Su cuenta se encuentra desactivada. Contacte al administrador.
                <% } else if ("tipoDesconocido".equals(error)) { %>
                    <i class="bi bi-question-circle-fill me-2"></i>
                    <strong>Error:</strong> Tipo de usuario no reconocido.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <form method="post" action="ServletLogin">
            <div class="form-group">
                <label for="usuario" class="form-label">
                    <i class="bi bi-person-fill me-2"></i>Usuario
                </label>
                <div class="input-group">
                    <span class="input-icon">
                        <i class="bi bi-person"></i>
                    </span>
                    <input id="usuario" type="text" name="usuario" class="form-control with-icon" placeholder="Ingrese su usuario" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">
                    <i class="bi bi-lock-fill me-2"></i>Contraseña
                </label>
                <div class="input-group">
                    <span class="input-icon">
                        <i class="bi bi-lock"></i>
                    </span>
                    <input id="password" type="password" name="password" class="form-control with-icon" placeholder="Ingrese su contraseña" required>
                </div>
            </div>

            <div class="login-actions">
                <button type="submit" class="btn-login">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Ingresar
                </button>
            </div>
            
            <div class="text-center mt-3">
                <a href="#" id="mostrar-contra" class="toggle-password" onclick="mostrarContra()">
                    <i class="bi bi-eye me-1"></i>Mostrar contraseña
                </a>
            </div>
        </form>
    </div>
</div>

<div class="subject-reference">
    Laboratorio de Computación 4
</div>

<script>
function mostrarContra() {
    const passwordField = document.getElementById("password");
    const toggleLink = document.getElementById("mostrar-contra");
    const icon = toggleLink.querySelector("i");
    
    if (passwordField.type === "password") {
        passwordField.type = "text";
        toggleLink.innerHTML = '<i class="bi bi-eye-slash me-1"></i>Ocultar contraseña';
    } else {
        passwordField.type = "password";
        toggleLink.innerHTML = '<i class="bi bi-eye me-1"></i>Mostrar contraseña';
    }
}
</script>

</body>
</html>