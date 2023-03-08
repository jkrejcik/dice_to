class CustomResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create custom]
  before_action :set_custom_result, only: :create
  before_action :custom_result_params, only: :update

  def new
    @custom = CustomResult.new
    @option = Option.new
  end

  def create
    @custom_result = CustomResult.new(set_custom_result)
    @custom_result.save
  end

  def update
    if @custom_result.update(custom_result_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
  end

  private

  def set_custom_result
    @custom_result = CustomResult.find(params[:id])
  end

  def custom_result_params
    params.require(:custom_result).permit(options_attributes: %i[id _destroy input])
  end
end
