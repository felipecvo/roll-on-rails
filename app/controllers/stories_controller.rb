class StoriesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  # GET /stories
  # GET /stories.xml
  def index
    page = 1
    page = params[:page] if params[:page]
    @stories = Story.paginate :page => page, :order => 'created_at DESC', :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = Story.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new
    @categories = Category.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = current_user.stories.new(params[:story])
    @story.permalink = create_permalink(@story.title)

    @story.permalink += "-#{Time.now.to_i}" if Story.find_by_permalink(@story.permalink)

    respond_to do |format|
      if @story.save
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to :action => :show, :id => @story.permalink }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        @categories = Category.find(:all)
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to(@story) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(stories_url) }
      format.xml  { head :ok }
    end
  end

  def vote
    Story.transaction do
      Vote.transaction do
        @story = Story.find(params[:id])
        if @story.user_id != current_user.id
          @already_voted = @story.votes.find_by_user_id(current_user.id)
          unless @already_voted
            @story.rolled += 1
            @story.votes.build(:user_id => current_user.id)
            @story.save
          end
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to :action => :show, :id => @story.permalink }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
