# Wordpress CI base

Docker image with php-fpm and nginx

[![Build Status](https://travis-ci.org/normisg/symfony-ci-base.svg?branch=master)](https://travis-ci.org/normisg/symfony-ci-base)

- PHP 7.2.5
- Nginx 1.15.0

`docker run --rm -p 8080:80 -v /path/to/my/wordpress:/usr/share/nginx/html -t normisg/wordpress-ci-base`
