Feature:
  Yo como usuario
  Quiero poder recuperar mi clave


  Background:
    * def correnlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFRESETPWD/security/'

  Scenario: Olvido su clave - flujo exitoso
    * def jsonParamtroStartFlow =
    """
    {
    url: #(urlPath),
    path: 'authentication/startFlow',
    correlationId: #(correnlationId)
    }
    """
    Given def getSessionIdStartFlow = call read('../../bancoServicios/banco_servicios.feature@startFlow') jsonParamtroStartFlow
    * def jsonParamtroGetParams =
    """
  {
  url: #(urlPath),
  path: 'authentication/getparams',
  sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
  correlationId: #(correnlationId)
  }
  """
    And call read('../../bancoServicios/banco_servicios.feature@getParams') jsonParamtroGetParams
    * def jsonParamtroValidate =
    """
    {
     jsonPath: '../../../jsons/validacion_captcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: '73284923'
     }
    """
    When def errorCode = call read('../../bancoServicios/banco_servicios.feature@validacionCaptcha') jsonParamtroValidate
    Then match errorCode.response.header.errorCode == 'MA0021'

