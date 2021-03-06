## UTIL

.PHONY: util.chown.fix
util.chown.fix: ## Util (Permissions): Editing permissions on Linux. | https://github.com/dunglas/symfony-docker#editing-permissions-on-linux
	docker-compose run --rm $(SERVICE_APP) chown -R $$(id -u):$$(id -g) .

.PHONY: util.readme.update
util.readme.update: .mk/bin/util-readme-update ## Util (Readme.adoc): Retrieve and insert the latest makefile commands & aliases in the Readme.adoc.
	. .mk/bin/util-readme-update

.PHONY: util.php.strict
util.php.strict: .mk/bin/util-php-strict ## Util (PHP): Insert `<?php declare(strict_types=1);` instead of `<?php` in all PHP files in src/ & tests/ folders.
	. .mk/bin/util-php-strict

.PHONY: util.ide.phpstorm.templates
util.ide.phpstorm.templates: .idea ## Util (PHPStorm): Copy templates from .ide/PHPStorm/fileTemplates folder in .idea/fileTemplates folder. | https://www.jetbrains.com/help/phpstorm/using-file-and-code-templates.html
	for f in .ide/PHPStorm/fileTemplates/*.dist ; do basename=$${f##*/}; cp -v "$${f%}" ".idea/fileTemplates/$${basename%.dist}" ; done