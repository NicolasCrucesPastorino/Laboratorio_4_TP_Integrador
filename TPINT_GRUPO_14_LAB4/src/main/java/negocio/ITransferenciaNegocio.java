package negocio;

import java.math.BigDecimal;

import entidad.Cuenta;
import entidad.Cliente;
import excepciones.TransferenciaException;

public interface ITransferenciaNegocio {
	
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo) throws TransferenciaException;
	public Cuenta buscarCuentaPorCBU(String cbu) throws TransferenciaException;
	public Cliente obtenerTitularPorCBU(String cbu) throws TransferenciaException;
	public void validarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe) throws TransferenciaException;

}
