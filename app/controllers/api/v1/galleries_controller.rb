class Api::V1::GalleriesController < Api::BaseController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render json: @gallery, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end

  def resize_image
    current_user.gallery = Gallery.new() unless current_user.try(:gallery)

    image = Image.new(file: params[:gallery][:file])
    current_user.gallery.images << image
    current_user.gallery.save!

    resized_image = MiniMagick::Image.open("#{Rails.root}/public/#{image.file}")
    resized_image.resize(params[:gallery][:size])
    directory = Rails.root.join('resized_images', current_user.email)
    FileUtils::mkdir_p(directory) unless Dir.exists?(directory)
    resized_image.write("#{directory}/#{params[:gallery][:file].original_filename}")
    image.file.store!(resized_image) 

    render :status => 200,  :json => {
      :status=>"Success",
      :message=>"Your new Image was successfully uploaded with #{params[:gallery][:size]}", 
      url: image.file.url,
      width: resized_image.width,
      height: resized_image.height
    }
  end

  def show_all_images
    @images = current_user.gallery.images
    render json: @images
  end

  def resize_old_image
  new_file = params[:gallery][:image_name]
  directory = Rails.root.join( 'resized_images', current_user.email)
  all_files = Dir.entries(directory)
  if all_files.include? new_file
    image = MiniMagick::Image.open("#{directory}/#{new_file}")
    image.resize params[:gallery][:size]
    FileUtils::mkdir_p( directory ) unless Dir.exists?( directory )

    image.write("#{directory}/#{new_file}")
    render :status => 200,  :json => {
      :status=>"Success",
      :message=>"Your old Image was successfully uploaded with #{params[:gallery][:size]}",
      :url=> image.file.url,
      :width=> resized_image.width,
      :height=> resized_image.height
    }
  else 
    render :status => 422,  :json => {:status=>"errors",:message=>"No file"}
  end
end

  private
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params.require(:gallery).permit(:file)
    end
end
