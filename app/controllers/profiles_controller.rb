class ProfilesController < ApplicationController
  def show
  end

  def update_selected
    puts 'upd ' + params.inspect
    prof = Profile.find_by_id(params[:id])
    prof.update_attribute(:selected, params[:selected].downcase == 'true')
  end

  def index
    @instruments = ['drums', 'vocals', 'bass']
    
    # Apply filter if instrument is selected
    if params[:instrument].present?
      @profiles = Profile.where(instrument: params[:instrument])
    else
      @profiles = Profile.all
    end
  end

  def destroy
  end
end
