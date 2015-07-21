class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profile = current_user.profile
  end
  def new
    raise 'User already has a profile' if current_user.profile
    @profile = Profile.new
  end
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if(@profile.save)
      redirect_to profile_path, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def edit
    raise 'User has no profile' unless current_user.profile
    @profile = current_user.profile
  end
  def update
    @profile = current_user.profile
    if(@profile.update(profile_params))
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    current_user.profile.destroy
    redirect_to profile_path, notice: 'Profile was successfully deleted.'
  end

  private
  def profile_params
    params.require(:profile).permit(:agenda, :email, :password)
  end
end
