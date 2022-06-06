package com.edu.fatec.sigaii.services;

import com.edu.fatec.sigaii.controllers.models.CreateFaltaRequest;
import com.edu.fatec.sigaii.repositories.FaltaRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class FaltaService {

    private FaltaRepository faltaRepository;

    public FaltaService(FaltaRepository faltaRepository) {
        this.faltaRepository = faltaRepository;
    }

    public void registrarChamada(List<CreateFaltaRequest> chamada) {
        chamada.forEach(
            registro ->
                faltaRepository.registrarFalta(
                    registro.getRa(),
                    registro.getCodigoDisciplina(),
                    registro.getData(),
                    registro.getFaltas()
                )
        );
    }
}
