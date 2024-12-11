require "test_helper"

class GraderApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grader_application = grader_applications(:one)
  end

  test "should get index" do
    get grader_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_grader_application_url
    assert_response :success
  end

  test "should create grader_application" do
    assert_difference("GraderApplication.count") do
      post grader_applications_url, params: { grader_application: { availability: @grader_application.availability, course_ids: @grader_application.course_ids, user_id: @grader_application.user_id } }
    end

    assert_redirected_to grader_application_url(GraderApplication.last)
  end

  test "should show grader_application" do
    get grader_application_url(@grader_application)
    assert_response :success
  end

  test "should get edit" do
    get edit_grader_application_url(@grader_application)
    assert_response :success
  end

  test "should update grader_application" do
    patch grader_application_url(@grader_application), params: { grader_application: { availability: @grader_application.availability, course_ids: @grader_application.course_ids, user_id: @grader_application.user_id } }
    assert_redirected_to grader_application_url(@grader_application)
  end

  test "should destroy grader_application" do
    assert_difference("GraderApplication.count", -1) do
      delete grader_application_url(@grader_application)
    end

    assert_redirected_to grader_applications_url
  end
end
