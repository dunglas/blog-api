<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Dunglas\ApiBundle\Annotation\Iri;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * The most generic kind of creative work, including books, movies, photographs, software programs, etc.
 *
 * @see http://schema.org/CreativeWork Documentation on Schema.org
 *
 * @ORM\MappedSuperclass
 * @Iri("http://schema.org/CreativeWork")
 */
abstract class CreativeWork extends Thing
{
    /**
     * @var Person The author of this content. Please note that author is special in that HTML 5 provides a special mechanism for indicating authorship via the rel tag. That is equivalent to this and may be used interchangeably.
     *
     * @ORM\ManyToOne(targetEntity="Person")
     * @Iri("https://schema.org/author")
     */
    private $author;
    /**
     * @var \DateTime Date of first broadcast/publication.
     *
     * @ORM\Column(type="date", nullable=true)
     * @Assert\Date
     * @Iri("https://schema.org/datePublished")
     */
    private $datePublished;
    /**
     * @var string Headline of the article.
     *
     * @ORM\Column(nullable=true)
     * @Assert\Type(type="string")
     * @Iri("https://schema.org/headline")
     */
    private $headline;
    /**
     * @var bool Indicates whether this content is family friendly.
     *
     * @ORM\Column(type="boolean", nullable=true)
     * @Assert\Type(type="boolean")
     * @Iri("https://schema.org/isFamilyFriendly")
     */
    private $isFamilyFriendly;

    /**
     * Sets author.
     *
     * @param Person $author
     *
     * @return $this
     */
    public function setAuthor(Person $author = null)
    {
        $this->author = $author;

        return $this;
    }

    /**
     * Gets author.
     *
     * @return Person
     */
    public function getAuthor()
    {
        return $this->author;
    }

    /**
     * Sets datePublished.
     *
     * @param \DateTime $datePublished
     *
     * @return $this
     */
    public function setDatePublished(\DateTime $datePublished = null)
    {
        $this->datePublished = $datePublished;

        return $this;
    }

    /**
     * Gets datePublished.
     *
     * @return \DateTime
     */
    public function getDatePublished()
    {
        return $this->datePublished;
    }

    /**
     * Sets headline.
     *
     * @param string $headline
     *
     * @return $this
     */
    public function setHeadline($headline)
    {
        $this->headline = $headline;

        return $this;
    }

    /**
     * Gets headline.
     *
     * @return string
     */
    public function getHeadline()
    {
        return $this->headline;
    }

    /**
     * Sets isFamilyFriendly.
     *
     * @param bool $isFamilyFriendly
     *
     * @return $this
     */
    public function setIsFamilyFriendly($isFamilyFriendly)
    {
        $this->isFamilyFriendly = $isFamilyFriendly;

        return $this;
    }

    /**
     * Gets isFamilyFriendly.
     *
     * @return bool
     */
    public function getIsFamilyFriendly()
    {
        return $this->isFamilyFriendly;
    }
}
