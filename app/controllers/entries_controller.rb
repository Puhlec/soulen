class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_student_lesson
  def index
  end
  def new
    @entry = @lesson.entries.new
  end
  def show
    
  end
  def create
    @entry = @lesson.entries.create(entry_params)
    if @entry.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }

      end
    end
  end
  def edit
    @entry = Entry.find(params[:id])
    @templates = @student.instructor.templates.all
  end
  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      respond_to do |format|
        format.html { redirect_to instructor_student_lesson_path(@student.instructor, @student, @lesson) }
        format.json { render 'lessons/show', status: :ok, location: @lesson }
      end
    end
  end
  def destroy
    if @entry.destroy 
      respond_to do |format|
        format.html { redirect_to instructor_student_lesson_path(@student.instructor, @student, @lesson) }
      end
    end
  end
  def entry_params
    params.require(:entry).permit(:note, :mark, :lesson_id)
  end
  private
  def set_entry
    @entry = Entry.find(params[:id])
  end
  def set_student_lesson
    @student = Student.find(params[:student_id])
    @lesson = Lesson.find(params[:lesson_id])
  end
end
