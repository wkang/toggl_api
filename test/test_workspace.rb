require File.expand_path '../helper.rb', __FILE__

class WorkspaceTest < MiniTest::Unit::TestCase

  def setup
    @name = "abc"
    @pass = "123"
    @base = Toggl::Base.new('abc','123')
  end

  def test_get_workspaces
    @base.stub :request, Faraday::Response.new(:body => load_fixture('workspaces')) do
      resp = @base.workspaces
      refute_nil resp.body
    end 
  end

  def test_get_workspace_users
    @base.stub :request, Faraday::Response.new(:body => load_fixture('workspace_users')) do
      resp = @base.workspace_users(123)
      refute_nil resp.body
    end 
  end

  def test_get_workspace_clients
    @base.stub :request, Faraday::Response.new(:body => load_fixture('workspace_clients')) do
      resp = @base.workspace_clients(123)
      refute_nil resp.body
    end 
  end

  def test_get_workspace_projects
    @base.stub :request, Faraday::Response.new(:body => load_fixture('workspace_projects')) do
      resp = @base.workspace_projects(123)
      refute_nil resp.body
    end 
  end

  def test_get_workspace_tasks
    @base.stub :request, Faraday::Response.new(:body => load_fixture('workspace_tasks')) do
      resp = @base.workspace_tasks(123)
      refute_nil resp.body
    end 
  end
  
  def test_invite_users_to_workspace
    @base.stub :request, Faraday::Response.new(:body => load_fixture('invite_users_to_workspace')) do
      resp = @base.workspace_tasks(123,['1@1.com'])
      refute_nil resp.body
    end 
  end

  def test_update_workspace_user
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_workspace_user')) do
      resp = @base.update_workspace_user(123,{"name" => 'test'})
      refute_nil resp.body
    end 
  end

  def test_delete_workspace_user
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_workspace_user(123)
      assert_nil resp.body
    end 
  end

  def test_get_relations_of_workspace_and_user
    @base.stub :request, Faraday::Response.new(:body => load_fixture('relations_of_workspace_and_user')) do
      resp = @base.relations_of_workspace_and_user(123)
      refute_nil resp.body
    end 
  end

end 
