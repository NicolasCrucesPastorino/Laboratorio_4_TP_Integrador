package negocio;

import java.util.List;
import entidad.Cliente;

public interface IClienteNegocio {
	public int agregarCliente(Cliente cliente);
	public boolean verificarDNIExistente(String dni);
	public int ultimoID();
	public Cliente buscarClientePorUsuario(int idUsuario);
	public Cliente buscarClientePorId(String id);
	public int actualizarCliente(Cliente cliente);
	public List<Cliente> getAllClientes();
}
