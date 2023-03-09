class OptionsController < ApplicationController
  before_action :option_params, only: :create

  def create
    @option = Option.new(option_params)
    if @option.save
      flash[:success] = "Option saved!"
      redirect_to @option
    else
      render 'new'
    end
  end

  def option_params
    params.require(:option).permit(:input)
  end
end
