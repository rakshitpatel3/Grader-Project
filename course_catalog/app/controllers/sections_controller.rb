class SectionsController < ApplicationController
  include Pagy::Backend
  
  before_action :authenticate_user!
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @sections = Section.includes(:course)
    if params[:search].present?
      @sections = @sections.joins(:course).where("courses.number LIKE ? OR sections.instructor LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    @pagy, @sections = pagy(@sections, items: 10)
  end

  def show
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to @section, notice: 'Section was successfully created.'
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
      render :edit
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_url, notice: 'Section was successfully deleted.'
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:course_id, :instructor, :time, :lab_time)
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to perform this action."
      redirect_to sections_path
    end
  end
end
