require File.expand_path '../helper.rb', __FILE__

class ReportTest < MiniTest::Unit::TestCase

  def setup
    @report = Toggl::Report.new('token')
  end

  def test_weekly_sccuess
    @report.stub :request, Faraday::Response.new(:body => load_fixture('report_success'))  do
      resp = @report.weekly('123')
      refute_match /error/,resp.body
      refute_nil resp.body
    end 
  end

  def test_weekly_failure
    @report.stub :request, Faraday::Response.new(:body => load_fixture('report_failure')) do
      resp = @report.weekly('123')
      assert_match /error/,resp.body
    end 
  end

  def test_details_sccuess
    @report.stub :request, Faraday::Response.new(:body => load_fixture('report_success'))  do
      resp = @report.details('123')
      refute_match /error/,resp.body
      refute_nil resp.body
    end 
  end

  def test_details_failure
    @report.stub :request, Faraday::Response.new(:body => load_fixture('report_failure')) do
      resp = @report.details('123')
      assert_match /error/,resp.body
    end 
  end

  def test_summary_sccuess
    @report.stub :request, Faraday::Response.new(:body => load_fixture('report_success'))  do
      resp = @report.summary('123')
      refute_match /error/,resp.body
      refute_nil resp.body
    end 
  end

  def test_summary_failure
    @report.stub :request, Faraday::Response.new(:body => load_fixture('report_failure')) do
      resp = @report.summary('123')
      assert_match /error/,resp.body
    end 
  end
end 
