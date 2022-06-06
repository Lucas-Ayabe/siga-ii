package com.edu.fatec.sigaii.models;

import javax.persistence.*;
import org.springframework.lang.NonNull;

@Entity
@Table(name = "matricula")
@IdClass(MatriculaPrimaryKey.class)
public class Matricula {

    @Id
    @ManyToOne(targetEntity = Aluno.class)
    @JoinColumn(name = "ra_aluno")
    @NonNull
    private Aluno aluno;

    @Id
    @ManyToOne(targetEntity = Disciplina.class)
    @JoinColumn(name = "codigo_disciplina")
    @NonNull
    private Disciplina disciplina;

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public Disciplina getDisciplina() {
        return disciplina;
    }

    public void setDisciplina(Disciplina disciplina) {
        this.disciplina = disciplina;
    }

    @Override
    public String toString() {
        return "[aluno=" + aluno + ", disciplina=" + disciplina + "]";
    }
}
