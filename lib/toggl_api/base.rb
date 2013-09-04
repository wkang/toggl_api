require 'toggl_api/error'
require 'toggl_api/api/client'
require 'toggl_api/api/project'
require 'toggl_api/api/project_user'
require 'toggl_api/api/tag'
require 'toggl_api/api/task'
require 'toggl_api/api/time_entry'
require 'toggl_api/api/user'
require 'toggl_api/api/workspace'
require 'toggl_api/api/workspace_user'

module Toggl
  class Base
    include Toggl::Api::Client
    include Toggl::Api::Project
    include Toggl::Api::ProjectUser
    include Toggl::Api::Tag
    include Toggl::Api::Task
    include Toggl::Api::TimeEntry
    include Toggl::Api::User
    include Toggl::Api::Workspace
    include Toggl::Api::WorkspaceUser

    APIVERSION = "v8"
    ENDPOINT = "https://www.toggl.com"

    attr_writer :user_agent, :connection_options, :username, :pass

    def initialize(username, pass='api_token')
      @username,@pass = username,pass
    end

    def user_agent
      @user_agent ||= "Toggl Api Ruby Gem #{Toggl::VERSION}"
    end

    def connection_options
      @connection_options ||= {
        :headers => {
        :accept => 'application/json',
        :user_agent => user_agent,
      }
      }
    end

    #perform http request
    %w[get post put delete].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(path, params={})
          request(:#{method}, path, params)
        end
      RUBY
    end

    private 

    def request(method, path, params={})
      path = "/api/#{APIVERSION}#{path}" unless path =~ /api/
      handle_response connection.send(method.to_sym, path, params)
    rescue Faraday::Error::ClientError
      raise TogglApi::Error
    end

    def connection
      @connection ||= Faraday.new(ENDPOINT,connection_options) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.basic_auth @username, @pass
      end 
    end

    def handle_response(response)
      raise_errors(response)
      data = mash(MultiJson.load(response.body))
      (data.is_a?(Hash) && data.key?('data')) ? data['data'] : data
    end

    def raise_errors(response)
      message = "(#{response.status}): #{response.body}"
      case response.status.to_i
      when 400
        raise BadRequest, message
      when 401
        raise Unauthorized, message
      when 403
        raise Forbidden, message
      when 404
        raise NotFound, message
      when 500
        raise InternalServerError, message
      when 502..503
        raise Unavailable, message
      end
    end

    def mash(obj)
      if obj.is_a?(Array)
        obj.map { |item| make_mash_with_consistent_hash(item) }
      elsif obj.is_a?(Hash)
        make_mash_with_consistent_hash(obj)
      else
        obj
      end
    end

    def make_mash_with_consistent_hash(obj)
      m = Hashie::Mash.new(obj)
      def m.hash
        inspect.hash
      end
      return m
    end

  end 
end
