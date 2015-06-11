Feature: Blog Post management
  In order to manage blog posts
  As a client software developer
  I need to be able to retrieve, create, update and delete posts trough the API.

  @createSchema
  Scenario: Create an user
    When I send a "POST" request to "/people" with body:
    """
    {"name": "Kévin"}
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Person",
      "@id": "/people/1",
      "@type": "http://schema.org/Person",
      "name": "Kévin"
    }
    """

  @dropSchema
  Scenario: Retrieve the user list
    When I send a "GET" request to "/people"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Person",
      "@id": "/people",
      "@type": "hydra:PagedCollection",
      "hydra:totalItems": 1,
      "hydra:itemsPerPage": 30,
      "hydra:firstPage": "/people",
      "hydra:lastPage": "/people",
      "hydra:member": [
          {
              "@id": "/people/1",
              "@type": "http://schema.org/Person",
              "name": "Kévin"
          }
      ]
    }
    """
