Feature: Blog
  In order to post news
  As a client software developer
  I need to be able to retrieve, create, update and delete authors and posts trough the API.

  # "@createSchema" creates a temporary SQLite database for testing the API
  @createSchema
  Scenario: Create a person
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

  Scenario: Throw errors when a post is invalid
    When I send a "POST" request to "/blog_postings" with body:
    """
    {
        "name": "Dunglas's API Platform is great",
        "headline": "You'll enjoy that framework!",
        "articleBody": "The body of my article.",
        "articleSection": "technology",
        "author": "/people/1",
        "isFamilyFriendly": "maybe",
        "datePublished": "2015-05-11"
    }
    """
    Then the response status code should be 400
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And the JSON should be equal to:
    """
    {
        "@context": "/contexts/ConstraintViolationList",
        "@type": "ConstraintViolationList",
        "hydra:title": "An error occurred",
        "hydra:description": "isFamilyFriendly: This value should be of type boolean.\n",
        "violations": [
            {
                "propertyPath": "isFamilyFriendly",
                "message": "This value should be of type boolean."
            }
        ]
    }
    """


  # "@dropSchema" is mandatory to cleanup the temporary database on the last scenario
  @dropSchema
  Scenario: Post a new blog post
    When I send a "POST" request to "/blog_postings" with body:
    """
    {
        "name": "Dunglas's API Platform is great",
        "headline": "You'll enjoy that framework!",
        "articleBody": "The body of my article.",
        "articleSection": "technology",
        "author": "/people/1",
        "isFamilyFriendly": true,
        "datePublished": "2015-05-11"
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json"
    And print last JSON response
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/BlogPosting",
      "@id": "/blog_postings/1",
      "@type": "http://schema.org/BlogPosting",
      "articleBody": "The body of my article.",
      "articleSection": "technology",
      "author": "/people/1",
      "datePublished": "2015-05-11T00:00:00+02:00",
      "headline": "You'll enjoy that framework!",
      "isFamilyFriendly": true,
      "name": "Dunglas's API Platform is great"
    }
    """
