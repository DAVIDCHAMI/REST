Feature:
  Yo como usuario
  Quiero poder recordar mi usuario

  Background:
    * def correnlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFRETRUSER/security/'


  Scenario: olvido su usuario flujo alterno
    * def jsonParametroGetParams =
    """
  {
  url: #(urlPath),
  path: 'authentication/getparams',
  correlationId:  #(correnlationId)
  }
  """
    Given def responseGetParams = call read('../../bancoServicios/banco_servicios.feature@getParamsOlvidoUsuario') jsonParametroGetParams
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../../jsons/validacion_captcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(responseGetParams.response.header.sessionId),
     correlationId: '73284923'
     }
    """
    When def errorCode = call read('../../bancoServicios/banco_servicios.feature@validacionCaptchaOlvidoUsuario') jsonParametroValidate
    * def jsonRequetsPost = read('../../../jsons/olvido_su_usuario/validacion_usuario/ValidarUsuarioPost.json')
    Given url (urlPath)
    And path 'username/remember/info'
    And header CORRELATIONID = '73284923'
    And header SESSIONID = responseGetParams.response.header.sessionId
    And header Content-Type = 'application/json'
    And header Accept-Language = 'en-US,en;q=0.8'
    And header Accept-Encoding = 'gzip,deflate'
    And header user-agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36'
    And header Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
    And header PREFS = 'mI8g2F1+WI220egSwdk+GhewBws='
    And header Referer = 'http://muacmr.todo1.com/mua/USER'
    And request jsonRequetsPost
    When method POST
    * def jsonRequetsPost = read('../../../jsons/olvido_su_usuario/validacion_compañia/ValidarCompaniaPost.json')
    Given url (urlPath)
    And path 'company/remember/info'
    And header CORRELATIONID = '73284923'
    And header SESSIONID = responseGetParams.response.header.sessionId
    And header Content-Type = 'application/json'
    And header CHANNEL = '003'
    And request jsonRequetsPost
    When method POST
    Given url 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFRETRUSER/svebc/security/'
    And path 'user/nickname'
    And header CORRELATIONID = '32432432'
    And header SESSIONID = responseGetParams.response.header.sessionId
    And header CHANNEL = '003'
    When method GET
    * def responseNickName = response
    Then match responseNickName.header.errorCode == 'END'
