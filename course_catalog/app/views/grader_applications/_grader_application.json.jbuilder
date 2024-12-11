json.extract! grader_application, :id, :user_id, :availability, :course_ids, :created_at, :updated_at
json.url grader_application_url(grader_application, format: :json)
