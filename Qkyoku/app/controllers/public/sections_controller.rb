class Public::SectionsController < ApplicationController
  
  def show
    @sections = Section.all
    @section = Section.find(params[:id])
  end
end
