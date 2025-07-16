package negocio;

import java.math.BigDecimal;

import dao.ITransferenciaDao;
import daoImpl.TransferenciaDaoImpl;
import entidad.Cuenta;
import entidad.Cliente;
import excepciones.TransferenciaException;

public class TranferenciaNegocio implements ITransferenciaNegocio{
	
	private ITransferenciaDao transferenciaDao = new TransferenciaDaoImpl();

	@Override
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo) throws TransferenciaException {

		validarTransferencia(origen, destino, importe);
		
		boolean resultado = transferenciaDao.RealizarTransferencia(origen, destino, importe, motivo);
		
		if (!resultado) {
			throw new TransferenciaException("Error al procesar la transferencia. Intente nuevamente.");
		}
		
		return resultado;
	}

	@Override
	public Cuenta buscarCuentaPorCBU(String cbu) throws TransferenciaException {
		if (cbu == null || cbu.trim().isEmpty()) {
			throw new TransferenciaException("El CBU no puede estar vacío");
		}
		
		if (!transferenciaDao.validarCBU(cbu)) {
			throw new TransferenciaException("CBU inválido o cuenta no encontrada");
		}
		
		Cuenta cuenta = transferenciaDao.buscarCuentaPorCBU(cbu);
		if (cuenta == null) {
			throw new TransferenciaException("No se encontró una cuenta con el CBU proporcionado");
		}
		
		return cuenta;
	}

	@Override
	public Cliente obtenerTitularPorCBU(String cbu) throws TransferenciaException {
		Cliente cliente = transferenciaDao.obtenerTitularPorCBU(cbu);
		if (cliente == null) {
			throw new TransferenciaException("No se encontró el titular de la cuenta");
		}
		return cliente;
	}

	@Override
	public void validarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe) throws TransferenciaException {
		if (origen == null) {
			throw new TransferenciaException("La cuenta de origen no puede ser nula");
		}
		
		if (destino == null) {
			throw new TransferenciaException("La cuenta de destino no puede ser nula");
		}
		
		// Validar que el importe sea válido
		if (importe == null || importe.compareTo(BigDecimal.ZERO) <= 0) {
			throw new TransferenciaException("El importe debe ser mayor a cero");
		}
		
		// Validar que la cuenta de origen tenga saldo suficiente
		if (origen.getSaldo().compareTo(importe) < 0) {
			throw new TransferenciaException("Saldo insuficiente en la cuenta de origen");
		}
		
		// Validar que las cuentas sean diferentes
		if (origen.getCbu().equals(destino.getCbu())) {
			throw new TransferenciaException("No se puede transferir a la misma cuenta");
		}
		
		// Validar que ambas cuentas estén activas
		if (!origen.isActiva()) {
			throw new TransferenciaException("La cuenta de origen no está activa");
		}
		
		if (!destino.isActiva()) {
			throw new TransferenciaException("La cuenta de destino no está activa");
		}
		
		// Validar límite de transferencia
		BigDecimal limiteMaximo = new BigDecimal("500000"); // Aca le puse 500k, pero podemos cambiar
		if (importe.compareTo(limiteMaximo) > 0) {
			throw new TransferenciaException("El importe excede el límite máximo de transferencia ($500,000)");
		}
	}
	
	@Override
	public int transferencias(int año, int mes, String cual) {
		return transferenciaDao.transferencias(año, mes, cual);
	}

	@Override
	public float totalTransferido(int año, int mes, String cual) {
		return transferenciaDao.totalTransferido(año, mes, cual);
	}

	@Override
	public float maximoTransferido(int año, int mes, String cual) {
		return transferenciaDao.maximoTransferido(año, mes, cual);
	}

	@Override
	public float promedioTransferido(int año, int mes, String cual) {
		return transferenciaDao.promedioTransferido(año, mes, cual);
	}

}
