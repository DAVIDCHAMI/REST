#language: es
Característica:
  Yo como usuario de la SVE Bancolombia quiero cerrear sesion para finalizar las transacciones

  Antecedentes:
    * url 'https://petstore.swagger.io/'
    * def path = 'src/test/resources/jsons/'

  Escenario: Cierre sesion exitoso
    Dado path 'v2/user/Andres'
    Y request read('file:' + path + 'cerrarsesion/CerrarSesionGet.json')
    Cuando method GET
    Entonces status 200
    Y print response