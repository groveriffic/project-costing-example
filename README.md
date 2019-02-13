# Project Costing Example

## Dependencies

Ruby Version is managed by [rbenv](https://github.com/rbenv/rbenv)

Dependencies are managed by [Bundler](https://bundler.io/)

Install with the commands:

    gem install bundler
    bundle install --binstubs

## Testing

Tests are in [RSpec](http://rspec.info/).

Run once with the command:

    bin/rspec

Or watch for changes with:

    bin/guard

## Running the report

Run the built in report with:

    bundle exec ruby main.rb > report.txt
