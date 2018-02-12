# Collated Coral

See Wiki for more detailed information.

## Tech

- Ruby
- Rails 5.1.4
- Vue
- Vuex

## Local development

- Clone repo
- `bundle install`
- `yarn install`
- `rails s`

## Importing data

- Import projects rake task
- `rake import:projects['lib/data/seed/18-clean-data.csv']`
- Check logs to see any errors
- Some database problems can be solved using:
- `bundle exec rake db:drop db:create db:migrate`
