module Toggl
  class Unauthorized           < StandardError; end
  class Forbidden              < StandardError; end 
  class BadRequest             < StandardError; end 
  class Unavailable            < StandardError; end
  class NotFound               < StandardError; end
  class InternalServerError    < StandardError; end
end
