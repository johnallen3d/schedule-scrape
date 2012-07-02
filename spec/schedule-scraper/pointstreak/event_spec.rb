require File.expand_path(File.join(File.dirname(__FILE__), '../../spec_helper'))

describe ScheduleScraper::Pointstreak::Event do
  let(:options) { POINTSTREAK_OPTIONS }
  let(:fields) { [:home_team, :away_team, :date, :time, :rink] }
  let(:expected_values) do
    {
      :home_team => "BLADES 6",
      :away_team => "SUMMIT 8",
      :date => "Sun, Jun 03",
      :time => "7:45 pm",
      :rink => "final"
    }
  end

  before do
    VCR.use_cassette('summit_summer_2012') do
      @schedule = ScheduleScraper::Pointstreak::Schedule.fetch(options)
    end
  end

  subject() { @schedule.events.first }

  [:home_team, :away_team, :date, :time, :rink].each do |field|
    it "can find the #{field.to_s.gsub('_', ' ')}" do
      subject.send(field).wont_be_nil
    end
  end

  it "uses elements to define fields for csv" do
    klass = ScheduleScraper::Pointstreak::Event
    klass.send(:export_fields).must_equal expected_values.keys
  end

  it "returns a list of fields when you ask for csv" do
    subject.to_csv.must_equal expected_values.values
  end

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
