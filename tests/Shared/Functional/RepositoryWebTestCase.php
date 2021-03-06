<?php declare(strict_types=1);

namespace App\Tests\Shared\Functional;

use App\Tests\Shared\Fixtures\FixturesTrait;
use Hautelook\AliceBundle\PhpUnit\RefreshDatabaseTrait;

abstract class RepositoryWebTestCase extends WebTestCase
{
    use RefreshDatabaseTrait;
    use FixturesTrait;

    protected $repository;
    protected $entityManager;

    abstract protected function getRepositoryClass();

    protected function setUp(): void
    {
        $kernel = self::bootKernel();
        $managerRegistry = $kernel->getContainer()->get('doctrine');
        $this->entityManager = $managerRegistry->getManager();

        $repositoryClass = $this->getRepositoryClass();
        $this->repository = new $repositoryClass($managerRegistry);
    }

    public function tearDown(): void
    {
        parent::tearDown();

        $this->entityManager->close();
        $this->entityManager = null;
    }
}