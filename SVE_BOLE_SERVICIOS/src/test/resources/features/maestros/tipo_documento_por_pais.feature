Feature:
  Yo como usuario
  Quiero poder validar el maestro de tipos de documento por pais

  Background:
    * def correnlationId = '12345'
    * def sessionId = 'IOLv81jbJYR2hirHqF3f7hZX'
    * def urlPath = 'http://192.168.106.49:10680/t1-as-trx-web/rest/6.2/master/location/countrydocument/'

  @segmentoPersonas
  Scenario: Consulta tipos de documento por pais segmento Personas
    * def path = 'PERSONAL'
    Given url urlPath + path
    And header sessionId = sessionId
    And header correlationId = correnlationId
    When method GET
    * def responsePersonas = response.header
    Then status 200
    And match responsePersonas.errorCode == '0000'
    * def datosSegPersonasServicios = response.data
    * def datosSegPersonasEsperado = read('../../jsons/validarmaestros/maestroSegmentoPersonas.json')
    And match response.data == datosSegPersonasEsperado

  @segmentoEmpresas
  Scenario: Consulta tipos de documento por pais para segmento Empresas
    * def path = 'BUSINESS'
    Given url urlPath + path
    When method GET
    * def responseEmpresas = response.header
    Then retry until responseStatus == 200 && responseEmpresas.errorCode == '0000' && responseEmpresas.errorMsg == 'NO ERROR'
    * def segmentoPaises = $.data[*].id
    And match segmentoPaises contains ["PA", "PR", "KY", "CO"]
    * def documentosPanama = $.data[0].documentTypes[*].code
    And match documentosPanama contains ["CC", "IEJNRC", "N"]
    * def documentosPuertoRico = $.data[1].documentTypes[*].code
    And match documentosPuertoRico contains ["CC", "IEJNRC", "N"]
    * def documentosColombia = $.data[2].documentTypes[*].code
    And match documentosColombia contains ["CC", "CE", "P", "N", "CD"]
    * def documentosCayman = $.data[3].documentTypes[*].code
    And match documentosCayman contains ["CC", "IEJNRC", "N"]
