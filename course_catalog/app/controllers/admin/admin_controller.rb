require 'httparty'

module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @courses = Course.all
  
      # Search functionality: filter by course number or title
      if params[:search].present?
        @courses = @courses.where("number LIKE ? OR name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      end
  
      # Pagination using Pagy
      @pagy, @courses = pagy(@courses, items: 10)
    end

    def reload_catalog
      response = HTTParty.get("https://contenttest.osu.edu/v2/classes/search", query: {
        q: "cse",
        client: "class-search-ui",
        campus: params[:campus] || "col",
        term: params[:term],
        "academic-career": "ugrad",
        subject: "cse"
      })
      
      if response.success?
        if response.is_a?(Hash) && response.key?('data')
          response['data'].each do |course_data|
            course = Course.find_or_create_by(number: course_data['course'])
            course.update(name: course_data['title'])

            course_data['sections'].each do |section_data|
              Section.create(
                course: course,
                instructor: section_data['instructors'].first&.dig('displayName'),
                time: section_data['meetings'].first&.dig('meetingTime')
              )
            end
          end
          flash[:notice] = 'Catalog reloaded successfully'
        else
          flash[:alert] = "Unexpected response format."
        end
      else
        flash[:alert] = "Failed to reload catalog: #{response.code} #{response.message}"
      end

      redirect_to admin_index_path 
    end

    def approve
      if params[:id]
        user = User.find_by(id: params[:id])
        if user
          if user.update(approved: true)
            flash[:notice] = "User #{user.email} has been approved."
          else
            flash[:alert] = "Failed to approve user #{user.email}."
          end
          redirect_to admin_approve_path
        else
          flash[:alert] = "User not found."
          redirect_to admin_approve_path
        end
      else
        @pending_users = User.where(approved: [false, nil])
        render :approve
      end
    end

    private

    def require_admin
      unless current_user.admin?
        flash[:alert] = "You must be an admin"
        redirect_to root_path
      end
    end
  end
end
