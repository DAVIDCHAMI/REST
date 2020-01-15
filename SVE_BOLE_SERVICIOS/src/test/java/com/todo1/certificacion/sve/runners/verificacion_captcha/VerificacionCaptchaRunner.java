package com.todo1.certificacion.sve.runners.verificacion_captcha;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/verificar_captcha/olvidoClave/verificar_captcha.feature"}
)
public class VerificacionCaptchaRunner {
}
