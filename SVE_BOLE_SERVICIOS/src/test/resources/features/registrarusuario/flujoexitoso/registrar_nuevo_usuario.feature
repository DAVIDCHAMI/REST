Feature:
  Yo como usuario
  Quiero poder registrar un nuevo usuario que ya fue preregistrado

  Background:
    * def correnlationId = '32432432'
    * def urlPath = 'http://192.168.106.48:10280/t1-psf-apistore-mua/rest/v1.0/EFENROLL/security/'


  Scenario: Enrolamiento de nuevo usuario flujo exitoso
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
     correlationId: #(correnlationId)
     }
    """
    When def responseCaptcha = call read('../../bancoservicios/banco_servicios.feature@validacionCaptchaOlvidoUsuario') jsonParametroValidate
