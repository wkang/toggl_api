module Toggl
  module Api
    module Task

      #  *name*:             The name of the task (string, required, unique in project)
      #  *pid*:              project ID for the task (integer, required)
      #   wid:               workspace ID, where the task will be saved (integer, project's workspace id is used when not supplied)
      #   uid:               user ID, to whom the task is assigned to (integer, not required)
      #   estimated_seconds: estimated duration of task in seconds (integer, not required)
      #   active:            whether the task is done or not (boolean, by default true)
      #   at:                timestamp that is sent in the response for PUT, indicates the time task was last updated

      def create_task(name, pid, options={})
        post "/tasks", {"tag" => {"name" => name,"pid" =>pid}.merge(options)}
      end

      def get_task(tid)
        get "/tasks/#{tid}"
      end
      alias :task :get_task

      def update_task(tids, options)
        options = Hashie::Mash.new options
        tids = tids.join(',') if tids.is_a?(Array)
        put "/tasks/#{tids}",(options.key?(:task) ? options : {:task => options})
      end

      alias :bulk_update_tasks :update_task

      def delete_task(tid)
        tids = tids.join(',') if tids.is_a?(Array)
        delete "/tasks/#{tids}"
      end
      alias :bulk_delete_tasks :delete_task

    end 
  end 
end 
