package com.todo1.certificacion.sve.runners.olvidoclave;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/olvidoclave/flujoexitoso/olvido_su_clave_flujo_exitoso.feature"}
)
public class OlvidoSuClaveFlujoExitoso {
}