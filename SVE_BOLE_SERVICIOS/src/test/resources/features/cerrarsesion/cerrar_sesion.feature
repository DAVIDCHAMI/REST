Feature: Como empresa afiliada en la sve deseo poder cerrar la sesion iniciada en la aplicacion

  Background:
    * def correlationId = '32432432'
    * def urlPath = 'http://192.168.106.49:11080/t1-psf-apistore-mua/rest/v1.0/EFLOGIN/security/'

  Scenario: Cerrar Sesion - Flujo exitoso
    * def jsonParametroStartFlow =
    """
    {
    url: #(urlPath),
    path: 'authentication/startFlow',
    correlationId: #(correlationId)
    }
    """
    Given def getSessionIdStartFlow = call read('../bancoServicios/banco_servicios.feature@startFlow') jsonParametroStartFlow
    * def jsonParametroGetParams =
    """
    {
    url: #(urlPath),
    path: 'authentication/getparams',
    sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
    correlationId: #(correlationId)
    }
    """
    And def datosGetParams = call read('../bancoServicios/banco_servicios.feature@getParams') jsonParametroGetParams
    * def collectionDatos = datosGetParams.response.data.extras
    * def salt = Java.type('resources.ParseDatos').devolverSALT(collectionDatos)
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../jsons/validacioncaptcha/ValidacionCaptchaPost.json',
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
     jsonPath: '../../jsons/validarusuario/ValidarUsuarioPost.json',
     url: #(urlPath),
     path: 'login/business/info',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
    Given url (urlPath) + 'login/business/info'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    And request read('../../jsons/validarusuario/ValidarUsuarioPost.json')
    When method post
    Then status 200
    Given url 'http://192.168.103.61:9280/proxi/CypherCreds.jsp?salt='+salt+'&password=Todo1234'
    When method get
    * def contrasenaOk = Java.type('resources.ParseDatos').devolverContrasena(response)
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
    And responseAntiFrause.header.errorCode = 'MA0204'
    Given url (urlPath) + 'authentication/initialize'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    When method get
    Then status 200
    * def responseInitialize = response
    And responseInitialize.header.errorCode = 'END'
    * def jsonCerrarSesion =
    """
    {
     url: #(urlPath),
     path: 'session/close',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
    And def datosCerrarSesion = call read('../bancoServicios/banco_servicios.feature@cerrarSesion') jsonCerrarSesion
    * def responseCerrarSesion = response
    And responseCerrarSesion.header.errorCode = 'END'