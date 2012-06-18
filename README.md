# ScheduleScraper

A web calendar scraper for sites that do not provid portable (csv, i-cal etc) version.

Supported schedule sites:

* [PointStreak](http://pointstreak.com)

Supported output formats:

* CSV

## Installation

Add this line to your application's Gemfile:

    gem 'schedule-scraper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schedule-scraper

## Usage

Request a schedule:

    schedule = ScheduleScrape.fetch(:point_streak, :season => 123, :team => 456)

Export the schedule to CSV:

    schedule.to_csv

## TODO

1. Add more export options: iCal, Google Calendar (csv)
2. Add other schedule types: ezleagues

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
