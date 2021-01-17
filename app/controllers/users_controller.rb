class UsersController < ApplicationController
  before_action :authenticate_user!

def index
  @users = User.all
  @book = Book.new
  @user = current_user
end


def create
  @user = User.new(user_params)
  if @user.save
  redirect_to @user, notice: `投稿されました`
  else
    render 'root' 
  end
end

def show
  @user = User.find(params[:id])
  @books = @user.books
  @book = Book.new
end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      
      redirect_to user_path(@current_user)
    end  
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User was successfully updated.'
    else
        flash.now[:danger] = 'error'
        render :edit
    end
  end

  def destroy
    if @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path(@book), notice: 'Book was successfully created.'
  else
      @books = Book.all
        flash.now[:danger] = 'error'
        render :index
    end
  end

private
  def user_params
    params.require(:user).permit(:profile_image, :introduction, :name, :password)
  end
end
