<?php declare(strict_types=1);

namespace App\Repository;

use App\Entity\News;

interface NewsRepositoryInterface extends RepositoryInterface
{
    /**
     * @return array
     */
    public function findAllPublished(): array;

    /**
     * @param string $slug
     * @return News|null
     */
    public function findOnePublishedBySlug(string $slug): ?News;
}
