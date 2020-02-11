package com.todo1.certificacion.sve.runners.cambioclaveobligatorio;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/cambioclaveobligatorio/flujoalterno/cambio_clave_obligatorio_flujo_alterno.feature"}
)

public class CambioDeClaveObligatorioAlterno {
}
