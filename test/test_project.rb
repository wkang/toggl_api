require File.expand_path '../helper.rb', __FILE__

class ProjectTest < MiniTest::Unit::TestCase

  def setup
    @base = Toggl::Base.new('abc','123')
  end

  def test_create_successful
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_project')) do
      resp = @base.create_project('xx',123)
      refute_nil resp.body
    end 
  end

  def test_get_project
    @base.stub :request, Faraday::Response.new(:body => load_fixture('project')) do
      resp = @base.project(123)
      refute_nil resp.body
    end 
  end

  def test_get_project_users
    @base.stub :request, Faraday::Response.new(:body => load_fixture('project_users')) do
      resp = @base.project_users(123)
      refute_nil resp.body
    end 
  end

  def test_update_project
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_project')) do
      resp = @base.update_project(123,{"name" => "test"})
      refute_nil resp.body
    end 
  end

  def test_delete_project
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_project(123)
      assert_nil resp.body
    end 
  end

  def test_bulk_delete_project
    @base.stub :request, Faraday::Response.new do
      resp = @base.bulk_delete_projects(['123','321'])
      assert_nil resp.body
    end 
  end

  #project user
  def test_project_user_create
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_project_user')) do
      resp = @base.create_project_user('123','123')
      refute_nil resp.body
    end 
  end

  def test_bulk_create_project_user
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_project_user')) do
      resp = @base.bulk_create_project_users('123',['123','321'])
      refute_nil resp.body
    end 
  end

  def test_update_project_user
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_project_user')) do
      resp = @base.update_project_user('123',{:name =>'123'})
      refute_nil resp.body
    end 
  end

  def test_bulk_create_project_user
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_project_user')) do
      resp = @base.bulk_update_project_users('123',{:name => "test"})
      refute_nil resp.body
    end 
  end

  def test_delete_project_user
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_project_user(123)
      assert_nil resp.body
    end 
  end

  def test_bulk_delete_project
    @base.stub :request, Faraday::Response.new do
      resp = @base.bulk_delete_project_users(['123','321'])
      assert_nil resp.body
    end 
  end

end 
