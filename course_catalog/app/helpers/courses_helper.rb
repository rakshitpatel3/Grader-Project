module CoursesHelper
  def course_level(course)
    course.number[4]
  end

  def full_course_name(course)
    "#{course.number} - #{course.name}"
  end

  def has_lab_assistant?(course)
    course.lab_assistant_required
  end
end
