class CustomResultsController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[new create custom]
  before_action :set_custom_result, only: :create
#   before_action :custom_result_params, only

  def new
    @custom = CustomResult.new
  end

  def create
    @custom_result = CustomResult.new(set_custom_result)
    @custom_result.save
  end


  def show
  end

  private

  def set_custom_result
    @custom_result = CustomResult.find(params[:id])
  end

#   def custom_result_params
#     params.require(:custom).permit(:question, :option)
#   end
 
end
