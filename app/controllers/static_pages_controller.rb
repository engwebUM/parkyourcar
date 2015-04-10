class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  
  def home
  end

  def help
  end

  def faq
  end

  def dashboard
  end
end
