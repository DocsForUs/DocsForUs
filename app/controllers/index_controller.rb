class IndexController < ApplicationController

  def home
    render :"index"
  end

  def about
    render :"about"
  end

  def resources
    render :"resources"
  end

end
