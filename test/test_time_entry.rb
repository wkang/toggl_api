require File.expand_path '../helper.rb', __FILE__

class TimeEntryTest < MiniTest::Unit::TestCase

  def setup
    @name = "abc"
    @pass = "123"
    @base = Toggl::Base.new('abc','123')
  end

  def test_create_successful
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_time_entry')) do
      resp = @base.create_time_entry({})
      refute_nil resp.body
    end 
  end

  def test_get_time_entry
    @base.stub :request, Faraday::Response.new(:body => load_fixture('time_entry')) do
      resp = @base.time_entry(123)
      refute_nil resp.body
    end 
  end

  def test_update_time_entry
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_time_entry')) do
      resp = @base.update_time_entry(123,{"name" => "test"})
      refute_nil resp.body
    end 
  end

  def test_bulk_update_time_entries
    @base.stub :request, Faraday::Response.new(:body => load_fixture('bulk_update_time_entries')) do
      resp = @base.bulk_update_time_entries(['123','321'],{:description => "test"})
      refute_nil resp.body
    end 
  end

  def test_delete_time_entry
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_time_entry(123)
      assert_nil resp.body
    end 
  end

  def test_start_time_entry
    @base.stub :request, Faraday::Response.new(:body => load_fixture('start_time_entry')) do
      resp = @base.start_time_entry({})
      refute_nil resp.body
    end 
  end

  def test_stop_time_entry
    @base.stub :request, Faraday::Response.new(:body => load_fixture('stop_time_entry')) do
      resp = @base.stop_time_entry('113')
      refute_nil resp.body
    end 
  end

  def test_time_entries
    @base.stub :request, Faraday::Response.new(:body => load_fixture('time_entries')) do
      resp = @base.time_entries
      refute_nil resp.body
      resp = @base.time_entries(DateTime.now)
      refute_nil resp.body
      resp = @base.time_entries(DateTime.now,DateTime.now)
      refute_nil resp.body
    end 
  end

end 
