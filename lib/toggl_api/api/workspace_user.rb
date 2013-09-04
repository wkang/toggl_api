module Toggl
  module Api
    module WorkspaceUser

      # id:         workspace user id (integer)
      # uid:        user id of the workspace user (integer)
      # admin:      if user is workspace admin (boolean)
      # active:     if the workspace user has accepted the invitation to this workspace (boolean)
      # invite_url: if user has not accepted the invitation the url for accepting his/her invitation is sent when the request is made by workspace_admin

      def invite_users_to_workspace(wid, emails)
        post "/workspaces/#{wid}/invite",{:emails => emails}
      end

      def update_workspace_user(wuid, options)
        options = Hashie::Mash.new options
        post "/workspace_users/#{wuid}",(options.key?(:workspace_user) ? options : {:workspace_user => options})
      end

      def delete_workspace_user(uid)
        delete "/workspace_users/#{uid}"
      end

      #orkspace_user objects (the connection between user and workspace)
      def get_relations_of_workspace_and_user(wid)
        get "/workspaces/#{wid}/workspace_users"
      end
      alias :relations_of_workspace_and_user :get_relations_of_workspace_and_user

    end
  end 
end 
