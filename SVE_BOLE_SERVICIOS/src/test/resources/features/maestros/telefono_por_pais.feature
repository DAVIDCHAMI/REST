Feature:
  Yo como usuario
  Necesito poder validar el maestro de telefonos por pais

  Background:
    * def sessionId = 'IOLv81jbJYR2hirHqF3f7hZX'
    * def correlationId = '12345'
    * def urlPath = 'http://192.168.106.49:10680/t1-as-trx-web/rest/6.2/master/location/country'

  @telefonoPorPais
  Scenario: Consultar telefonos por pais
    Given url urlPath
    And header sessionId = sessionId
    And header correlationId = correlationId
    When method GET
    Then status 200
    * def paises = response.data
    And match response.header.errorCode == '0000'
    And match response.header.errorMsg == 'NO ERROR'
    * def cantidadPaises = paises.length
    And match cantidadPaises == 231