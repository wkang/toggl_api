require 'toggl_api/error'

module Toggl
  module Request

    ENDPOINT = "https://www.toggl.com"

    attr_writer :user_agent, :connection_options

    def user_agent
      @user_agent ||= "Toggl Api Ruby Gem #{Toggl::VERSION}"
    end

    def connection_options
      @connection_options ||= {
        :headers => {
        :accept => 'application/json',
        :user_agent => user_agent,
        'Content-Type' => 'application/json'
        }
      }
    end

    #perform http request
    %w[get delete].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(path, params={})
          request(:#{method}, path, params)
        end
      RUBY
    end
    
    %w[post put].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(path, params={})
          request(:#{method}, path, MultiJson.dump(params))
        end
      RUBY
    end

    private 
    
    def request(method, path, params={})
      handle_response connection.send(method.to_sym, basic_path(path), params)
    rescue Faraday::Error::ClientError
      raise TogglApi::Error
    end

    def connection
      @connection ||= Faraday.new(ENDPOINT,connection_options) do |faraday|
        faraday.request :url_encoded  
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
