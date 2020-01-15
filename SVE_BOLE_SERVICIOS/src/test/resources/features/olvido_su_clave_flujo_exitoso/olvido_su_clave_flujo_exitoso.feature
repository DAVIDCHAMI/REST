Feature:
  Yo como usuario
  Quiero poder validar el captcha


  Background:
    * def correnlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFRESETPWD/security/'

  Scenario: Olvido su clave - flujo exitoso
    * def jsonParamtroStartFlow =
    """
    {
    url: #(urlPath),
    path: 'authentication/startFlow',
    correnlationId: #(correnlationId)
    }
    """
    Given def getSessionIdStartFlow = call read('../bancoServicios/banco_servicios.feature@startFlow') jsonParamtroStartFlow
    * def jsonParamtroGetParams =
    """
  {
  url: #(urlPath),
  path: 'authentication/getparams',
  sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
  correnlationId: #(correnlationId)
  }
  """
    And call read('../bancoServicios/banco_servicios.feature@getParams') jsonParamtroGetParams
    * def jsonParamtroValidate =
    """
    {
     jsonPath: '../../jsons/validacion_captcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correnlationId: '73284923'
     }
    """
    When def errorCode = call read('../bancoServicios/banco_servicios.feature@validacionCaptcha') jsonParamtroValidate
    Then match errorCode.response.header.errorCode == 'MA0021'
    * def jsonRequetsPost = read('../../jsons/olvido_clave/OlvidoClavePost.json')
    Given url (urlPath)
    And path 'password/regenerate/info'
    And header CORRELATIONID = '73284923'
    And header SESSIONID = getSessionIdStartFlow.response.header.sessionId
    And header Content-Type = 'application/json'
    And header Accept-Language = 'en-US,en;q=0.8'
    And header Accept-Encoding = 'en-US,en;q=0.8'
    And header user-agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36'
    And header Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
    And header PREFS = 'mI8g2F1+WI220egSwdk+GhewBws='
    And header Referer = 'http://muacmr.todo1.com/mua/USER'
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST
    Then status 200