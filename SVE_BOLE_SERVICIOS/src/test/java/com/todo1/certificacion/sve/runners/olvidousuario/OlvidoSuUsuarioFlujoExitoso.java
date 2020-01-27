package com.todo1.certificacion.sve.runners.olvidousuario;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/olvidousuario/flujoexitoso/olvido_su_usuario_flujo_exitoso.feature"}
)
public class OlvidoSuUsuarioFlujoExitoso {
}
