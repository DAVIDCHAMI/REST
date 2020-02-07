Feature:
  Yo como usuario
  Quiero poder registrar un nuevo usuario que ya fue preregistrado

  Background:
    * def correlationId = '32432432'
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
    * def sessionId = responseGetParams.response.header.sessionId
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../../jsons/validacioncaptcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(sessionId),
     correlationId: #(correlationId)
     }
    """
    When def responseCaptcha = call read('../../bancoservicios/banco_servicios.feature@validacionCaptchaOlvidoUsuario') jsonParametroValidate
    Given url urlPath + '/enroll/business/user/info'
    And header correlationId = correlationId
    And header sessionId = sessionId
    When def jsonUsuarioNuevo = read('../../../jsons/registarusuario/RegistrarNuevoUsuario.json')
    And request jsonUsuarioNuevo
    And method POST
    Then status 200
    * def responseNuevoUsuario = response
    And match responseNuevoUsuario.header.errorCode == 'MA0200'
    And match responseNuevoUsuario.header.errorMsg contains 'validó exitosamente'
    And match responseNuevoUsuario.data.extras[0].name == 'firstName'
    And match responseNuevoUsuario.data.extras[1].name == 'lastName'
    * def jsonEnviarOTP =
    """
    {
    }
    """
    Given url urlPath + 'otp/generate'
    And header correlationId = correlationId
    And header sessionId = sessionId
    When request jsonEnviarOTP
    And method POST
    Then status 200
    * def responseEnviarOTP = response
    And match responseEnviarOTP.header.errorCode == 'MA0002'
    And match responseEnviarOTP.header.errorMsg contains 'ODA enviado'