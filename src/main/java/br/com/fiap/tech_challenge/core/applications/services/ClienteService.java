package br.com.fiap.tech_challenge.core.applications.services;

import br.com.fiap.tech_challenge.core.domain.Cliente;
import org.springframework.stereotype.Service;

@Service
public interface ClienteService {

    Cliente buscaPorCPF(String cpf);

}
