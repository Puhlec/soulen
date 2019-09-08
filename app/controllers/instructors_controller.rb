class InstructorsController < ApplicationController
  before_action :set_instructor, :check_instructor, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:edit, :create, :new,:destroy, :index]
  before_action :show_templates, :authorize_instructor, only: [:show, :index]
  # GET /instructors
  # GET /instructors.json
  def index
    @instructors = Instructor.all
  end

  # GET /instructors/1
  # GET /instructors/1.json
  def show
    @students = @instructor.students.where(unused: false)
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
  end

  # POST /instructors
  # POST /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    respond_to do |format|
      if @instructor.save
        format.html { redirect_to @instructor, notice: 'Instructor was successfully created.' }
        format.json { render :show, status: :created, location: @instructor }
      else
        format.html { render :new }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update
    respond_to do |format|
      if @instructor.update(instructor_params)
        format.html { redirect_to @instructor, notice: 'Instructor was successfully updated.' }
        format.json { render :show, status: :ok, location: @instructor }
      else
        format.html { render :edit }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1
  # DELETE /instructors/1.json
  def destroy
    @instructor.destroy
    respond_to do |format|
      format.html { redirect_to instructors_url, notice: 'Instructor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def settings
    @instructor = @current_instructor
    @students = @instructor.students.where(unused: true)
    @templates = @instructor.templates.all
  end
   private
  # Use callbacks to share common setup or constraints between actions.
  def set_instructor
    @instructor = Instructor.find(params[:id])
    @templates = @instructor.templates.all
  end
  def check_instructor
    if (!(@current_instructor == @instructor) or @current_admin)
      if @current_instructor
        
        redirect_to @current_instructor
      end
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def instructor_params
    params.require(:instructor).permit(:name, :password)
  end
end
