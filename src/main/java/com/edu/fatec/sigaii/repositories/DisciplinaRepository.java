package com.edu.fatec.sigaii.repositories;

import com.edu.fatec.sigaii.models.Disciplina;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DisciplinaRepository
    extends JpaRepository<Disciplina, String> {
    Optional<Disciplina> findByCodigo(String codigo);
}
