class LessonsController < ApplicationController
  before_action :set_lesson, only: [:edit, :update, :destroy, :show, :entries_update]
  before_action :authorize_student
  before_action :set_student
  before_action :authorize_instructor, only: [:edit, :update, :destroy, :new]
  # GET /lessons
  # GET /lessons.json
  def new  
    @lesson = @student.lessons.new
    @templates = @student.instructor.templates.all
    @entries = []
    @templates.each do |t| 
      @entries << @lesson.entries.new
    end
  end
  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])
    @comms = @lesson.comms
    @templates = @lesson.student.instructor.templates.all
  end

  # GET /lessons/new


  # GET /lessons/1/edit
  def edit
    @templates = @student.instructor.templates.all
    @entries = @lesson.entries.all
  end
  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = @student.lessons.create(lesson_params)
    @templates = @student.instructor.templates.all
    @entries = []
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to instructor_student_lesson_path(@instructor, @student, @lesson), notice: 'Lesson was successfully created.' }
      else
        format.html { render @lesson.errors }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end 
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to instructor_student_lesson_path(@student.instructor, @student, @lesson), notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to instructor_student_path(@student.instructor, @student), notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = Lesson.find(params[:id])
    @entries = @lesson.entries.all
    @student = @lesson.student
    @lessons = @student.lessons.all.order(:number)
  end
  def set_student
    @instructor = Instructor.find(params[:instructor_id])
    if @current_student
      @student = @current_student
    else
      @student = Student.find(params[:student_id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # {"number"=>"", "content"=>"<div>asd</div>", "video"=>""}
  def lesson_params
    params.require(:lesson).permit(:number, :content, :video, :tempus, entries_attributes: [:id, :mark, :note])
  end  
  def entry_params(par)
    par.permit(:mark, :lesson_id, :template_id, :note)
  end
end
