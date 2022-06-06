package com.edu.fatec.sigaii.controllers.models;

import java.util.Date;

public class CreateFaltaRequest {

    private Long ra;
    private String codigoDisciplina;
    private Date data;
    private Integer faltas;

    public Long getRa() {
        return ra;
    }

    public void setRa(Long ra) {
        this.ra = ra;
    }

    public String getCodigoDisciplina() {
        return codigoDisciplina;
    }

    public void setCodigoDisciplina(String codigoDisciplina) {
        this.codigoDisciplina = codigoDisciplina;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public Integer getFaltas() {
        return faltas;
    }

    public void setFaltas(Integer faltas) {
        this.faltas = faltas;
    }

    @Override
    public String toString() {
        return (
            "CreateFaltaRequest [codigoDisciplina=" +
            codigoDisciplina +
            ", data=" +
            data +
            ", faltas=" +
            faltas +
            ", ra=" +
            ra +
            "]"
        );
    }
}
