class Admin::SectionsController < ApplicationController
    def index
      @sections = Section.all
      @section = Section.new
      #@section_image = SectionImage.new
    end
    
    def create
      @section = Section.new(section_params)
      @section.save
      redirect_to admin_sections_path
    end
    
    def edit
      @section = Section.find(params[:id])
    end
    
    def update
      @section = Section.find(params[:id])
      @section.update(section_params)
      redirect_to admin_sections_path
    end
    
    def destroy
      @section = Section.find(params[:id])
      @section.destroy
      redirect_to admin_sections_path
    end
    
    private
    def section_params
        params.require(:section).permit(:name)
    end
end
