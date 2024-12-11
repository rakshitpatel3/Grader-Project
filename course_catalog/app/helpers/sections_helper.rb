module SectionsHelper
  def course_number(section)
    section.course.number
  end

  def course_name(section)
    section.course.name
  end
end
