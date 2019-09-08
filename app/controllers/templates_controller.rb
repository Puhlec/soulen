class TemplatesController < ApplicationController
  def index
    @instructor = @current_instructor
    @templates = @instructor.templates.all
  end
  def new
    @template = Template.new
  end
  def destroy
    @template = Template.find(params[:id])
    @instructor = Instructor.find(params[:instructor_id])
    if  @template.destroy
      redirect_to @instructor
    end
  end

  def create
    @template = Instructor.find(params[:instructor_id]).templates.new(template_params)
    @template.pictogram = @template.pictogram.gsub(/\n/, '')
    @template.pictogram = @template.pictogram.gsub(/\r/, '')
    if    @template.save
      redirect_to settings_path(@template.instructor)    
    end
  end
  def edit
    @template = Template.find(params[:id])    
  end
  def show_templates
    @templates = Template.find(params[:id, :instructor_id])
  end
  def template_params
    params.require(:template).permit(:pictogram)
  end
end
