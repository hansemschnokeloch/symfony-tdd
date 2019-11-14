<?php declare(strict_types=1);

namespace App\Tests\Unit\Service;

use App\Entity\News;
use App\Repository\NewsRepositoryInterface;
use App\Service\NewsService;
use App\Tests\TestCase;

class NewsServiceTest extends TestCase
{
    private $newsRepository;
    private $newsService;

    protected function setUp(): void
    {
        $this->newsRepository = $this->prophesize(NewsRepositoryInterface::class);
        $this->newsService = new NewsService($this->newsRepository->reveal());
    }

    public function testCollection()
    {
        // Arrange
        $expectedCollection = [];
        $this->newsRepository->findAll()->willReturn($expectedCollection);

        // Act
        $collection = $this->newsService->collection();
        
        // Assert
        $this->newsRepository->findAll()->shouldHaveBeenCalledTimes(1);
        $this->assertSame($expectedCollection, $collection);
    }

    public function testItem()
    {
        // Arrange
        $expectedItem = $this->prophesize(News::class)->reveal();
        $this->newsRepository->findOneBy(['slug' => '__SLUG__'])->willReturn($expectedItem);

        // Act
        $item = $this->newsService->item('__SLUG__');

        // Assert
        $this->newsRepository->findOneBy(['slug' => '__SLUG__'])->shouldHaveBeenCalledTimes(1);
        $this->assertSame($expectedItem, $item);
    }
}