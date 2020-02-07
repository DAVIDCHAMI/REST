Feature:
  Yo como usuario
  Quiero poder validar el captcha

  @startFlow
  Scenario: StartFlow
    Given url (url)
    And path (path)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    When method GET
    Then status 200

  @getParams
  Scenario: GetParams
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    When method GET
    Then status 200

  @getParamsOlvidoUsuario
  Scenario: GetParams
    Given url (url)
    And path (path)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    When method GET
    Then status 200

  @validacionCaptchaOlvidoUsuario
  Scenario: ValidacionCaptcha
    * def jsonRequetsPost = read((jsonPath))
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST
    Then status 200

  @validacionCaptcha
  Scenario: ValidacionCaptcha
    * def jsonRequetsPost = read((jsonPath))
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST
    Then status 200

  @antiFraude
  Scenario: Autorizar Antifraude
    * def jsonRequetsPost = read((jsonPath))
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    And header Content-Type = 'application/json'
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST
    Then status 200

  @encryptedNewPassword
  Scenario: Encriptacion de contraseña
    Given url (url)
    And path (path)
    When method GET
    Then status 200

  @cerrarSesion
  Scenario: Cerrar sesion
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    When method DELETE
    Then status 200