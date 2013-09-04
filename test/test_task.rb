require File.expand_path '../helper.rb', __FILE__

class TaskTest < MiniTest::Unit::TestCase

  def setup
    @name = "abc"
    @pass = "123"
    @base = Toggl::Base.new('abc','123')
  end

  def test_create_successful
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_task')) do
      resp = @base.create_task('xx',123)
      refute_nil resp.body
    end 
  end

  def test_get_task
    @base.stub :request, Faraday::Response.new(:body => load_fixture('task')) do
      resp = @base.task(123)
      refute_nil resp.body
    end 
  end

  def test_update_task
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_task')) do
      resp = @base.update_task(123,{"name" => "test"})
      refute_nil resp.body
    end 
  end

  def test_bulk_update_tasks
    @base.stub :request, Faraday::Response.new(:body => load_fixture('bulk_update_tasks')) do
      resp = @base.bulk_update_tasks('123',{"name" => "test"})
      refute_nil resp.body
    end 
  end

  def test_delete_task
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_task(123)
      assert_nil resp.body
    end 
  end

  def test_bulk_delete_task
    @base.stub :request, Faraday::Response.new do
      resp = @base.bulk_delete_tasks(['123','321'])
      assert_nil resp.body
    end 
  end

end 
