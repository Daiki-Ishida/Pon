class FerretsController < ApplicationController
  def index
    @ferrets = Ferret.all
  end
end
