module Toggl
  module Api
    module Project

      #  *name*:           The name of the project (string, required, unique for client and workspace)
      #  *wid*:            workspace ID, where the project will be saved (integer, required)
      #   cid:             client ID(integer, not required)
      #   active:          whether the project is archived or not (boolean, by default true)
      #   is_private:      whether project is accessible for only project users or for all workspace users (boolean, default true)
      #   template:        whether the project can be used as a template (boolean, not required)
      #   template_id:     id of the template project used on current project's creation
      #   billable:        whether the project is billable or not (boolean, default true, available only for pro workspaces)
      #   auto_estimates:  whether the esitamated hours is calculated based on task esimations or is fixed manually(boolean, default false, not required, premium functionality)
      #   estimated_hours: if auto_estimates is true then the sum of task estimations is returned, otherwise user inserted hours (integer, not required, premium functionality)
      #   at:              timestamp that is sent in the response for PUT, indicates the time task was last updated

      def create_project(name, wid, options={})
        post "/projects", {"project" =>{"name"=>name,"wid"=>wid}.merge(options)}
      end

      def update_project(pid, option)
        options = Hashie::Mash.new options
        put "/projects/#{pid}", (options.key?(:project) ? options : {:project => options})
      end

      def get_project(pid)
        get "/projects/#{pid}"
      end

      alias :project :get_project

      def get_project_users(pid)
        get "/projects/#{pid}/project_users"
      end
      alias :project_users :get_project_users

      def delete_project(pid)
        pid = pid.join(',') if pid.is_a?(Array)
        delete "/projects/#{pid}"
      end

      alias :bulk_delete_projects :delete_project

    end 
  end 
end 
