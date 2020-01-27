Feature:
  Yo como usuario
  Quiero poder validar el captcha


  Background:
    * def correnlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFRESETPWD/security/'


  Scenario: Verificar Captcha
    * def jsonParametroStartFlow =
    """
    {
    url: #(urlPath),
    path: 'authentication/startFlow',
    correlationId: #(correnlationId)
    }
    """
    Given def getSessionIdStartFlow = call read('../../bancoservicios/banco_servicios.feature@startFlow') jsonParametroStartFlow
    * def jsonParametroGetParams =
    """
  {
  url: #(urlPath),
  path: 'authentication/getparams',
  sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
  correlationId: #(correnlationId)
  }
  """
    And def responseGetParams = call read('../../bancoservicios/banco_servicios.feature@getParams') jsonParametroGetParams
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../../jsons/validacioncaptcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: '73284923'
     }
    """
    When def errorCode = call read('../../bancoservicios/banco_servicios.feature@validacionCaptcha') jsonParametroValidate
    Then match errorCode.response.header.errorCode == 'MA0021'