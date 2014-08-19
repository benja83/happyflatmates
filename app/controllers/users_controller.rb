class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render plain: 'Sorry, user not found', status: 404 unless @user
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.save
    if @user.save
      flash[:notice] = "User created!"
      redirect_to( action: 'show', controller: 'users', id: @user.id)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def add_flat
    @users = User.all
    @flat_id = params[:id]
    render 'add_flat_form'
  end

  def update_flat_id
    users_to_add = params[:to_add]
    users_to_add.each do |id|
      user = User.find(id)
      user.update_attribute(:flat_id,params[:flat_id])
    end
    render 'index'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :flat_id)
    end
end
