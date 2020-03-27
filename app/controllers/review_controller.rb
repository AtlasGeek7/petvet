class ReviewController < ApplicationController

    get "/users/:id/home#testimonial" do
        @current_user = User.find_by(email: session[:email])
        @review = Review.all.find_by(user_id: @current_user.id)
        erb :"/reviews/new"
    end

    post "/review/new" do
        @current_user = User.find_by(email: session[:email])
        @review = Review.new
        @review.title = params[:title]
        @review.content = params[:content]
        @review.rating = params[:rating]
        @review.date = Time.now.strftime("%b-%m-%d %H:%M:%S")
        @review.user_id = @current_user.id
        @review.save

        redirect "/users/#{@current_user.id}/home#testimonial"
    end

    get "/reviews" do
        @current_employee = Employee.find_by(email: session[:email])
        @current_user = User.find_by(email: session[:email])
        @reviews = Review.all
        @ratings = Review.all.map {|x| x.rating.to_f}
        @ratings_sum = @ratings.inject(0) {|sum, x| sum + x}
        @avg_rating = @ratings_sum / Review.all.size
        erb :"/reviews/reviews"
    end

    post "/review/delete" do
        @current_user = User.find_by(email: session[:email])
        @review = Review.all.find_by(user_id: @current_user.id)
        if @review
          @review.destroy
          @review.save
        end
        redirect "/users/#{@current_user.id}/home#testimonial"
    end

    post "/review/edit" do
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
    end

end
