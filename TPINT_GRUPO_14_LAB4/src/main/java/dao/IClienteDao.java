package dao;

import java.util.List;

import entidad.Cliente;

public interface IClienteDao {
	
	public int agregarCliente(Cliente cliente);
	public boolean verificarDNIExistente(String dni);
	public List<Cliente>getAllClientes();
	public Cliente buscarClientePorId(String id);
	public Cliente buscarClientePorUsuario(int idUsuario);
	public int actualizarCliente(Cliente cliente);
	public int ultimoID();

}
