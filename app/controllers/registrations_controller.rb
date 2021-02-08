 class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end  
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id #set server side but no one can tamper with it browser side.
            redirect_to root_path, notice: "Successfully created account!"
        else
            #flash[:alert] = "Something was wrong" errors provided by @user.save validation in model
            render :new
        end    
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end    

 end  