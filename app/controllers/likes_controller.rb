class LikesController < ApplicationController
  before_action :set_content
  
  def toggle_like
    @like = @object.likes.find_by(user: current_user)
    if @like
      @like.destroy
    else
      @object.likes.create(user: current_user)
    end

    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "#{@link_prefix}#{@object.id}actions",
          partial: @partial,
          locals: {@link_prefix.to_sym => @object}
        )
      end
    end
  end

  private

  def set_content
    if params[:post_id]
      @object = Post.find(params[:post_id])
      @link_prefix = "post"
      @partial = "posts/post_actions"
    elsif params[:story_id]
      @object = Story.find(params[:post_id])
      @link_prefix = "story"
      @partial = "stories/story_actions"
    end
  end
end