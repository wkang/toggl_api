module Toggl
  module Api
    module Workspace

      # *name*:  (string, required)
      # premium: If it's a pro workspace or not. Shows if someone is paying for the workspace or not (boolean, not required)
      # at:      timestamp that is sent in the response, indicates the time item was last updated

      def workspaces
        get "/workspaces"
      end

      def get_workspace_users(wid)
        get "/workspaces/#{wid}/users"
      end
      alias :workspace_users :get_workspace_users

      def get_workspace_clients(wid)
        get "/workspaces/#{wid}/clients"
      end
      alias :workspace_clients :get_workspace_clients

      # the token owner must be workspace admin
      def get_workspace_projects(wid, active=true)
        get "/workspaces/#{wid}/projects", {:active => active}
      end
      alias :workspace_projects :get_workspace_projects

      def get_workspace_tasks(wid, active=true)
        get "/workspaces/#{wid}/tasks", {:active => active}
      end
      alias :workspace_tasks :get_workspace_tasks

    end 
  end 
end 
