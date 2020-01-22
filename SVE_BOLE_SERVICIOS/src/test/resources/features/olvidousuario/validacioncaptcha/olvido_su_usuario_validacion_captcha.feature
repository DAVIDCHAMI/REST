Feature:
  Yo como usuario
  Quiero poder recordar mi usuario

  Background:
    * def correnlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFRETRUSER/security/'


  Scenario: Verificar Captcha
    * def jsonParametroGetParams =
    """
  {
  url: #(urlPath),
  path: 'authentication/getparams',
  correlationId:  #(correnlationId)
  }
  """
    Given def responseGetParams = call read('../../bancoservicios/banco_servicios.feature@getParamsOlvidoUsuario') jsonParametroGetParams
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../../jsons/validacioncaptcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(responseGetParams.response.header.sessionId),
     correlationId: '73284923'
     }
    """
    When def errorCode = call read('../../bancoservicios/banco_servicios.feature@validacionCaptchaOlvidoUsuario') jsonParametroValidate
    Then match errorCode.response.header.errorCode == 'MA0015'