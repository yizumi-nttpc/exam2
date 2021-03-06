class PictsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pict, only: [:edit, :update, :destroy]

  PERMISSIBLE_ATTRIBUTES = %i(picture picture_cache)

  def index
    @picts = Pict.all
  end

  def new
    if params[:back]
      @pict = Pict.new(picts_params)
    else
      @pict = Pict.new
    end
  end

  def create
    @pict = Pict.new(picts_params)
    @pict.user_id = current_user.id
    if @pict.save
      redirect_to picts_path, notice: "投稿しました"
      NoticeMailer.sendmail_pict(@pict).deliver
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @pict.update(picts_params)
      redirect_to picts_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @pict.destroy

    redirect_to picts_path
  end

  def confirm
    @pict = Pict.new(picts_params)
    render :new if @pict.invalid?
  end

  private
    def picts_params
      params.require(:pict).permit(:picture, :picture_cache, :content)
    end

    def set_pict
      @pict = Pict.find(params[:id])
    end

  protected

end
