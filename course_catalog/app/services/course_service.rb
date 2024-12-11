class CourseService
  include HTTParty
  base_uri 'https://contenttest.osu.edu/v2/classes'

  def initialize()
    @options = { query: { q: 'CSE', term: '1248' },   }
  end

  def fetch_all_courses_and_sections
    page = 1
    loop do
      @options[:query][:p] = page
      break unless fetch_courses_and_sections
      page += 1
    end
  end

  def fetch_courses_and_sections
    response = self.class.get('/search', @options)
    return unless response.success?

    data = response.parsed_response['data']['courses']
    save_courses_and_sections(data)
  end

  private

  def save_courses_and_sections(data)
    data.each do |course_data|
      course_info = course_data['course']
      formatted_number = "CSE #{course_info['catalogNumber']}"

      
      course = Course.find_or_initialize_by(number: formatted_number)
      course.assign_attributes(
        name: course_info['title'],
        catalog_number: course_info['catalogNumber'],
        term: course_info['term'],
        description: course_info['description'],
        lab_assistant_required: course_info['labAssistantRequired']
      )
      course.save!

     
      sections = course_data['sections']
      save_sections(sections, course)
    end
  end

  def save_sections(sections, course)
    sections.each do |section_data|
      meetings = section_data['meetings']

      
      meetings.each do |meeting|
        instructor = if meeting['instructors'].present? && meeting['instructors'][0]['displayName'].present?
                       meeting['instructors'][0]['displayName']
                     else
                       "Instructor not available" 
                     end

        time = if meeting['startTime'].present? && meeting['endTime'].present?
                 "#{meeting['startTime']} - #{meeting['endTime']}"
               else
                 "Time not available" 
               end

        section = Section.find_or_initialize_by(
          section_identifier: "#{section_data['section']}#{section_data['secCatalogNumber']}",
          course: course
        )
        section.assign_attributes(
          instructor: instructor,
          time: time
        )
        section.save!
      end
    end
  end
end
