package com.todo1.certificacion.sve.runners.login.flujoexitoso;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/login/flujoexitoso/login_flujo_exitoso.feature"}
)

public class LoginFlujoExitosoRunner {
}
