class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :destroy, :update, :edit]
  before_action :check_student, only: [:show]
  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @instructor = Instructor.find(params[:instructor_id])
    @templates = @instructor.templates.all
    @lessons = @student.lessons.all.order(:number)
  end

  # GET /students/new
  def new
    @student = Instructor.find(params[:instructor_id]).students.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Instructor.find(params[:instructor_id]).students.new(student_params)
    @student.unused = false
    respond_to do |format|
      if @student.save
        format.htmx { redirect_to instructor_path(@student.instructor), notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to instructor_student_path(@student.instructor, @student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to instructor_path(@instructor), notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def status
    @student = Student.find(params[:id])
    @student.unused = !@student.unused
    @student.save
    redirect_to @current_instructor
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_students
    @students = Instructor.find(params[:instructor_id]).students.order(created_at: :desc)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name, :password, :instructor_id, :avatar, :birthday, :startlearn, :datexam, :fullname)
  end
  def check_student
    if !(@current_instructor == @instructor or @current_admin or @current_student)
      if @current_instructor
        
        redirect_to @current_instructor
      else
        redirect_to root_path
      end
    end
    if !(@current_student == @student or @current_instructor or @current_admin)
      
      redirect_to instructor_student_path(@current_student.instructor, @current_student) if @current_student
    end
  end
  def set_student
    @student = Student.find(params[:id])
    @instructor = @student.instructor
  end
end
