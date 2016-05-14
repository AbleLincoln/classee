class StudentsController < ApplicationController
  include StudentsHelper
  include HTTParty
  format :json

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(article_params)
    @student.save
    redirect_to student_path(@student)
  end

  def show
    @student = Student.find(params[:id])
    @classes = Array.new
    @classes.push(@student.class1)
    @classes.push(@student.class2)
    @classes.push(@student.class3)
    @classes.push(@student.class4)
    @classes.push(@student.class5)

    @sections = Hash.new
    @classes.each do |this_class|
      if this_class != ""
        @sections[this_class] = pullJSON this_class
      end
    end

    @suggestedSections = Hash.new
    solveHelper @suggestedSections, @classes[0], 0, "Lec"
  end

  def solveHelper sectionsHash, classInQuestion, index, type
    if index == 5 || classInQuestion == ""
      return true
    end

    @sections[classInQuestion].each do |section|
      if section["type"] == type
        sectionsHash[classInQuestion+" "+type] = section
        if classAllGood sectionsHash
          if type == "Lec"
             if solveHelper sectionsHash, @classes[index], index, "Dis"
               return true
             end
          elsif type == "Dis"
            if solveHelper sectionsHash, @classes[index], index, "Lab"
              return true
            end
          elsif type == "Lab"
            if solveHelper sectionsHash, @classes[index], index, "Qz"
              return true
            end
          else
            if solveHelper sectionsHash, @classes[index+1], index+1, "Lec"
              return true
            end
          end
        end
      end
    end
    if type == "Lec"
      if solveHelper sectionsHash, @classes[index], index, "Dis"
        return true
      end
    elsif type == "Dis"
      if solveHelper sectionsHash, @classes[index], index, "Lab"
        return true
      end
    elsif type == "Lab"
      if solveHelper sectionsHash, @classes[index], index, "Qz"
        return true
      end
    else
      if solveHelper sectionsHash, @classes[index+1], index+1, "Lec"
        return true
      end
    end

    return false
  end

  def classAllGood sectionsHash
    sectionsHash.each do |this_k, this_v|
      sectionsHash.each do |compare_k, compare_v|
        if this_k != compare_k && this_v["day"] == compare_v["day"]
          this_timeStartArray = this_v["start_time"].split(":")
          this_timeStart = this_timeStartArray.join
          compare_timeStartArray = compare_v["start_time"].split(":")
          compare_timeStart = compare_timeStartArray.join
          this_timeEndArray = this_v["end_time"].split(":")
          this_timeEnd = this_timeEndArray.join
          compare_timeEndArray = compare_v["end_time"].split(":")
          compare_timeEnd = compare_timeEndArray.join

          puts this_k + ": " + this_timeStart + "-" + this_timeEnd + " " + compare_k + ": " + compare_timeStart + "-" + compare_timeEnd

          if (this_timeStart == compare_timeStart) || (this_timeStart <= compare_timeEnd && this_timeEnd >= compare_timeStart)
            puts "farttts" + this_k + " " + compare_k
            return false
          end
        end
      end
    end
    return true
  end

  def pullJSON classAndNum
    json_string = HTTParty.get('http://web-app.usc.edu/web/soc/api/classes/'+ classAndNum.split.first + '/20163')
    parsed = JSON.parse json_string
    @courses = parsed["OfferedCourses"]["course"]
    @courses.each do |course|
      if course["CourseData"]["number"] == classAndNum.split[1]
        @SectionData = course["CourseData"]["SectionData"]
        break
      end
    end

    return @SectionData
  end
end
