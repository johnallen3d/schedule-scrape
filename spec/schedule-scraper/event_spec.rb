require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe ScheduleScraper::Event do
  subject() { EventTest.new }

  let(:expected_values) {
    {
      :home_team => "home team",
      :away_team => "away team",
      :date => "01/01/2013",
      :time => "09:00 PM"
    }
  }

  describe "output helper methods" do
    it "defines a title" do
      expected = "#{expected_values[:home_team]} vs. #{expected_values[:away_team]}"
      subject.title.must_equal expected
    end

    it "defines a start date" do
      expected = Date.parse(expected_values[:date]).strftime("%m/%d/%y")
      subject.start_date.must_equal expected
    end

    it "defines an end date" do
      subject.end_date.must_equal subject.start_date
    end

    it "defines a start time" do
      subject.start_time.must_equal expected_values[:time]
    end

    it "defines a description" do
      subject.description.must_equal subject.title
    end

    it "defines all day event" do
      subject.all_day?.must_equal false
    end

    it "defines all private" do
      subject.private?.must_equal true
    end
  end

  describe "#to_gcal" do
    it "provides an array ready to export to csv" do
      expected = [
        subject.title,
        subject.start_date,
        subject.start_time,
        subject.end_date,
        "",
        false,
        subject.description,
        "",
        true
      ]

      subject.to_gcal.must_equal expected
    end
  end

  describe "#to_ical" do
    it "provides an array ready to export to csv" do
      local_subject = subject

      RiCal.Calendar do |cal|
        local_subject.to_ical(cal)
      end.must_be_instance_of RiCal::Component::Calendar
    end

    it "handles invalid times" do
      local_subject = subject
      subject.time = "this is not a date"

      RiCal.Calendar do |cal|
        local_subject.to_ical(cal)
      end.must_be_instance_of RiCal::Component::Calendar
    end
  end

  describe "#to_h" do
    it "provides a hash for export" do
      expected = {
        :title => subject.title,
        :start_date => subject.start_date,
        :start_time => subject.start_time,
        :end_date => subject.end_date,
        :all_day => subject.all_day?,
        :description => subject.description
      }

      subject.to_h.must_equal expected
    end
  end
end
