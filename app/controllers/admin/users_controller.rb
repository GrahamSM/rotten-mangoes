class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(movie_params)
    if @user.save
      redirect_to movies_path, notice: "#{@user.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @create = Movie.find(params[:id])
    if @create.update_attributes(user) #if the update is successful
      redirect_to movie_path(@create)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user)
    @user.destroy
    redirect_to root_path
  end

  def switch
    session[:showing] = params[:user_id].to_i
    redirect_to root_path
  end

  def back_to
    session[:showing] = session[:user_id]
    redirect_to root_path
  end

end
