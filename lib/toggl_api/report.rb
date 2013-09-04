require 'toggl_api/request'

module Toggl
  class Report

    include Toggl::Request
    
    APIVERSION = "v2"

    def initialize(token)
      @username,@pass = token,"api_token"
    end

    #reports
    %w[weekly details summary].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(workspace_id, params={})
          request(:get, '/#{method}', params.merge({:workspace_id => workspace_id,:user_agent => user_agent}))
        end
      RUBY
    end

    private

    def basic_path(path)
      path = "/reports/api/#{APIVERSION}#{path}" unless path =~ /reports/
    end

  end
end
