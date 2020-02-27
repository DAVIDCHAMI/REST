package com.todo1.certificacion.sve.runners.token;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/token/activar_token.feature"}
)
public class ActivarToken {
}
