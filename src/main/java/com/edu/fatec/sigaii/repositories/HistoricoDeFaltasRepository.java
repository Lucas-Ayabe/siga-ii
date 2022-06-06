package com.edu.fatec.sigaii.repositories;

import com.edu.fatec.sigaii.models.HistoricoDeFaltas;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface HistoricoDeFaltasRepository
    extends JpaRepository<HistoricoDeFaltas, Long> {
    @Query(
        value = "SELECT * FROM dbo.calcular_quadro_de_faltas_da_disciplina(?1)",
        nativeQuery = true
    )
    List<HistoricoDeFaltas> findByDisciplinaCodigo(String codigoDaDisciplina);
}
