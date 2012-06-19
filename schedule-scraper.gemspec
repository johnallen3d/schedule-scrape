# -*- encoding: utf-8 -*-
require File.expand_path('../lib/schedule-scraper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Allen"]
  gem.email         = ["john@threedogconsulting.com"]
  gem.description   = %q{Scrapes online schedules and provides portable versions}
  gem.summary       = %q{A web calendar scraper for sites that do not provid portable (csv, i-cal etc) version. Initial version suport PointStreak.com. }
  gem.homepage      = "https://github.com/johnallen3d/schedule-scrape"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "schedule-scraper"
  gem.require_paths = ["lib"]
  gem.version       = ScheduleScraper::VERSION

  gem.add_dependency 'nibbler',       '~> 1.3.0'
  gem.add_dependency 'nokogiri',      '~> 1.5.4'

  gem.add_development_dependency 'minitest',            '~> 3.1.0'
  gem.add_development_dependency 'rake',                '~> 0.9.2'
  gem.add_development_dependency 'turn',                '~> 0.9.5'
  gem.add_development_dependency 'vcr',                 '~> 2.2.0'
  gem.add_development_dependency 'fakeweb',             '~> 1.3.0'
end
