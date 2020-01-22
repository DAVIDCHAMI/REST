<<<<<<< HEAD:SVE_BOLE_SERVICIOS/src/test/java/com/todo1/certificacion/sve/runners/olvidoclave/OlvidoSuClaveFlujoExitosoRunner.java
package com.todo1.certificacion.sve.runners.olvidoclave;
=======
package com.todo1.certificacion.sve.runners.olvidosuclave.flujoexitoso;
>>>>>>> feature/CerrarSesion:SVE_BOLE_SERVICIOS/src/test/java/com/todo1/certificacion/sve/runners/olvidosuclave/flujoexitoso/OlvidoSuClaveFlujoExitosoRunner.java

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/olvidoclave/flujoexitoso/olvido_su_clave_flujo_exitoso.feature"}
)
public class OlvidoSuClaveFlujoExitosoRunner {
}
