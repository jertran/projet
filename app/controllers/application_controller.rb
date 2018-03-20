class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def message_factory
    if resource_name == Student
       str = 'Student'
    else
       str = 'Town'
    end
  end
  
  def create
    @instance = resource_name.new(resource_params)
    respond_to do |format|
      if @instance.save
        format.html { redirect_to @instance, notice: message_factory+' was successfully created.' }
        format.json { render :show, status: :created, location: @instance }
      else
        format.html { render :new }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @instance = resource
    respond_to do |format|
      if @instance.update(resource_params)
        format.html { redirect_to @instance, notice: message_factory+' was successfully updated.' }
        format.json { render :show, status: :ok, location: @instance }
      else
        format.html { render :edit }
        format.json { render json: @instance.errors, status: :unprocessable_entity }
      end
    end
  end
end



