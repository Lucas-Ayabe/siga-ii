package com.edu.fatec.sigaii.models;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.lang.NonNull;

@Entity
@Table(name = "disciplina")
public class Disciplina implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "codigo", length = 255)
    @NonNull
    private String codigo;

    @Column(name = "nome", length = 40)
    @NonNull
    private String nome;

    @Column(name = "sigla", length = 2)
    @NonNull
    private String sigla;

    @Column(name = "turno", length = 255)
    @NonNull
    private String turno;

    @Column(name = "num_aulas")
    private Integer numAulas;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getNumAulas() {
        return numAulas;
    }

    public void setNumAulas(Integer numAulas) {
        this.numAulas = numAulas;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public String getTurno() {
        return turno;
    }

    public void setTurno(String turno) {
        this.turno = turno;
    }
}
