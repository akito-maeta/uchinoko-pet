class HomesController < ApplicationController

  def about
    @random = Post.order("RANDOM()")
  end
end
