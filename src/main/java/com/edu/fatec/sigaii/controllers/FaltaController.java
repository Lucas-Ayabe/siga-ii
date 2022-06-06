package com.edu.fatec.sigaii.controllers;

import com.edu.fatec.sigaii.controllers.models.CreateFaltaRequest;
import com.edu.fatec.sigaii.services.FaltaService;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
@RequestMapping("/faltas")
public class FaltaController {

    private FaltaService faltaService;

    public FaltaController(FaltaService faltaService) {
        this.faltaService = faltaService;
    }

    @PostMapping("")
    public ResponseEntity<List<CreateFaltaRequest>> create(
        @RequestBody List<CreateFaltaRequest> faltas
    ) {
        faltaService.registrarChamada(faltas);
        return ResponseEntity.ok(faltas);
    }
}
