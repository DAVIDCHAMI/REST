Feature: Autenticacion Sucursal Virtual Empresas BOLE
  Yo como usuario Bancolombia quiero autentincarme en la SVE para realizar transacciones

  Background:
    * url 'https://petstore.swagger.io/'
    * def path = 'src/test/resources/jsons/'

  Scenario: Leer archivo json POST
    Given path 'v2/user'
    And request read('file:' + path + 'autenticacion/AutenticacionPost.json')
    When method POST
    Then status 200
    And print response

  Scenario: Login exitoso en SVE
    Given path 'v2/user/Andres'
    When method GET
    Then status 200
    And print response