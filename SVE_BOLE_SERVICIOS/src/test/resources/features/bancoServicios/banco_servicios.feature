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


  @getParams
  Scenario: GetParams
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    When method GET

  @getParamsOlvidoUsuario
  Scenario: GetParams
    Given url (url)
    And path (path)
    And header CORRELATIONID = (correlationId)
    And header CHANNEL = '003'
    When method GET

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

  @validacionCaptcha
  Scenario: ValidacionCaptcha
    * def jsonRequetsPost = read((jsonPath))
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    And header Content-Type = 'application/json'
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST

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

  @encryptedNewPassword
  Scenario: Encriptacion de contraseña
    Given url (url)
    And path (path)
    When method GET

  @cerrarSesion
  Scenario: Cerrar sesion
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correlationId)
    When method DELETE