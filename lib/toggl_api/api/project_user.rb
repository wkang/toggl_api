module Toggl
  module Api
    module ProjectUser

      #  *pid*:   project ID (integer, required)
      #  *uid*:   user ID, who is added to the project (integer, required)
      #  wid:     workspace ID, where the project belongs to (integer, not-required, project's workspace id is used)
      #  manager: admin rights for this project (boolean, default false)
      #  rate:    hourly rate for the project user (float, not-required, only for pro workspaces) in the currency of the project's client or in workspace default currency.
      #  at:      timestamp that is sent in the response, indicates when the project user was last updated
      #  
      #  #Workspace id (wid), project id (pid) and user id (uid) can't be changed on update.

      def create_project_user(pid,uids,options={})
        uids = uids.join(',') if uids.is_a? Array
        post "/project_users", {"project_user"=>{"pid"=>pid,"uid"=>uids,"fields"=>"fullname"}.merge(options)}
      end

      alias :bulk_create_project_users :create_project_user

      def update_project_user(uids, options)
        options = Hashie::Mash.new options
        options.merge!({"fields" =>  "fullname"})
        uids = uids.join(',') if uids.is_a? Array
        put "/project_users/#{uids}", (options.key?(:project_user) ? options : {:project_user => options})
      end

      alias :bulk_update_project_users :update_project_user

      def delete_project_user(uids)
        uids = uids.join(',') if uids.is_a? Array
        delete "/project_users/#{uids}"
      end

      alias :bulk_delete_project_users :delete_project_user 
    end
  end 
end 
