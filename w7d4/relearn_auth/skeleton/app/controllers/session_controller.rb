class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                      params[:user][:password])

    if @user
      sign_in(@user)
      redirect_to links_url
    else
      render :new
    end
  end

  def delete
    sign_out
    redirect_to new_session_url
  end
end
