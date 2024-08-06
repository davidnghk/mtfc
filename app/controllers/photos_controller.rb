class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :load_photoable

  # POST /photos  
  # POST /photos.json
  def create_after
    # @order = Order.find(params[:order_id])
    if params[:images]
      params[:images].each do |img|
        #@order.photos.create(image: img, category: 2)

        @photoable.photos.create(image: img, category: 2)
      end 
    end
    # @photo = @order.photos
    @photo = @photoable.photos   
    redirect_to :back
  end

  def create_before 
    if params[:images]
      params[:images].each do |img|
        @photoable.photos.create(image: img, category: 1)
      end
    end
    @photo = @photoable.photos   
    redirect_to :back
    # redirect_back(fallback_location: request.referer, notice: "Saved..")
  end

  def create
    if params[:images]
      params[:images].each do |img|
        @photoable.photos.create(image: img, category: 0)
      end
    end
    @photo = @photoable.photos
#    redirect_to :back
    redirect_back(fallback_location: root_path)
  end

  def create_general
    if params[:images]
      params[:images].each do |img|
        @photoable.photos.create(image: img, category: 0)
      end
    end
    @photo = @photoable.photos   
    #redirect_to :back
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    @photos = @photoable.photos
    respond_to :js
  end

  def switch_printable
    @photo = Photo.find(params[:id])
    @photo.toggle!(:is_printable)
    @photos = @photoable.photos
    respond_to :js
  end

  private
    def load_photoable
#      master, master_id = request.path.split('/')[2, 3]
      master, master_id = request.path.split('/')[1,2]
#      byebug
      @photoable = master.singularize.classify.constantize.find(master_id)
      master_type = master.singularize.classify.constantize
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :category, :photoable_id, :photoable_type)
    end


end