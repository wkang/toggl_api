module Toggl
  module Api
    module Client

      #*name*: The name of the client (string, required, unique in workspace)
      #*wid*:  workspace ID, where the client will be used (integer, required)
      # notes: Notes for the client (string, not required)
      # hrate: The hourly rate for this client (float, not required, available only for pro workspaces)
      # cur:   The name of the client's currency (string, not required, available only for pro workspaces)
      # at:    timestamp that is sent in the response, indicates the time client was last updated

      def create_client(name, wid,options={})
        post "/clients", {"client" => {"name"=>name,"wid"=>wid}.merge(options)}
      end

      def get_client(cid)
        get "/clients/#{cid}"
      end
      alias :client :get_client

      def get_clients
        get "/clients"
      end
      alias :clients :get_clients

      def get_client_projects(cid,active=true)
        get "clients/#{cid}/projects",{:active => active}
      end
      alias :client_projects :get_client_projects

      def update_client(cid,options)
        options = Hashie::Mash.new options
        put "/clients/#{cid}", (options.key?(:client) ? options : {:client => options})
      end

      def delete_client(cid)
        delete "/clients/#{cid}"
      end

    end 
  end 
end 
