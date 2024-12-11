require "application_system_test_case"

class GraderApplicationsTest < ApplicationSystemTestCase
  setup do
    @grader_application = grader_applications(:one)
  end

  test "visiting the index" do
    visit grader_applications_url
    assert_selector "h1", text: "Grader applications"
  end

  test "should create grader application" do
    visit grader_applications_url
    click_on "New grader application"

    fill_in "Availability", with: @grader_application.availability
    fill_in "Course ids", with: @grader_application.course_ids
    fill_in "User", with: @grader_application.user_id
    click_on "Create Grader application"

    assert_text "Grader application was successfully created"
    click_on "Back"
  end

  test "should update Grader application" do
    visit grader_application_url(@grader_application)
    click_on "Edit this grader application", match: :first

    fill_in "Availability", with: @grader_application.availability
    fill_in "Course ids", with: @grader_application.course_ids
    fill_in "User", with: @grader_application.user_id
    click_on "Update Grader application"

    assert_text "Grader application was successfully updated"
    click_on "Back"
  end

  test "should destroy Grader application" do
    visit grader_application_url(@grader_application)
    click_on "Destroy this grader application", match: :first

    assert_text "Grader application was successfully destroyed"
  end
end
