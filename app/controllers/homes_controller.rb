class HomesController < ApplicationController

  def about
    @random = Post.order("RAND()").limit()
  end
end
