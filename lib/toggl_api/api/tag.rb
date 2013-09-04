module Toggl
  module Api
    module Tag

      #  *name*: The name of the tag (string, required, unique in workspace)
      #  *wid*:  workspace ID, where the tag will be used (integer, required)

      def create_tag(name,wid)
        post "/tags", {"tag" => {"name" => name,"wid" =>wid}}
      end

      #tag wid can't be changed.
      #only name can be updated
      def update_tag_name(tag_id, name)
        put "/tags/#{tag_id}", {"tag" => {"name" => name}}
      end

      def delete_tag(tag_id)
        delete "/tags/#{tag_id}"
      end

    end 
  end 
end 
