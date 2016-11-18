require 'test_helper'

describe AboutController, :locale do
  it "gets index" do
    get about_path
    must_respond_with :success
  end

  it "gets news & events" do
    get news_events_path
    must_respond_with :success
  end
end
