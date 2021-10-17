class PrototypesController < ApplicationController
  # ログインしていない状態だと特定のページへのアクセスが制限
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]
  # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクト
  before_action :move_to_index, except: [:index, :show, :new, :create]

  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end

  def new
    @prototype = Prototype.new
  end

  # 投稿したデータの保存ができた時ルートパス、できなかった時は新規投稿ページへ戻る
  # (prototype_params)により、保存できず投稿ページに戻っても入力した項目は消えない
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  # パラメーターとして受け取った params[:id]で、Prototypeモデルの特定のオブジェクトをfindメソッドで取得。
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    # @prototype.commentsとすることで、@prototypeへ投稿されたすべてのコメントを取得
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  # 投稿内容の更新ができた時は詳細ページ、できなかった時は編集ページへ戻る
  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    end
  end

  # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクト
  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :user, :image).merge(user_id: current_user.id)
  end
end