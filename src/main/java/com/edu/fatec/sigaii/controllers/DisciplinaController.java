package com.edu.fatec.sigaii.controllers;

import com.edu.fatec.sigaii.controllers.models.AlunoResponse;
import com.edu.fatec.sigaii.models.Disciplina;
import com.edu.fatec.sigaii.models.HistoricoDeFaltas;
import com.edu.fatec.sigaii.services.DisciplinaService;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
@RequestMapping("/disciplinas")
public class DisciplinaController {

    private DisciplinaService disciplinaService;

    @Autowired
    public DisciplinaController(DisciplinaService disciplinaService) {
        this.disciplinaService = disciplinaService;
    }

    @GetMapping("")
    public ResponseEntity<List<Disciplina>> disciplinas() {
        return ResponseEntity.ok(disciplinaService.findAll());
    }

    @GetMapping("/{codigo}")
    public ResponseEntity<Disciplina> disciplina(@PathVariable String codigo) {
        return ResponseEntity.ok(
            disciplinaService.findByCodigo(codigo).orElseThrow()
        );
    }

    @GetMapping("/{codigo}/alunos")
    public ResponseEntity<List<AlunoResponse>> alunos(
        @PathVariable String codigo
    ) {
        return ResponseEntity.ok(
            disciplinaService
                .findAlunosFromCodigo(codigo)
                .stream()
                .map(AlunoResponse::new)
                .collect(Collectors.toList())
        );
    }

    @GetMapping("/{codigo}/faltas")
    public ResponseEntity<List<HistoricoDeFaltas>> faltas(
        @PathVariable String codigo
    ) {
        return ResponseEntity.ok(
            disciplinaService.findHistoricoDeFaltasFromCodigo(codigo)
        );
    }
}
