package br.com.fiap.tech_challenge.adapter.driver;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/api/v1/cliente")
public class ClienteController {

    @GetMapping("/health")
    public ResponseEntity<String> heathCheck() {
        return ResponseEntity.ok("OK");
    }

}
