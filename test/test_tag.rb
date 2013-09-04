require File.expand_path '../helper.rb', __FILE__

class TagTest < MiniTest::Unit::TestCase

  def setup
    @name = "abc"
    @pass = "123"
    @base = Toggl::Base.new('abc','123')
  end

  def test_create_successful
    @base.stub :request, Faraday::Response.new(:body => load_fixture('create_tag')) do
      resp = @base.create_tag('xx',123)
      refute_nil resp.body
    end 
  end

  def test_update_tag
    @base.stub :request, Faraday::Response.new(:body => load_fixture('update_tag')) do
      resp = @base.update_tag_name(123,"test")
      refute_nil resp.body
    end 
  end

  def test_delete_tag
    @base.stub :request, Faraday::Response.new do
      resp = @base.delete_tag(123)
      assert_nil resp.body
    end 
  end

end 
