class WelcomeController < ApplicationController
  def index
    @status = Status.last
    if @current_instructor
      redirect_to instructor_path(@current_instructor)
    end
    if @current_student
      redirect_to instructor_student_path(@current_student.instructor, @current_student)
    end
  end
end

