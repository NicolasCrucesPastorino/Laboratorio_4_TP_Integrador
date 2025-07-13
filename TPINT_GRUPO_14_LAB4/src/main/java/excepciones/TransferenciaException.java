package excepciones;

public class TransferenciaException extends Exception {
	private static final long serialVersionUID = 1L;
	
	public TransferenciaException(String message) {
		super(message);
	}
	
	public TransferenciaException(String message, Throwable cause) {
		super(message, cause);
	}
} 