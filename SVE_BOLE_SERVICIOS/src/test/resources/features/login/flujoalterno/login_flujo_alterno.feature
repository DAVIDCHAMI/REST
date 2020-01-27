Feature: Como empresa afiliada en la sve deseo poder cerrar la sesion iniciada en la aplicacion

  Background:
    * def correlationId = '32432432'
    * def urlPath = 'http://192.168.106.48:10280/t1-psf-apistore-mua/rest/v1.0/EFLOGIN/security/'

  @UsuarioNoExioste
  Scenario Outline: Autenticacion flujo alterno (<escenario>)
    * def jsonParametroStartFlow =
    """
    {
    url: #(urlPath),
    path: 'authentication/startFlow',
    correlationId: #(correlationId)
    }
    """
    Given def getSessionIdStartFlow = call read('../../bancoServicios/banco_servicios.feature@startFlow') jsonParametroStartFlow
    * def jsonParametroGetParams =
    """
    {
    url: #(urlPath),
    path: 'authentication/getparams',
    sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
    correlationId: #(correlationId)
    }
    """
    And def datosGetParams = call read('../../bancoServicios/banco_servicios.feature@getParams') jsonParametroGetParams
    * def collectionDatos = datosGetParams.response.data.extras
    * def salt = Java.type('resources.ParseDatos').devolverSALT(collectionDatos)
    * def jsonParametroValidate =
    """
    {
     jsonPath: '../../../jsons/validacioncaptcha/ValidacionCaptchaPost.json',
     url: #(urlPath),
     path: 'user/captcha/validate',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
#    And def errorCode = call read('../../bancoServicios/banco_servicios.feature@validacionCaptcha') jsonParametroValidate
    * def jsonParametroAutenUsuario =
    """
    {
     jsonPath: '../../../jsons/validarusuario/ValidarUsuarioPost.json',
     url: #(urlPath),
     path: 'login/business/info',
     sessionIdStartFlow: #(getSessionIdStartFlow.response.header.sessionId),
     correlationId: #(correlationId)
     }
    """
    Given url (urlPath) + 'login/business/info'
    And header correlationId = correlationId
    And header sessionId = getSessionIdStartFlow.response.header.sessionId
    And request read('../../../jsons/validarusuario/<pathJson>.json')
    When method post
    * def responseUsuario = response
    Then status 200
    And match responseUsuario.header.errorCode == '<errorUsuario>'
    Given url 'http://192.168.103.61:9280/proxi/CypherCreds.jsp?salt='+salt+'&password=+<contrasena>'
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
    * print response
    And match responseValidarContrasena.header.errorCode == '<errorContrasena>'

    Examples:
      | escenario                       | contrasena | pathJson                                | errorUsuario | errorContrasena |
      | Usuario no existe               | Todo1234   | ValidarUsuarioNoExistePost              | MA0013       | ERR001          |
      | Usuario bloqueado               | Todo1234   | ValidarUsuarioBloqueadoPost             | ERR002       | ERR001          |
      | Usuario clave inclorrecta       | Todo123456 | ValidarUsuarioPost                      | MA0013       | ERR001          |
      | Usuario 1 intento para bloquear | Todo1234   | ValidarUsuarioUltimoIntentoBloquearPost | MA0013       | ERR1008         |