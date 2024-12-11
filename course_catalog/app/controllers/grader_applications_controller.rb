class GraderApplicationsController < ApplicationController
  before_action :set_grader_application, only: %i[ show edit update destroy ]

  # GET /grader_applications or /grader_applications.json
  def index
    @grader_applications = GraderApplication.all
  end

  # GET /grader_applications/1 or /grader_applications/1.json
  def show
  end

  # GET /grader_applications/new
  def new
    @grader_application = GraderApplication.new
    @courses = Course.all
  end

  # GET /grader_applications/1/edit
  def edit
  end

  # POST /grader_applications or /grader_applications.json
  def create

    @grader_application = current_user.build_grader_application(grader_application_params)
  
    respond_to do |format|
      if @grader_application.save
        format.html { redirect_to @grader_application, notice: "Grader application was successfully created." }
        format.json { render :show, status: :created, location: @grader_application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grader_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grader_applications/1 or /grader_applications/1.json
  def update
    respond_to do |format|
      if @grader_application.update(grader_application_params)
        format.html { redirect_to @grader_application, notice: "Grader application was successfully updated." }
        format.json { render :show, status: :ok, location: @grader_application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grader_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grader_applications/1 or /grader_applications/1.json
  def destroy
    @grader_application.destroy!

    respond_to do |format|
      format.html { redirect_to grader_applications_path, status: :see_other, notice: "Grader application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grader_application
      @grader_application = current_user.grader_application
    end

    # Only allow a list of trusted parameters through.
    def grader_application_params
      params.require(:grader_application).permit(:availability, :section_id, :course_number)
    end
end
