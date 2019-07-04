class FerretsController < ApplicationController
  def index
    @ferrets = Ferret.all
  end

  def new
    @ferret = Ferret.new
  end

  def create
    @ferret = Ferret.new(ferret_params)
    @ferret.user_id = 1
    if @ferret.save
      if @ferret.image
        save_image(@ferret, ferret_params)
      end
      redirect_to ferrets_path
    else
      render 'new'
    end
  end

  private

    def ferret_params
      params.require(:ferret).permit(:image,
                                     :name,
                                     :gender,
                                     :character,
                                     :introduction,
                                     :birth_date)
    end
end
