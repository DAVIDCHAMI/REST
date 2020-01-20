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
    And def errorCode = call read('../bancoServicios/banco_servicios.feature@validacionCaptcha') jsonParametroValidate
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
    Then status 200
    