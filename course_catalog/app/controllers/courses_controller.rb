class CoursesController < ApplicationController
  include Pagy::Backend
  
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:new, :create, :fetch_classes, :edit, :update, :destroy]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :confirm_destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /courses or /courses.json
  def index
    @courses = Course.all

    # Search functionality: filter by course number or title
    if params[:search].present?
      @courses = @courses.where("number LIKE ? OR name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Pagination using Pagy
    @pagy, @courses = pagy(@courses, items: 10)

  end

  # GET /courses/1 or /courses/1.json
  def show
    # No need for @course = Course.find(params[:id]), set_course handles this
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm_destroy

  end

  def destroy
      if @course.destroy
        redirect_to courses_path, notice: 'Course was successfully deleted.'
      else
        redirect_to courses_path, alert: 'Failed to delete the course.'
      end
  end

  # POST /courses/fetch_classes
  def fetch_classes
    search_params = {
      q: params[:q],
      campus: params[:campus],
      term: params[:term],
      academic_career: params[:academic_career],
      subject: params[:subject],
      class_attribute: params[:class_attribute]
    }.reject { |_, v| v.blank? }

    # Ensure CourseService exists and handles API fetching
    CourseService.fetch_classes(search_params)
    redirect_to courses_url, notice: "Classes fetched successfully."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:term, :title, :description, :subject, :catalog_number, :campus, :course_id, :required_graders, :name, :number)
  end
  
  def authenticate_admin!
    unless current_user&.admin? 
      redirect_to root_path, alert: "Access denied."
    end
  end
end

def record_not_found
  render plain: "Course does not exist", status: :not_found
end
