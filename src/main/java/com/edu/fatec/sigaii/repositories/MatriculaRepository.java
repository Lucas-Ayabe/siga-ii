package com.edu.fatec.sigaii.repositories;

import com.edu.fatec.sigaii.models.Matricula;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MatriculaRepository extends JpaRepository<Matricula, Integer> {
    public List<Matricula> findByDisciplinaCodigo(String codigo);
}
