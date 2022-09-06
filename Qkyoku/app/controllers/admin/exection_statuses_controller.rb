class Admin::ExectionStatusesController < ApplicationController
    def index
        @exection_statuses = ExectionStatus.all
        @exection_status = ExectionStatus.new
    end
    
    def create
        @exection_status = ExectionStatus.new(exection_status_params)
        @exection_status.save
        redirect_to admin_exection_statuses_path
    end
    
    def edit
        @exection_status = ExectionStatus.find(params[:id])
    end
    
    def update
        @exection_status = ExectionStatus.find(params[:id])
        @exection_status.update
        redirect_to admin_exection_statuses_path
    end
    
    private
    def exection_status_params
        params.require(:exection_status).permit(:name)
    end
end
