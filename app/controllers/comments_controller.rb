class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/prototypes/#{@comment.prototype.id}"
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render 'prototypes/show'
    end
  end

  private
  # ストロングパラメーターで保存できるカラムを指定。
  # prototype_idカラムにはparamsで渡されるように、params[:prototype_id]として保存。
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
