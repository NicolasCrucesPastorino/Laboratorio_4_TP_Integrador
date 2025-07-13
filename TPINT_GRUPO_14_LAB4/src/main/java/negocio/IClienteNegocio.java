package negocio;

import entidad.Cliente;

public interface IClienteNegocio {
	public int agregarCliente(Cliente cliente);
	public boolean verificarDNIExistente(String dni);
	public int ultimoID();
}
