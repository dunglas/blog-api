<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Dunglas\ApiBundle\Annotation\Iri;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * An article, such as a news article or piece of investigative report. Newspapers and magazines have articles of many different types and this is intended to cover them all.
 *
 * See also [blog post](http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html).
 *
 * @see http://schema.org/Article Documentation on Schema.org
 *
 * @ORM\MappedSuperclass
 * @Iri("http://schema.org/Article")
 */
abstract class Article extends CreativeWork
{
    /**
     * @var string The actual body of the article.
     *
     * @ORM\Column(nullable=true)
     * @Assert\Type(type="string")
     * @Iri("https://schema.org/articleBody")
     */
    private $articleBody;
    /**
     * @var string Articles may belong to one or more 'sections' in a magazine or newspaper, such as Sports, Lifestyle, etc.
     *
     * @ORM\Column(nullable=true)
     * @Assert\Type(type="string")
     * @Iri("https://schema.org/articleSection")
     */
    private $articleSection;

    /**
     * Sets articleBody.
     *
     * @param string $articleBody
     *
     * @return $this
     */
    public function setArticleBody($articleBody)
    {
        $this->articleBody = $articleBody;

        return $this;
    }

    /**
     * Gets articleBody.
     *
     * @return string
     */
    public function getArticleBody()
    {
        return $this->articleBody;
    }

    /**
     * Sets articleSection.
     *
     * @param string $articleSection
     *
     * @return $this
     */
    public function setArticleSection($articleSection)
    {
        $this->articleSection = $articleSection;

        return $this;
    }

    /**
     * Gets articleSection.
     *
     * @return string
     */
    public function getArticleSection()
    {
        return $this->articleSection;
    }
}
