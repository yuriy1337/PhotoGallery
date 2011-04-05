class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.xml

  require 'FileUtils'
  require 'will_paginate'
  require 'remote_link_renderer'

  ROOT = "../"
  ALBUMS_ROOT = "../albums/"

  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    Dir.chdir(Rails.root)
    Dir.chdir(ALBUMS_ROOT + @album.name + "/pictures")
    @pictures = Dir.glob("*")

    @page_results = @pictures.paginate(:page=>params['page'], :per_page => 4)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])

    album_path = ALBUMS_ROOT + @album.name
    FileUtils.mkdir_p(album_path)

    FileUtils.mkdir_p(album_path + "/pictures")
    FileUtils.mkdir_p(album_path + "/thumbnail")

    respond_to do |format|
      if @album.save
        format.html { redirect_to(@album, :notice => 'Album was successfully created.') }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    
    album_path = ALBUMS_ROOT + @album.name
    if(File.exists?(album_path))
      FileUtils.remove_dir(album_path)
    end

    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end

  def paginate_albums
    @album = Album.new(params[:album])
    Dir.chdir(Rails.root)
    Dir.chdir(ALBUMS_ROOT + @album.name + "/pictures")
    @pictures = Dir.glob("*")

    @page_results = @pictures.paginate(:page=>params['page'], :per_page => 4)
    render :partial => 'paginate_albums'
  end
end
