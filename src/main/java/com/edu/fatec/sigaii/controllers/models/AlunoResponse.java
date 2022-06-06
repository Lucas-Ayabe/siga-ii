package com.edu.fatec.sigaii.controllers.models;

import com.edu.fatec.sigaii.models.Aluno;

public class AlunoResponse {

    private long ra;
    private String nome;

    public AlunoResponse(long ra, String nome) {
        this.ra = ra;
        this.nome = nome;
    }

    public AlunoResponse(Aluno aluno) {
        this.ra = aluno.getRa();
        this.nome = aluno.getNome();
    }

    public long getRa() {
        return ra;
    }

    public void setRa(long ra) {
        this.ra = ra;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
