package br.com.fiap.tech_challenge.core.applications.ports;

import br.com.fiap.tech_challenge.core.domain.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, String> {
}
