Feature: Como empresa afiliada en la sve deseo poder cerrar la sesion iniciada en la aplicacion

  Background:
    * def correlationId = '32432432'
    * def urlPath = 'http://192.168.106.48:10280/t1-psf-apistore-mua/rest/v1.0/EFLOGIN/security/'

  Scenario: Cerrar Sesion - Flujo exitoso
    * def jsonParametroGetParams =
    """
    {
    url: #(urlPath),
    path: 'authentication/getparams',
    sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
    correlationId: #(correlationId)
    }
    """
    And def datosGetParams = call read('../bancoservicios/banco_servicios.feature@getParams') jsonParametroGetParams
    * def array = datosGetParams.response.data.extras
    * print array
    * def salt = Java.type('resources.parseDatos').devolverSALT(array)
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../jsons/validacion_captcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
    And def errorCode = call read('../bancoservicios/banco_servicios.feature@validacionCaptcha') jsonParametroValidate
    * def jsonParametroAutenUsuario =
    """
    {
     jsonPath: '../../jsons/validar_usuario/ValidarUsuarioPost.json',
     url: #(urlPath),
     path: 'login/business/info',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
    Given url (urlPath) + 'login/business/info'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    And request read('../../jsons/validar_usuario/ValidarUsuarioPost.json')
    When method post
    Then status 200
    * print response
    Given url 'http://192.168.103.61:9280/proxi/CypherCreds.jsp?salt='+salt+'&password=Todo1234'
    When method get
    * def contrasenaOk = Java.type('resources.parseDatos').devolverContrasena(response)
    Given url (urlPath) + 'authentication/firstkey'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    * def jsonPass =
    """
    {
    "credential": #(contrasenaOk)
    }
    """
    And request jsonPass
    When method post
    * def responseValidarContrasena = response
    * print responseValidarContrasena.header.errorCode
    Then status 200
    And responseValidarContrasena.header.errorCode = 'MA0007'
    Given url (urlPath) + 'risk/authorize'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    * def jsonAntiFraude =
    """
    {
    }
    """
    And request jsonAntiFraude
    When method post
    Then status 200
    * def responseAntiFrause = response
    * print responseAntiFrause.header.errorCode
    And responseAntiFrause.header.errorCode = 'MA0204'
    Given url (urlPath) + 'authentication/initialize'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    When method get
    Then status 200
    * def responseInitialize = response
    * print responseInitialize.header.errorCode
    And responseInitialize.header.errorCode = 'END'

    * def jsonParametroCerrarSesion =
    """
    {
     url: #(urlPath),
     path: 'session/close',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
    And def getCerrarSesion = call read('../bancoservicios/banco_servicios.feature@cerrarSesion') jsonParametroCerrarSesion
#    Given url (urlPath) + 'session/close'
#    And header correlationId = correlationId
#    And header sessionId = getSessionIdStartFlow.response.header.sessionId
#    When method get
#    Then status 200
    * def responseInitialize = response
    * print responseInitialize.header.errorCode
