Feature:
  Yo como usuario
  Quiero poder validar el captcha

  @startFlow
  Scenario: StartFlow
    Given url (url)
    And path (path)
    And header CORRELATIONID = (correnlationId)
    When method GET
    Then status 200


  @getParams
  Scenario: GetParams
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correnlationId)
    When method GET
    Then status 200

  @validacionCaptcha
  Scenario: ValidacionCaptcha
    * def jsonRequetsPost = read((jsonPath))
    Given url (url)
    And path (path)
    And header SESSIONID = (sessionIdStartFlow)
    And header CORRELATIONID = (correnlationId)
    And header Content-Type = 'application/json'
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST
    Then status 200