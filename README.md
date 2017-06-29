# Converter

Converts a database created by the [Collector](https://github.com/wfth/collector) into a database useful to [WO](https://github.com/wfth/wo).

## Development

#### Install Tools

1. Install [Node Version Manager](https://github.com/creationix/nvm)
2. Install [direnv](https://direnv.net)

#### Usage

1. Follow instructions to set up Collector and WO.
2. Install dependencies with `mix deps.get`
3. Review [`config/config.exs`](config/config.exs) to ensure `Converter.CollectorRepo` and `Converter.WORepo` are properly configured
4. `mix converter.convert`

## Heroku

The Converter cannot connect directly to the Heroku database.

1. Convert the Collector database in a development environment
2. `script/restore-staging-db`
