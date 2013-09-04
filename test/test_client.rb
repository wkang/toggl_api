require File.expand_path '../helper.rb', __FILE__

class ClientTest < MiniTest::Unit::TestCase

  def setup
    @base = Toggl::Base.new('abc','123')
  end

  def test_create_successful
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_client')) do
      resp = @base.create_client('xx',123)
      refute_nil resp.body
    end 
  end

  def test_get_client
    @base.stub :request, Faraday::Response.new(:body => load_fixture('client')) do
      resp = @base.client(123)
      refute_nil resp.body
    end 
  end

  def test_get_clients
    @base.stub :request, Faraday::Response.new(:body => load_fixture('clients')) do
      resp = @base.clients
      refute_nil resp.body
    end 
  end

  def test_get_client_projects
    @base.stub :request, Faraday::Response.new(:body => load_fixture('client_projects')) do
      resp = @base.client_projects(123)
      refute_nil resp.body
    end 
  end

  def test_update_client
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_client')) do
      resp = @base.update_client(123,{"name" => "test"})
      refute_nil resp.body
    end 
  end

  def test_delete_client
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_client(123)
      assert_nil resp.body
    end 
  end

end 
