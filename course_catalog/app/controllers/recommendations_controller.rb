class RecommendationsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_instructor, except: [:index, :show]
    before_action :set_recommendation, only: [:show, :edit, :update, :destroy]
    
    def index
      @recommendations = if current_user.admin?
        Recommendation.all
      elsif current_user.instructor?
        current_user.given_recommendations
      else
        current_user.received_recommendations
      end
    end
  
    def new
      @recommendation = Recommendation.new
      @courses = Course.all
      @sections = Section.all
    end
  
    def create
      @recommendation = Recommendation.new(recommendation_params)
      @recommendation.instructor = current_user
      
      student_email = params[:student_email]
      @recommendation.student = User.find_or_create_by(email: student_email) do |user|
        user.role = 'Student'
        user.password = 'password'
        user.name = student_email.split('@').first
        user.approved = true
      end
  
      if @recommendation.save
        redirect_to @recommendation, notice: 'Recommendation was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def show
      unless current_user.admin? || 
             current_user == @recommendation.instructor || 
             current_user == @recommendation.student
        redirect_to root_path, alert: 'You are not authorized to view this recommendation.'
      end
    end
  
    def edit
      unless current_user.admin? || current_user == @recommendation.instructor
        redirect_to root_path, alert: 'You are not authorized to edit this recommendation.'
      end
    end
  
    def update
      unless current_user.admin? || current_user == @recommendation.instructor
        redirect_to root_path, alert: 'You are not authorized to update this recommendation.'
        return
      end
  
      if @recommendation.update(recommendation_params)
        redirect_to @recommendation, notice: 'Recommendation was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      unless current_user.admin? || current_user == @recommendation.instructor
        redirect_to root_path, alert: 'You are not authorized to delete this recommendation.'
        return
      end
  
      @recommendation.destroy
      redirect_to recommendations_path, notice: 'Recommendation was successfully deleted.'
    end
  
    private
  
    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end
  
    def recommendation_params
      params.require(:recommendation).permit(:course_id, :section_id, 
                                           :recommendation_type, :comments)
    end
  
    def require_instructor
      unless current_user.instructor?
        redirect_to root_path, alert: 'Only instructors can create recommendations.'
      end
    end
end