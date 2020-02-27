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
  Scenario Outline: Consulta tipos de documento por pais para segmento Empresas
    * def path = 'BUSINESS'
    Given url urlPath + path
    When method GET
    * def responseEmpresas = response.header
    Then retry until responseStatus == 200 && responseEmpresas.errorCode == '0000' && responseEmpresas.errorMsg == 'NO ERROR'
    * def segmentoPaises = $.data[<idIteracion>].name
    And match segmentoPaises contains '<pais>'
    * def documentos = $.data[<idIteracion>].documentTypes[*].code
    And match documentos contains [<idDocumentos>]

    Examples:
      | idIteracion | pais        | idDocumentos               |
      | 0           | PANAMÁ      | "CC", "IEJNRC", "N"        |
      | 1           | PUERTO RICO | "CC", "IEJNRC", "N"        |
      | 2           | COLOMBIA    | "CC", "CE", "P", "N", "CD" |
      | 3           | CAYMAN      | "CC", "IEJNRC", "N"        |