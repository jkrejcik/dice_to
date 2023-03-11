class CustomResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :custom_result_params, only: :create
  before_action :set_custom_result, only: :update 

  def new
    @custom_result = CustomResult.new
    @custom_result.options.build
  end

  def create
    @custom_result = CustomResult.new(custom_result_params)
    @custom_result.options.build
    @option = Option.create
    @custom_result.save
    raise
  end

  def update
    if @custom_result.update(set_custom_result)
      redirect_to custom_results_path
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
    params.require(:custom_result).permit(:id, :question, options_attributes: %i[id input _destroy])
  end
end
