Feature: Autenticacion Sucursal Virtual Empresas BOLE
  Yo como usuario Bancolombia quiero autentincarme en la SVE para realizar transacciones

  Scenario: Login exitoso en SVE
    Given url 'https://petstore.swagger.io/v2/user/Laura'
    When method GET
    Then status 200

  Scenario: login
    Given url 'https://petstore.swagger.io/v2/user'
    And request {id: 9, username:'Laura', firstName:'villa', lastName:'Tabares', email:'string', password:'string', phone:'', userStatus:1}
    When method POST
    Then status 200
    * def value1 = 9
    And print response
