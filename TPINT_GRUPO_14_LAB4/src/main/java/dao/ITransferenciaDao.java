package dao;

import java.math.BigDecimal;

import entidad.Cuenta;

public interface ITransferenciaDao {
	
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo);

}
