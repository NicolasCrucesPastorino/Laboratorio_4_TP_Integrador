package negocio;

import java.math.BigDecimal;

import entidad.Cuenta;

public interface ITransferenciaNegocio {
	
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo);

}
