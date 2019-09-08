class SessionsController < ApplicationController
  def new
  end
  def create
    @instructor = Instructor.find_by(name: params[:name])
    if (@instructor && @instructor.authenticate(params[:password]))
      session[:instructor_id] = @instructor.id
      redirect_to instructor_path(@instructor)
    else
      @student = Student.find_by(name: params[:name])
      if (@student && @student.authenticate(params[:password]))
        session[:student_id] = @student.id
        redirect_to instructor_student_path(@student.instructor, @student)
      else
        @admin = Admin.find_by(name: params[:name])
        if (@admin && @admin.authenticate(params[:password]))
          session[:admin_id] = @admin.id
          redirect_to instructors_path
        else
          render '_form'
        end
      end
    end
  end
  def destroy
    if @current_instructor
      session[:instructor_id] = nil
    else
      if @current_student
      
      session[:student_id] = nil
      end
      if @current_admin
        session[:admin_id] = nil
      end
    end
    redirect_to root_path
  end
end
