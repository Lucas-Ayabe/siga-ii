package com.edu.fatec.sigaii.services;

import com.edu.fatec.sigaii.models.Aluno;
import com.edu.fatec.sigaii.models.Disciplina;
import com.edu.fatec.sigaii.models.HistoricoDeFaltas;
import com.edu.fatec.sigaii.models.Matricula;
import com.edu.fatec.sigaii.repositories.DisciplinaRepository;
import com.edu.fatec.sigaii.repositories.HistoricoDeFaltasRepository;
import com.edu.fatec.sigaii.repositories.MatriculaRepository;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DisciplinaService {

    private DisciplinaRepository disciplinaRepository;
    private MatriculaRepository matriculaRepository;
    private HistoricoDeFaltasRepository historicoDeFaltasRepository;

    @Autowired
    public DisciplinaService(
        DisciplinaRepository disciplinaRepository,
        MatriculaRepository matriculaRepository,
        HistoricoDeFaltasRepository historicoDeFaltasRepository
    ) {
        this.disciplinaRepository = disciplinaRepository;
        this.matriculaRepository = matriculaRepository;
        this.historicoDeFaltasRepository = historicoDeFaltasRepository;
    }

    public List<Disciplina> findAll() {
        return disciplinaRepository.findAll();
    }

    public Optional<Disciplina> findByCodigo(String codigo) {
        return disciplinaRepository.findByCodigo(codigo);
    }

    public List<Aluno> findAlunosFromCodigo(String codigo) {
        return matriculaRepository
            .findByDisciplinaCodigo(codigo)
            .stream()
            .map(Matricula::getAluno)
            .collect(Collectors.toList());
    }

    public List<HistoricoDeFaltas> findHistoricoDeFaltasFromCodigo(
        String codigo
    ) {
        return historicoDeFaltasRepository.findByDisciplinaCodigo(codigo);
    }
}
