package com.todo1.certificacion.sve.runners.login.validacion_captcha;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/login/validacion_captcha/login_validacion_captcha.feature"}
)
public class LoginValidacionCatpchaRunner {
}
