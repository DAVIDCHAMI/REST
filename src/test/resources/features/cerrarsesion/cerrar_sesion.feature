Feature:
  Yo como usuario de la SVE Bancolombia quiero cerrear sesion para finalizar las transacciones

  Background:
    * url 'https://petstore.swagger.io/'
    * def path = 'src/test/resources/jsons/'

  Scenario: Cierre sesion exitoso
    Given path 'v2/user/Andres'
    And request read('file:' + path + 'cerrarsesion/CerrarSesionGet.json')
    When method GET
    Then status 200
    And print response