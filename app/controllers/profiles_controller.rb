# frozen_string_literal: true

class ProfilesController < ApplicationController
  def index
    @user_data = GithubService.new.search_user(params[:username]) if params[:username].present?
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == 'search'
        format.html { render partial: 'user_data', locals: { user_data: @user_data } }
      else
        format.html
      end
    end
  end
end
  