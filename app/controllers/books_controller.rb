class BooksController < ApplicationController
def index
  @books = Book.all
  @book_new = Book.new
  @user = current_user
end


def create
  @book_new = Book.new(book_params)
  @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new), notice: 'Book was successfully created.'
    else
  @user = current_user
  @books = Book.all
  render :index
    end
end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      @books = Book.all
        flash.now[:danger] = 'error'
        render :index
    end
  end

  def destroy
    if @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path(@book), notice: ''
    else
      @books = Book.all
        flash.now[:danger] = 'error'
        render :index
    end
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end