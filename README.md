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
- `rake import:projects['lib/data/seed/CoralFunders_Data_12.02.18.csv']`
- Check logs to see any errors
- Some database problems can be solved using:
- `bundle exec rake db:drop db:create db:migrate`
