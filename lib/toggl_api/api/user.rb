module Toggl
  module Api
    module User

      #pass related_data as true to all related data
      def me(related_data=false)
        get "/me",{:with_related_data => related_data }
      end

      # You can update the following user fields:
      # fullname: string
      # email: string, valid email
      # send_product_emails: boolean
      # send_weekly_report: boolean
      # send_timer_notifications: boolean
      # store_start_and_stop_time: boolean
      # beginning_of_week: integer, in the range of 0-6
      # timezone: string, IANA TZ timezones
      # timeofday_format: string, two formats are supported:
      # "H:mm" for 24-hour format
      # "h:mm A" for 12-hour format (AM/PM)
      # date_format: string, possible values: "YYYY-MM-DD", "DD.MM.YYYY", "DD-MM-YYYY", "MM/DD/YYYY", "DD/MM/YYYY", "MM-DD-YYYY"
      # 
      # To change password you have to have the following fields:
      # current_password: string
      # password: string
      def update_me(options={})
        options = Hashie::Mash.new options
        put "/me", (options.key?(:user) ? options : {:user => options})
      end

      #  *email*:        a valid email for the user whose account is created (string, required)
      #  *password*:     password at least 6 characters long (string, required)
      #  *timezone*:     for example "Etc/UTC" (string, required)
      #  *created_with*: in free form, name of the app that signed the user app (string, required)
      def signup(email, password, timezone, created_with="Toggl Api Ruby Gem #{Toggl::VERSION}")
        post "/signups",{"user" => {"email" => email,"password" => "password","timezone" => timezone,"created_with" => created_with}}
      end

      def reset_token
        post "/reset_token"
      end

    end 
  end 
end 
