# ScheduleScraper

[![Build Status](https://secure.travis-ci.org/johnallen3d/schedule-scrape.png?branch=master)](http://travis-ci.org/johnallen3d/schedule-scrape)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/johnallen3d/schedule-scrape)

A web calendar scraper for sites that do not provid portable (csv, i-cal etc) version.

Supported schedule sites:

* [PointStreak](http://pointstreak.com)
* [EZFacility](http://www.ezfacility.com/)

Supported output formats:

* CSV (straight dump)
* Google Calendar formatted CSV
* iCal
* Yahoo Calendar (via iCal)

## Installation

Add this line to your application's Gemfile:

    gem 'schedule-scraper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schedule-scraper

## Usage

Locate the printable version of the scheulde:

1. Visit the leagues home page
2. Click on the team in question
3. Click the SCHEDULE link under TEAM MENU
4. Click PRINT THIS PAGE

Request a schedule:

    url = "http://www.pointstreak.com/players/print/players-team-schedule.html?teamid=385368&seasonid=9162"
	schedule = ScheduleScraper.fetch(:pointstreak, url)
    
or

	url = "http://pinevilleice.ezleagues.ezfacility.com/teams/1026121/The-Schwartz.aspx"
	schedule = ScheduleScraper.fetch(:ezleagues, url)

then


Export the schedule:

    schedule.to_csv

or

    schedule.to_gcal

or

    schedule.to_ical

## TODO

1. Add other schedule types

## Why?

To scratch an itch.  I play on a couple of ice hockey teams and the rinks use these sites to manage leagues and schedules.  These sites do not offer any options for exporing and I got tired of updating my schedule manually every couple of months.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
