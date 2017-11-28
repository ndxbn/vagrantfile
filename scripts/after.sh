#!/bin/bash -eu

# http://packagist.jp
composer config -g repos.packagist composer https://packagist.jp
# https://github.com/hirak/prestissimo
composer global require hirak/prestissimo
