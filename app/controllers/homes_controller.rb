class HomesController < ApplicationController

  def about
    @random = Post.order("RAND()")
  end
end
