# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  before_action :set_user 
  def set_user
    @current_instructor ||= Instructor.find(session[:instructor_id]) if session[:instructor_id]
    if @current_instructor
    else
      @current_student ||= Student.find(session[:student_id]) if session[:student_id]
      @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
    end
  end
  def authorize_instructor
    redirect_to root_path unless @current_instructor or @current_admin
  end
  def authorize_student
    redirect_to root_path unless @current_student or @current_instructor or @current_admin
  end
  def authorize_admin
    redirect_to root_path unless @current_admin
  end
  def show_templates
    if @current_instructor
      @templates = @current_instructor.templates.all
    end
  end
end
