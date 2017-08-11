# Converter

Converts a database created by the [Collector](https://github.com/wfth/collector) into a database useful to [WO](https://github.com/wfth/wo).

## Development

#### Install Tools

1. Install [Node Version Manager](https://github.com/creationix/nvm)
2. Install [direnv](https://direnv.net)

#### Usage

1. Follow instructions to set up Collector and WO.
2. Install dependencies with `mix deps.get`
3. `cp Dropbox/Isaac/collector_dump_20170811.sql /tmp/collector_dump.sql)`
4. `script/load-collector-dump`

## Heroku

The Converter cannot connect directly to the Heroku database.

1. Convert the Collector database in a development environment
2. `script/restore-staging-db`
