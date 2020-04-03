class ReviewController < ApplicationController

    post "/review/new" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        @review = Review.new
        @review.title = params[:title]
        @review.content = params[:content]
        @review.rating = params[:rating]
        @review.date = Time.now.strftime("%b-%m-%d %H:%M:%S")
        @review.user_id = @current_user.id
        @review.save
        redirect "/users/#{@current_user.id}/home#testimonial"
      else
        redirect "/users/home"
      end

    end

    post "/review/delete" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        @review = Review.all.find_by(user_id: @current_user.id)
        if @review
          @review.destroy
        end
        redirect "/users/#{@current_user.id}/home#testimonial"
      else
        redirect "/users/home"
      end

    end

    patch "/review/edit" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        @review = Review.all.find_by(user_id: @current_user.id)
        if @review
          @review.title = params[:title]
          @review.content = params[:content]
          @review.rating = params[:rating]
          @review.date = Time.now.strftime("%b-%m-%d %H:%M:%S")
          @review.user_id = @current_user.id
          @review.save
        end
        redirect "/users/#{@current_user.id}/home#testimonial"
      else
        redirect "/users/home"
      end

    end

end
