package com.todo1.certificacion.sve.runners.maestros;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(
        features = {"src/test/resources/features/maestros/tipo_documento_por_pais.feature"}
)

public class TipoDocumentoPorPais {
}
