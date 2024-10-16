class CommentsController < ApplicationController

  before_action :authenticate_user! # Asegúrate de que el usuario esté autenticado


  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @new = News.find(params[:news_id])
    @comment = @new.comments.new(comment_params)
    @comment.user = current_user # Asocia el comentario con el usuario actual

    if @comment.save
      redirect_to news_index_path, new: 'Comentario creado exitosamente.'
      
    else
      flash.now[:alert] = @comment.errors.full_messages.to_sentence
      @comment = @news.comments
      render 'news/index'
      redirect_to news_index_path, alert: 'Error al crear el comentario.'
    end  
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to news_path(@comment.news), notice: 'Comentario eliminado.'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
