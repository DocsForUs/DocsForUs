# class BetterDoctorsController < ApplicationController
#   caches_action :search, cache_path: Proc.new { |c| c.request.url }, expires_in: 30.minutes
#
#   def search
#     render json: doctors_service.doctors(search_params, filter_params)
#   end
#
# protected
#   def search_params
#     params.permit(:name)
#   end
#
#   def filter_params
#     params.permit(:skip, :limit)
#   end
#
#   def doctors_service
#     BetterDoctorService.new({
#       user_key: ENV["BETTER_DOCTOR_USER_KEY"]
#     })
#   end
# end
