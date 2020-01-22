package com.todo1.certificacion.sve.runners.login;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/login/validacioncaptcha/login_validacion_captcha.feature"}
)
public class LoginValidacionCatpchaRunner {
}
