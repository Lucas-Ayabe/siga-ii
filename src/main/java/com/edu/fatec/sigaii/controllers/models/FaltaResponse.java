package com.edu.fatec.sigaii.controllers.models;

public class FaltaResponse {

    private AlunoResponse aluno;

    public FaltaResponse(AlunoResponse aluno) {
        this.aluno = aluno;
    }

    public AlunoResponse getAluno() {
        return aluno;
    }

    public void setAluno(AlunoResponse aluno) {
        this.aluno = aluno;
    }
}
