Standard Notes Server's Image for Docker
========================================

Unfortunately, the core developer of [Standard Notes](https://standardnotes.org/)
doesn't maintain Docker images for the different components of his web service
(which can be [self-hosted](https://docs.standardnotes.org/self-hosting/self-hosting-with-docker)).

This project aims to fill the gap, by providing a Docker image for the
[Sandard Notes server](https://github.com/standardnotes/syncing-server).

Can be configured with the following environment variables:

Setting     | Description
----------- | -------------------------------------------
**DB_HOST** | Where is hosted the MySQL/MariaDB database.
**DB_DATABASE** | Name of the database.
**DB_USERNAME** | User to connect to the database.
**DB_PASSWORD** | User's password to connect to the database.
**DISABLE_USER_REGISTRATION** | To disable new user registrations.
**SECRET_KEY_BASE** | Used by Ruby on Rails, to encrypt and sign sessions.

Used by and made for [Kloügle](https://github.com/arugifa/klougle), the Google
alternative automated with [Terraform](https://www.terraform.io/).
