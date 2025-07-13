package negocio;

import dao.IClienteDao;
import daoImpl.ClienteDaoImpl;
import entidad.Cliente;

public class ClienteNegocioImpl implements IClienteNegocio{
	
	private IClienteDao clienteDao = new ClienteDaoImpl();

	@Override
	public int agregarCliente(Cliente cliente) {
		return clienteDao.agregarCliente(cliente);
	}
	
	public boolean verificarDNIExistente(String dni) {
		return clienteDao.verificarDNIExistente(dni);
	}
	
	@Override
	public int ultimoID() {
		return clienteDao.ultimoID();
	}

}
