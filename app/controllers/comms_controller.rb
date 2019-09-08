class CommsController < ApplicationController

  def destroy
    @comm = Comm.find(params[:id])
    @lesson = @comm.lesson
    @comm.destroy
    redirect_to instructor_student_lesson_path(@lesson.student.instructor, @lesson.student, @lesson)
  end
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @comm = @lesson.comms.create(comms_params)

    set_author
    if @comm.save
      redirect_to instructor_student_lesson_path(@lesson.student.instructor, @lesson.student, @lesson)
    end
  end
  def set_author
    if @current_student
      @comm.author = @current_student.name
    else if @current_instructor
      @comm.author = @current_instructor.name
    end
  end
end
def comms_params
  params.require(:comm).permit(:author, :body)
end
end
