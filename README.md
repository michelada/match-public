[![pipeline status](https://git.michelada.io/michelada/mcm.michelada/badges/development/pipeline.svg)](https://git.michelada.io/michelada/mcm.michelada/commits/development)
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## System Requeriments

- Ruby 2.5.1
- Rails 5.2.1

## Dependencies

### Ruby

    bundle install

### System

## Database Management

To setup database yoy either run:

    rails db:setup

or:

    rails db:create
    rails db:migrate
    rails db:seed

### Running migrations

to run migrations use the following command:

    rails db:migrate

## Tests

You should run the tests with the following command:

    rails test
    rails test:system

## Linting

You can lint the code running Rubocop:

    rubocop
