##
## PHPUNIT
## -------
##

# Variables

PHPUNIT = $(APP) ./vendor/bin/simple-phpunit
XDEBUG_INI = /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Commands

.PHONY: phpunit.all
phpunit.all: xdebug.off ## PHPUnit: launch all tests (unit, functional, ...)
	$(PHPUNIT)

.PHONY: phpunit.coverage
phpunit.coverage: xdebug.on _build ## PHPUnit: generate code coverage report in HTML format
	$(PHPUNIT) --coverage-html $(FOLDER_BUILD)/phpunit/coverage

.PHONY: phpunit.coverage.clover
phpunit.coverage.clover: xdebug.on _build ## PHPUnit: generate code clover style coverage report
	$(PHPUNIT) --coverage-clover build/logs/clover.xml

.PHONY: phpunit.unit
phpunit.unit: ## PHPUnit: launch unit tests
	$(PHPUNIT) --testsuite unit

.PHONY: phpunit.unit.coverage
phpunit.unit.coverage: xdebug.on _build ## PHPUnit: generate code coverage report in HTML format for unit tests
	$(PHPUNIT) --testsuite unit --coverage-html $(FOLDER_BUILD)/phpunit/coverage

.PHONY: phpunit.functional
phpunit.functional: xdebug.off ## PHPUnit: launch functional tests with dump
	$(PHPUNIT) --testsuite functional

.PHONY: phpunit.functional.coverage
phpunit.functional.coverage: xdebug.on _build ## PHPUnit: generate code coverage report in HTML format for functional tests
	$(PHPUNIT) --testsuite functional --coverage-html $(FOLDER_BUILD)/phpunit/coverage

##

.PHONY: xdebug.on
xdebug.on: ## Xdebug: enable the module
	$(APP_ROOT) sed -i.default "s/^;zend_extension=/zend_extension=/" $(XDEBUG_INI)
	@echo -e '\033[1;42mXdebug ON\033[0m';

.PHONY: xdebug.off
xdebug.off: ## Xdebug: disable the module
	$(APP_ROOT) sed -i.default "s/^zend_extension=/;zend_extension=/" $(XDEBUG_INI)
	@echo -e '\033[1;41mXdebug OFF\033[0m';