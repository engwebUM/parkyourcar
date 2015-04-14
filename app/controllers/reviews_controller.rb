class ReviewsController < ApplicationController
  # GET /reviews
  def index
  end

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  def create
    @space = Space.find(params[:space_id])
    @review = Review.new(comment_params)
    @review.user = current_user
    @review.space = @space
    if @review.save
      flash[:success] = 'Review was successfully created.'
      redirect_to @space
    else
      render :new
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(params[:id])
      redirect_to @review
    else
      render 'edit'
    end
  end

  private
    def comment_params
      params.require(:review).permit(:comment, :evaluation)
    end
end
