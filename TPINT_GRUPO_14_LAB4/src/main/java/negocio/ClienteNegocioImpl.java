package negocio;

import java.util.List;
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

	@Override
	public Cliente buscarClientePorUsuario(int idUsuario) {
		return clienteDao.buscarClientePorUsuario(idUsuario);
	}

	@Override
	public Cliente buscarClientePorId(String id) {
		return clienteDao.buscarClientePorId(id);
	}

	@Override
	public int actualizarCliente(Cliente cliente) {
		return clienteDao.actualizarCliente(cliente);
	}

	@Override
	public List<Cliente> getAllClientes() {
		return clienteDao.getAllClientes();
	}

	@Override
	public int contarClientes() {
		return clienteDao.contarClientes();
	}
}
