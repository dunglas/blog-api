Feature: Blog
  In order to post news
  As a client software developer
  I need to be able to retrieve, create, update and delete authors and posts trough the API.

  # "@createSchema" creates a temporary SQLite database for testing the API
  @createSchema
  Scenario: Create a person
    When I send a "POST" request to "/people" with body:
    """
    {
      "familyName": "Lenancker",
      "givenName": "Olivier",
      "description": "A famous author from the North.",
      "birthDate": "666-06-06"
    }
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
      "birthDate": "0666-06-06T00:00:00+00:00",
      "deathDate": null,
      "description": "A famous author from the North.",
      "familyName": "Lenancker",
      "givenName": "Olivier"
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
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/people/1",
          "@type": "http://schema.org/Person",
          "birthDate": "0666-06-06T00:00:00+00:00",
          "deathDate": null,
          "description": "A famous author from the North.",
          "familyName": "Lenancker",
          "givenName": "Olivier"
        }
      ],
      "hydra:totalItems": 1
    }
    """

  Scenario: Throw errors when a post is invalid
    When I send a "POST" request to "/blog_postings" with body:
    """
    {
      "name": "API Platform is great",
      "headline": "You'll love that framework!",
      "articleBody": "The body of my article.",
      "articleSection": "technology",
      "author": "/people/1",
      "isFamilyFriendly": "maybe",
      "datePublished": "2015-05-11",
      "kevinReview": "nice"
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
      "hydra:description": "isFamilyFriendly: This value should be of type boolean.",
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
      "name": "API Platform is great",
      "headline": "You'll love that framework!",
      "articleBody": "The body of my article.",
      "articleSection": "technology",
      "author": "/people/1",
      "isFamilyFriendly": true,
      "datePublished": "2015-05-11",
      "kevinReview": "nice"
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
      "datePublished": "2015-05-11T00:00:00+00:00",
      "headline": "You'll love that framework!",
      "isFamilyFriendly": true,
      "name": "API Platform is great",
      "kevinReview": "nice"
    }
    """
