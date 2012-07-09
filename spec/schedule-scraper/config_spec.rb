require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

module ScheduleScraper
  module ExampleSite
    class Schedule
      include ScheduleScraper::Schedule
    end
  end
end

describe ScheduleScraper::Config do
  describe ".register_type" do
    it "retains the included class type" do
      expected = ScheduleScraper::ExampleSite::Schedule
      ScheduleScraper::Config.types.values.must_include(expected)
    end

    it "converts the class to a simple symbol for the type" do
      ScheduleScraper::Config.types.keys.must_include(:examplesite)
    end
  end
end
