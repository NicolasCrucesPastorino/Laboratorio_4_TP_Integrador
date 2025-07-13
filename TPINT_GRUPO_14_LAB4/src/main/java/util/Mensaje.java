package util;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Mensaje {
	// M�todo para establecer un mensaje de error
    public static void error(HttpServletRequest request, String texto) {
        request.setAttribute("mensaje", texto);
        request.setAttribute("tipoMensaje", "error");
    }
}
