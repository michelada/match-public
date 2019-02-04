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

    bundle exec rails db:setup

or:

    bundle exec rails db:create
    bundle exec rails db:migrate
    bundle exec rails db:seed

### Running migrations

to run migrations use the following command:

    bundle exec rails db:migrate

## Tests

You should run the tests with the following command:

    bundle exec rake

## Linting

You can lint the code running Rubocop:

    bundle exec rubocop
