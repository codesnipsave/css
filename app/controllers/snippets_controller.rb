class SnippetsController < ApplicationController
  before_action :set_snippet, only: [:show, :edit, :update, :destroy, :vote, :unvote, :flag]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :vote, :unvote, :flag]
  # impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.all.order('created_at DESC')
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @tags = @snippet.tags
    @updates = @snippet.snippets
    @parent = @snippet.snippet
    if user_signed_in? 
      if @snippet.user and current_user.id != @snippet.user.id 
        impressionist(@snippet)
      end
    else 
      impressionist(@snippet)
    end
  end

  # GET /snippets/new
  def new
    @snippet =  current_user.snippets.build
    @tags = Tag.all
    if params[:snippet_id]
      @parent = true
      @snippet =  Snippet.find(params[:snippet_id])
    end
  end

  # GET /snippets/1/edit
  def edit
    @tags = Tag.all
  end

  # POST /snippets
  # POST /snippets.json
  def create
    puts snippet_params
    if params[:snippet_id]
    @parent = Snippet.find(params[:snippet_id])
    @snippet = @parent.snippets.build(snippet_params)
    @snippet.user_id = current_user.id
    else 
    @snippet = current_user.snippets.build(snippet_params)
    end
    @snippet.username = current_user.name
    params[:tags].each do |tag|
      @snippet.tags << Tag.find(tag)
    end
    respond_to do |format|
      if @snippet.save
        format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else 
        puts @snippet.errors.to_json
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to snippets_url, notice: 'Snippet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @snippet.liked_by current_user
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js{render layout:false}
    end
  end

  def unvote
    @snippet.unliked_by current_user
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js{render layout:false}
    end
  end

  def outdated
    @snippet.liked_by current_user
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js{render layout:false}
    end
  end

  def notoutdated
    @snippet.unliked_by current_user
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js{render layout:false}
    end
  end

  def flag
    puts 'mail sent'
    FlagSnippetMailer.flag_snippet(current_user, @snippet).deliver
    
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path, notice: 'Message sent to admin. Actions would be taken'}
      format.js{render layout:false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def snippet_params
      params.require(:snippet).permit(:title, :common, :beginner, :expert, :tags)
    end
end
