module Admin
  class PollsController < AdminController
    def index
      Poll.all
    end

    def new
      @poll = Poll.new
    end
  end
end
