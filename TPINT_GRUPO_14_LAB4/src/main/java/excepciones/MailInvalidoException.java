package excepciones;

public class MailInvalidoException extends Exception{
	private static final long serialVersionUID = 1L;

    public MailInvalidoException() {
        super();  
    }

    @Override
    public String getMessage() {
        return "El formato del mail es incorrecto. Aseg�rese de que contenga '@' y un dominio v�lido.";
    }
}
