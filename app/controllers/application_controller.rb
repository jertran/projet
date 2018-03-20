class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def create
    if resource_name().instance_of?(Student)
       str = 'Student'
    else
       str = 'Town'
    end
    puts str
    @instance = resource_name.new(resource_params)
    respond_to do |format|
      if @instance.save
        format.html { redirect_to @instance, notice: str+' was successfully created.' }
        format.json { render :show, status: :created, location: @instance }
      else
        format.html { render :new }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end


end
