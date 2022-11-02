class Admin::WorkplacesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @workplaces = Workplace.all
    @workplace = Workplace.new
  end
  
  def create
    @workplace = Workplace.new(workplace_params)
    @workplace.save
    redirect_to admin_workplaces_path
  end

  def edit
    @workplace = Workplace.find(params[:id])
  end
  
  def update
    @workplace = Workplace.find(params[:id])
    @workplace.update(workplace_params)
    redirect_to admin_workplaces_path
  end
  
  def destroy
    @workplace = Workplace.find(params[:id])
    @workplace.destroy
    redirect_to admin_workplaces_path
  end
  
  private
  def workplace_params
      params.require(:workplace).permit(:name, :image, :is_checked)
  end
end
