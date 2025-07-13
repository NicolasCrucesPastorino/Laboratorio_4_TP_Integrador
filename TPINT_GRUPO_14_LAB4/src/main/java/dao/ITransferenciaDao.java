package dao;

import java.math.BigDecimal;

import entidad.Cuenta;
import entidad.Cliente;

public interface ITransferenciaDao {
	
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo);
	public Cuenta buscarCuentaPorCBU(String cbu);
	public Cliente obtenerTitularPorCBU(String cbu);
	public boolean validarCBU(String cbu);

}
