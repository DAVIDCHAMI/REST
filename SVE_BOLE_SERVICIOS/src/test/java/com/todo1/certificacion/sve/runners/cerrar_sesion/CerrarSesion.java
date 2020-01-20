package com.todo1.certificacion.sve.runners.cerrar_sesion;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/cerrar_sesion/cerrar_sesion.feature"} )

public class CerrarSesion {
}