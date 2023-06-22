class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :destroy]

  def index
    @stories = Story.all
  end

  def create
    @story = current_user.stories.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to root_path, notice: "Story was successfully created." }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, alert: @story.errors.full_messages }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Story was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:caption, :longitude, :latitude, :user_id, :allow_response, :show_likes_count, images: [])
    end
end
