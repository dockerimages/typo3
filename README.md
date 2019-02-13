TYPO3 Quickstart in Docker
==========================

[![Docker Automated build](https://img.shields.io/docker/automated/dockerimages/typo3.svg)](https://hub.docker.com/r/dockerimages/typo3/)
[![Docker build status](https://img.shields.io/docker/build/dockerimages/typo3.svg)](https://hub.docker.com/r/dockerimages/typo3/)

This repository contains build instructions for a simple TYPO3 Docker image.

**Note** that this image is not intended for production usage (yet). It's goal is to provide users an easy quickstart for working with TYPO3.


## Compatibility Matrix
| Typo3 Version | Support | ext Support | PHP V | MYSQL V |
|---------------|---------|-------------|-------|---------|
| 9.5.x         | 10-2021 | 10-2024 | 7.2       | 5.5 |
| 8.7.x         | 03-2020 | 03-2023 | 7.0-7.2   | 5.5 |
| 7.6.x         | 11-2018 | 11-2021 | 5.5-7.2   | 5.5 |
| 6.2.x         | 03-2017 | 03-2020 | 5.3.7-5.6 | 5
| 6.1.x         |         |         | 5.3-5.4   | 5
| 6.0.x         |         |  	    | 5.3-5.4	| 5
| 4.7.x         |         | 	    | 5.3       | 5
| 4.6.x         |         | 	    | 5.3       | 5
| 4.5.x         |         | 	    | 5.2-5.3	| 5
| 4.4.x         |         | 	    | 5.2-5.3	| 5
| 4.3.x         |         | 	    | 5.2-5.3	| 5
| 4.2.x         |         | 	    | 5.2       | 4
| 4.1.x         |         | 	    | 4.3-5.2	| 3


Usage
-----

This container does not ship a database management system; which means you'll have to create your own database container. The upside of this is that you're not bound to any specific version of MySQL or MariaDB and can even use a PostgreSQL database if you like.

1. So, the first step should be to create a database container:

        $ docker run -d --name typo3-db \
           -e MYSQL_ROOT_PASSWORD=yoursupersecretpassword \
           -e MYSQL_USER=typo3 \
           -e MYSQL_PASSWORD=yourothersupersecretpassword \
           -e MYSQL_DATABASE=typo3 \
           mariadb:latest \
           --character-set-server=utf8 \
           --collation-server=utf8_unicode_ci

2. Next, use this image to create your TYPO3 container and link it with the database container:

        $ docker run -d --name typo3-web \
            --link typo3-db:db \
            -p 80:80 \
            dockerimages/typo3:8

3. After that, simply open `http://localhost/` in your browser to start the TYPO3 install tool. **Note**: If you're using Docker Machine to run Docker on Windows or MacOS, you'll need the Docker VM's IP instead (which you can find out using the `docker-machine ip default` command).

4. Complete the install tool. When prompted for database credentials, use the environment variables that you've passed to the database container in step 1. If you've linked the containers using the `--link` flag as shown in step 2, use `db` as database host name.

 ![](doc/database-setup.png)

Available tags
--------------

This repository offers the following image tags:

- `latest` maps to the latest available LTS version (currently, latest `9.5.*`)
- `9.5` and `9` for the latest available version from the `9.*` respectively `9.5.*` branch.
- `8.7` and `8` for the latest available version from the `8.*` respectively `8.7.*` branch.
- `7.6` and `7` for the latest available version from the `7.*` respectively `7.6.*` branch.
- `6.2` and `6` for the latest available version from the `6.*` respectively `6.2.*` branch.

