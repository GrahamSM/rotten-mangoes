class Admin::UsersController < ActionController::Base

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
    @user.destroy
    redirect_to admin_users_path
  end

  def switch
  end

end
