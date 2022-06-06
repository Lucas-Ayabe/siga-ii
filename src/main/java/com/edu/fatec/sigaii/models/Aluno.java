package com.edu.fatec.sigaii.models;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.lang.NonNull;

@Entity
@Table(name = "aluno")
public class Aluno implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ra", length = 13)
    @NonNull
    private Long ra;

    @Column(name = "nome", length = 50)
    @NonNull
    private String nome;

    public Long getRa() {
        return ra;
    }

    public void setRa(Long ra) {
        this.ra = ra;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    @Override
    public String toString() {
        return "{" + "ra='" + ra + '\'' + ", nome='" + nome + '\'' + '}';
    }
}
