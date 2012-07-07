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
