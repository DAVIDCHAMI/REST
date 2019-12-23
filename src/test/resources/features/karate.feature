Feature: esperar un 200

  Background:
    * url 'https://petstore.swagger.io'
    * def classPath = 'C:/Users/Usuario/Desktop/Repositorio CAM/Karate/src/main/java/jsons/'

  @PostCompleto
  Scenario: Post completo
    * def jsonRequetsPost = read(classPath+'PostKarateJson.json')
    And request jsonRequetsPost
    Given path '/v2/user'
    When method post
    Then status 200

  @GetCompleto
  Scenario: Get con comparacion entre Response Json y Json completo
    Given path '/v2/user/cguerra'
    When method get
    Then status 200
    * def value1 = read(classPath+'GetKarateJson.json')
    And match value1 == response

  @GetVariable
  Scenario: Get con comparacion entre Response Json Valor y Json Valor
    Given path '/v2/user/cguerra'
    When method get
    Then status 200
    * def value2 = 999
    And match value2  == response.id

    @PutCompleto
    Scenario: Put completo
      * def jsonRequetsPut = read(classPath+'PutKarateJson.json')
      And request jsonRequetsPut
      Given path '/v2/user/cguerra'
      When method put
      Then status 200

    @DeleteCompleto
    Scenario: Delete completo
      Given path '/v2/user/cguerra'
      When method delete
      Then status 200


