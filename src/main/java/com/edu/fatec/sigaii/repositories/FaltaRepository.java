package com.edu.fatec.sigaii.repositories;

import com.edu.fatec.sigaii.models.Disciplina;
import com.edu.fatec.sigaii.models.Falta;
import java.util.Date;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface FaltaRepository extends JpaRepository<Falta, Integer> {
    List<Falta> findAllByDisciplina(Disciplina disciplina);

    @Transactional
    @Modifying
    @Query(
        value = "INSERT INTO faltas(ra_aluno,codigo_disciplina,data,presenca) VALUES(?1,?2,?3,?4)",
        nativeQuery = true
    )
    void registrarFalta(
        Long ra,
        String disciplina,
        Date date,
        Integer presenca
    );
}
