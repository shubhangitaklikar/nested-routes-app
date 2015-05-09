class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
   blog = Blog.find(params[:blog_id])
   @comments = blog.comments
   respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    blog = Blog.find(params[:blog_id])
    @comment = blog.comments.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @comment }
    end
  end

  # GET /comments/new
  def new
   blog = Blog.find(params[:blog_id])
   @comment = blog.comments.build
   respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    blog = Blog.find(params[:blog_id])
    @comment = blog.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    blog = Blog.find(params[:blog_id])
    @comment = blog.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
        format.html { redirect_to([@comment.blog, @comment], :notice => 'Comment was successfully created.') }
        #the key :location is associated to an array in order to build the correct route to the nested resource comment
        format.xml  { render :xml => @comment, :status => :created, :location => [@comment.blog, @comment] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    blog = Blog.find(params[:blog_id])
    @comment = blog.comments.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(comment_params)
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
        format.html { redirect_to([@comment.blog, @comment], :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
     blog = Blog.find(params[:blog_id])
     @comment = blog.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      #1st argument reference the path /posts/:post_id/comments/
      format.html { redirect_to(blog_comments_url) }
      format.xml  { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
