require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))

describe ScheduleScraper::Schedule do
  subject() { ScheduleTest.fetch("http://www.xyz.com") }

  it "converts events to a list hashes" do
    export = subject.to_h

    export.must_be_instance_of Array
    export.each { |event| event.must_be_instance_of Hash }
  end

  it "generates a csv file" do
    subject.to_csv.must_be_instance_of String
  end

  it "generates a google calendar formatted csv" do
    subject.to_gcal.must_be_instance_of String
  end

  it "generates an ical file" do
    subject.to_ical.must_be_instance_of RiCal::Component::Calendar
  end
end
