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
- `LOCALE="en" rails s`
- `LOCALE="dummy" rails s`
- `./bin/webpack-dev-server` in another tab

## Importing data

- Import projects rake task
- `rake import:projects['lib/data/seed/CoralFunders_Data_13.02.18_v2.csv']`
- Destroy all previous records and repopulate the database
- `rake import:repopulate['lib/data/seed/CoralFunders_Data_13.02.18_v2.csv']`
- Check logs to see any errors
- Some database problems can be solved using:
- `bundle exec rake db:drop db:create db:migrate`
