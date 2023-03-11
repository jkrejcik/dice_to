class CustomResultsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create show]
  before_action :custom_result_params, only: :create
  before_action :set_custom_result, only: :show

  def new
    @custom_result = CustomResult.new
    @custom_result.options.build
  end

  def create
    question = custom_result_params[:question]
    answer = custom_result_params[:options_attributes].values.sample[:input]
    @custom_result = CustomResult.new(question:, answer:)
    @custom_result.user = current_user
    if @custom_result.save
      redirect_to custom_result_path(@custom_result)
    else
      render('new')
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
