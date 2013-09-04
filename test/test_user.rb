require File.expand_path '../helper.rb', __FILE__

class UserTest < MiniTest::Unit::TestCase

  def setup
    @name = "abc"
    @pass = "123"
    @base = Toggl::Base.new('abc','123')
  end

  def test_me
    @base.stub :request, Faraday::Response.new(:body => load_fixture('authentication')) do
      resp = @base.me
      refute_nil resp.body
      resp = @base.me(true)
      refute_nil resp.body
    end 
  end

  def test_update_me
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_user')) do
      resp = @base.update_me({"email" => "test@test.com"})
      refute_nil resp.body
    end 
  end

  def test_signup
    @base.stub :request, Faraday::Response.new(:body => load_fixture('signup')) do
      resp = @base.signup("xx@1.com",'1234','Etc/Utc')
      refute_nil resp.body
    end 
  end

  def test_reset_token
    @base.stub :request, Faraday::Response.new(:body => load_fixture('reset_api_token')) do
      resp = @base.reset_token
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
