class Admin::ExecutionStatusesController < ApplicationController
    def index
      @execution_statuses = ExecutionStatus.all
      @execution_status = ExecutionStatus.new
    end
    
    def create
      @execution_status = ExecutionStatus.new(execution_status_params)
      @execution_status.save
      redirect_to admin_execution_statuses_path
    end
    
    def edit
      @execution_status = ExecutionStatus.find(params[:id])
    end
    
    def update
      @execution_status = ExecutionStatus.find(params[:id])
      @execution_status.update(execution_status_params)
      redirect_to admin_execution_statuses_path
    end
    
    def destroy
      @execution_status = ExecutionStatus.find(params[:id])
      @execution_status.destroy
      redirect_to admin_execution_statuses_path
    end
    
    private
    def execution_status_params
      params.require(:execution_status).permit(:name)
    end
end
