class SectionsController < ApplicationController
  include Pagy::Backend
  
  before_action :authenticate_user!
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    @sections = Section.includes(:course)
    if params[:search].present?
      @sections = Section.joins(:course).where("courses.number LIKE :search OR sections.instructor LIKE :search", search: "%#{params[:search]}%")
    else
      @sections = Section.all
    end
    @pagy, @sections = pagy(@sections, items: 10)
  end

  def new
    @section = Section.new
    @courses = Course.all
  end

  def create
    @section = Section.new(section_params)
    @courses = Course.all
    if @section.save
      redirect_to sections_path, notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm_destroy
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    if @section.destroy
      redirect_to sections_path, notice: 'Section was successfully deleted.'
    else
      redirect_to sections_path, alert: 'Failed to delete the section.'
    end
  end

  private
     
  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:course_id, :instructor, :time, :lab_time, :graders_required)
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to perform this action."
      redirect_to sections_path
    end
  end
end

def record_not_found
  render plain: "Section does not exist", status: :not_found
end