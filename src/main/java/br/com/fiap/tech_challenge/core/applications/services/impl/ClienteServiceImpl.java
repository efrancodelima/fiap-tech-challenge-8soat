package br.com.fiap.tech_challenge.core.applications.services.impl;

import br.com.fiap.tech_challenge.core.applications.services.ClienteService;
import br.com.fiap.tech_challenge.core.domain.Cliente;
import org.springframework.stereotype.Service;

@Service
public class ClienteServiceImpl implements ClienteService {

    @Override
    public Cliente buscaPorCPF(String cpf) {
        //TODO: Implementar
        return new Cliente();
    }

}
