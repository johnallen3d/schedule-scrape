# ScheduleScraper

[![Build Status](https://secure.travis-ci.org/johnallen3d/schedule-scrape.png?branch=master)](http://travis-ci.org/johnallen3d/schedule-scrape)

A web calendar scraper for sites that do not provid portable (csv, i-cal etc) version.

Supported schedule sites:

* [PointStreak](http://pointstreak.com)

Supported output formats:

* CSV (plain dump)
* Google Calendar formatted CSV

## Installation

Add this line to your application's Gemfile:

    gem 'schedule-scraper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schedule-scraper

## Usage

### Pointstreak Example

Locate the printable version of the scheulde:

1. Visit the leagues home page
2. Click on the team in question
3. Click the SCHEDULE link under TEAM MENU
4. Click PRINT THIS PAGE

Request a schedule:

    url = "http://www.pointstreak.com/players/print/players-team-schedule.html?teamid=385368&seasonid=9162"
    schedule = ScheduleScrape.fetch(:point_streak, url)

Export the schedule to CSV:

    schedule.to_csv

or

    schedule.to_gcal

## TODO

1. Add more export options: iCal, Google Calendar (csv)
2. Add other schedule types: ezleagues

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
