class SessionsController < ApplicationController
	def signup
	    user = User.new(user_params)
	    puts 'hello'
	    # if user is saved
	    if user.save
	      # we encrypt user info using the pre-define methods in application controller
	      token = encode_user_data({ user_data: user.id })

	      # return to user
	      render json: { token: token }
	    else
	      # render error message
	      render json: { message: "invalid credentials" }
	    end
  end

  def login
  	   user = User.find_by(email: params[:email])
	     if user && user.password == params[:password]
	       token = encode_user_data({ user_data: user.id })
  	       render json: {token: token}
  	     else
	       render json: { message: "invalid credentials" }
  	     end  
  end
  private
      def user_params
         params.permit(:email, :password) 
      end	

      def set_user
      	@user = User.find(params[:id])
      end	
end
