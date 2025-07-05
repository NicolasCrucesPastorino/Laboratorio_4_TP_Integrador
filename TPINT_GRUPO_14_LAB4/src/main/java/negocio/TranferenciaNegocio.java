package negocio;

import java.math.BigDecimal;

import dao.ITransferenciaDao;
import daoImpl.TransferenciaDaoImpl;
import entidad.Cuenta;

public class TranferenciaNegocio implements ITransferenciaNegocio{
	
	private ITransferenciaDao transferenciaDao = new TransferenciaDaoImpl();

	@Override
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo) {
		
		return transferenciaDao.RealizarTransferencia(origen, destino, importe, motivo);
	}

}
