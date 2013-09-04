module Toggl
  module Api
    module TimeEntry

      #  *description*:  (string, required)
      #  *wid*:          workspace ID (integer, required if pid or tid not supplied)
      #  *pid*:          project ID (integer, not required)
      #  *tid*:          task ID (integer, not required)
      #  *start*:        time entry start time (string, required, ISO 8601 date and time)
      #  *duration*:     time entry duration in seconds. If the time entry is currently running, the duration attribute contains a negative value, denoting the start of the time entry in seconds since epoch (Jan 1 1970). The correct duration can be calculated as current_time + duration, where current_time is the current time in seconds since epoch. (integer, required)
      #  *created_with*: the name of your client app (string, required)
      #   stop:          time entry stop time (string, not required, ISO 8601 date and time)
      #   billable:      (boolean, not required, default false, available for pro workspaces)
      #   tags:          a list of tag names (array of strings, not required)
      #   duronly:       should Toggl show the start and stop time of this time entry? (boolean, not required)
      #   at:            timestamp that is sent in the response, indicates the time item was last updated

      def create_time_entry(options)
        options = options.merge({:created_with => "Toggl Api Ruby Gem #{Toggl::VERSION}"})
        post "/time_entries", options
      end

      def start_time_entry(options)
        options = Hashie::Mash.new options
        post "/time_entries/start", (options.key?(:time_entry) ? options : {:time_entry => options})
      end

      def stop_time_entry(tid)
        put "/time_entries/#{tid}/stop"
      end

      def get_time_entry(tid)
        get "/time_entries/#{tid}"
      end
      alias :time_entry :get_time_entry

      def iso8601_date(date)
        case date
        when Time,Date
          iso = date.to_datetime.iso8601
        when String
          iso = DateTime.parse(date).iso8601
        else
          raise ArgumentError, "Can't convert #{date.class} to ISO-8601 Date/Time"
        end
      end

      #default return last 9 days time entries
      def get_time_entries(start_date=nil, end_date=nil)
        options = Hash.new
        options["start_date"] = iso8601_date(start_date) if start_date
        options["end_date"] = iso8601_date(end_date) if end_date
        get "/time_entries", options
      end

      alias :time_entries :get_time_entries

      def update_time_entry(tid,options)
        tid = tid.join(",") if tid.is_a? Array
        options = Hashie::Mash.new options
        put "/time_entries/#{tid}", (options.key?(:time_entry) ? options : {:time_entry => options})
      end

      alias :bulk_update_time_entries :update_time_entry

      def delete_time_entry(tid)
        delete "/time_entries/#{tid}"
      end

    end
  end
end

