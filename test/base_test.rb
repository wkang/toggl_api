require File.expand_path '../helper.rb', __FILE__

class baseTest < MiniTest::Unit::TestCase

  def setup
    @name = "abc"
    @pass = "123"
    @base = Toggl::Base.new('abc','123')
  end

  def test_authorization_header
    assert_match /Basic/,@base.get("/api/v8/me")[:request_headers]["Authorization"]
  end

  def test_get_method
    @base.stub :request, Faraday::Response.new do
      assert_kind_of Faraday::Response, @base.get("/api/v8/me")
    end 
  end

  def test_post_method
    @base.stub :request, Faraday::Response.new do
      assert_kind_of Faraday::Response, @base.post("/api/v8/me")
    end 
  end

  def test_put_method
    @base.stub :request, Faraday::Response.new do
      assert_kind_of Faraday::Response, @base.put("/api/v8/me")
    end 
  end

  def test_delete_method
    @base.stub :request, Faraday::Response.new do
      assert_kind_of Faraday::Response, @base.delete("/api/v8/me")
    end 
  end

end

