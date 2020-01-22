<<<<<<< HEAD:SVE_BOLE_SERVICIOS/src/test/java/com/todo1/certificacion/sve/runners/login/LoginValidacionCatpchaRunner.java
package com.todo1.certificacion.sve.runners.login;
=======
package com.todo1.certificacion.sve.runners.login.validacioncaptcha;
>>>>>>> feature/CerrarSesion:SVE_BOLE_SERVICIOS/src/test/java/com/todo1/certificacion/sve/runners/login/validacioncaptcha/LoginValidacionCatpchaRunner.java

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/login/validacioncaptcha/login_validacion_captcha.feature"}
)
public class LoginValidacionCatpchaRunner {
}
