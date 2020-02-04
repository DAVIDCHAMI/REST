package com.todo1.certificacion.sve.runners.registrarusuario;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(features = {"src/test/resources/features/registrarusuario/flujoexitoso/registrar_nuevo_usuario.feature"})

public class RegistrarUsuario {
}