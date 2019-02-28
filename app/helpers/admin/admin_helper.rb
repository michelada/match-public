module Admin
  module AdminHelper
    def allowed_to_create_poll
      Poll.pending_polls(Date.today).empty?
    end
  end
end
