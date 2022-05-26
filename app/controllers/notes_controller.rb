class NotesController < ApplicationController
  before_action :authentication

  def index
    # @notes = Note.all

    render json: "hello"
  end
end
