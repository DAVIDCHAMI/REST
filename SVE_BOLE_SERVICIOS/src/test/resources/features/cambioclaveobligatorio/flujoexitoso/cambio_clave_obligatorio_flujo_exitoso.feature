Feature: Como empresa afiliada en la sve deseo poder hacer el cambio de clave obligatorio

  Background:
    * def correlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFLOGIN/security/'

  @CambioClaveObligatorioExitoso
  Scenario Outline: Autenticacion
    * def jsonParametroStartFlow =
    """
    {
    url: #(urlPath),
    path: 'authentication/startFlow',
    correlationId: #(correlationId)
    }
    """
    Given def getSessionIdStartFlow = call read('../../bancoServicios/banco_servicios.feature@startFlow') jsonParametroStartFlow
    * def sessionId = getSessionIdStartFlow.response.header.sessionId
    * def jsonParametroGetParams =
    """
    {
    url: #(urlPath),
    path: 'authentication/getparams',
    sessionIdStartFlow: #(sessionId),
    correlationId: #(correlationId)
    }
    """
    And def datosGetParams = call read('../../bancoServicios/banco_servicios.feature@getParams') jsonParametroGetParams
    * def salt = datosGetParams.response.data.extras[1].value
#    * def jsonParametroValidate =
#    """
#    {
#     jsonPath: '../../../jsons/validacioncaptcha/ValidacionCaptchaPost.json',
#     url: #(urlPath),
#     path: 'user/captcha/validate',
#     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
#     correlationId: #(correlationId)
#     }
#    """
#    And def errorCode = call read('../../bancoServicios/banco_servicios.feature@validacionCaptcha') jsonParametroValidate
    * def jsonParametroAutenUsuario =
    """
    {
     jsonPath: '../../../jsons/validarusuario/ValidarUsuarioPost.json',
     url: #(urlPath),
     path: 'login/business/info',
     sessionIdStartFlow: #(sessionId),
     correlationId: #(correlationId)
     }
    """
    And def responseValidarUsuario = call read('../../bancoServicios/banco_servicios.feature@validacionUsuarioLogin') jsonParametroAutenUsuario
    And match responseValidarUsuario.response.header.errorCode == '<errorUsuario>'
    Given url 'http://192.168.103.61:9280/proxi/CypherCreds.jsp?salt='+salt+'&password=+<contrasena>'
    When method get
    Then status 200
    * def contrasenaEncriptada = Java.type('resources.ParseDatos').devolverContrasena(response)
    * def jsonContrasenaEncriptada =
    """
  {
   "credential": #(contrasenaEncriptada)
  }
    """
    * def jsonAutenticacionPrimeraClave =
    """
  {
     jsonPath: #(jsonContrasenaEncriptada),
     url: #(urlPath),
     path: 'authentication/firstkey',
     sessionIdStartFlow: #(sessionId),
     correlationId: #(correlationId)
  }
    """
    And def responseAutenticacionPrimeraClave = call read('../../bancoServicios/banco_servicios.feature@autenticarPrimeraClave') jsonAutenticacionPrimeraClave
    And match responseAutenticacionPrimeraClave.response.header.errorCode == '<errorContrasena>'
    Given url 'http://192.168.103.61:9280/proxi/CypherCreds.jsp?salt='+salt+'&password=+<nuevaContrasena>'
    When method get
    Then status 200
    * def contrasenaNuevaEncriptada = Java.type('resources.ParseDatos').devolverContrasena(response)
    * def jsonContrasena =
     """
    {
    "currentPassword": #(contrasenaEncriptada),
    "newPassword": #(contrasenaNuevaEncriptada)
    }
    """
    * def jsonCambioObligatorioContrasena =
     """
    {
     jsonPath: #(jsonContrasena),
     url: #(urlPath),
     path: 'user/password/change',
     sessionId: #(sessionId),
     correlationId: #(correlationId)
    }
    """
    And def responseCambioClave = call read('../../bancoServicios/banco_servicios.feature@cambioObligatorioClave') jsonCambioObligatorioContrasena
    And match responseCambioClave.response.header.errorCode == '<errorCambioClave>'
    * def jsonInitialize =
     """
    {
     url: #(urlPath),
     path: 'authentication/initialize',
     sessionId: #(sessionId),
     correlationId: #(correlationId)
    }
    """
    And def responseInitialize = call read('../../bancoServicios/banco_servicios.feature@initialize') jsonInitialize
    And match responseInitialize.response.header.errorCode == '<errorInitialize>'
    Examples:
      | contrasena | errorUsuario | errorContrasena | nuevaContrasena | errorCambioClave | errorInitialize |
      | Todo1234   | MA0013       | MA0100          | Todo1235        | MA0204           |   END           |
