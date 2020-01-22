package com.todo1.certificacion.sve.runners.olvidosuusuario.validacioncaptcha;


import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/olvido_su_usuario/validacion_captcha/olvido_su_usuario_validacion_captcha.feature"}
)
public class OlvidoUsuarioValidacionCaptchaRunner {
}
