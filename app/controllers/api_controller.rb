class ApiController < ApplicationController
  protect_from_forgery with: :null_session # To allow AJAX requests without CSRF token

  def create
    # Example data handling
    # Assuming you're sending JSON data
    data = JSON.parse(request.body.read)['bookmark']

    data.each do |prof|
      unless Profile.where(url: prof['url']).any?
        Profile.create(title: prof['title'], url: prof['url'], instrument: prof['instrument'])
      end
    end
    # if @profile.save
    #     render json: @profile, status: :ok, location: @profile
    # else
    #    render json: @profile.errors, status: :unprocessable_entity
    # end

    # Process the data (just a sample, adjust as per your needs)
    response_data = { message: "Data received successfully", received_data: data }

    # Send a JSON response
    render json: response_data, status: :ok
  rescue JSON::ParserError => e
    render json: { error: "Invalid JSON", message: e.message }, status: :unprocessable_entity
  end
end
