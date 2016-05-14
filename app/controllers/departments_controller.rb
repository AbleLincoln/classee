class DepartmentsController < ApplicationController
  include HTTParty
  format :json

  def index
    @departments = Department.all
    # json_string = HTTParty.get('http://web-app.usc.edu/web/soc/api/classes/phys/20163')
    # parsed = JSON.parse json_string
    # @courses = parsed["OfferedCourses"]["course"]
  end

  def show
    @department = Department.find(params[:id])
    @abbrev = @department.abbrev
    json_string = HTTParty.get('http://web-app.usc.edu/web/soc/api/classes/'+ @abbrev + '/20163')
    parsed = JSON.parse json_string
    @courses = parsed["OfferedCourses"]["course"]

    @courses.each do |course|
      if course["CourseData"]["number"] == "100"
        @SectionData = course["CourseData"]["SectionData"]
        break
      end
    end
  end
end
