class PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :new_session

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #para este he creado un nuevo formulario en layouts/photos
  #incluir el archivo del controlador photos_helper
  include PhotosHelper

  def index

    @photos = get_possible_photos

  end
  def new
    @photo = Photo.new
  end

  def my_photos
    @photos = current_user.photos
  end

  def create
    @photo = Photo.create(photo_params)
    @photo.user = current_user
    if @photo.save
      redirect_to photo_path(@photo), notice: 'Foto creada correctamente'
    else
      flash[:alert] = 'Error al querer guardar la foto '+ @photo.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @possible_photos = get_possible_photos

    #le digo que mi foto viene como parametro por id
    @photo = @possible_photos.find_by_id(params[:id])
    if @photo.nil?
      #pintar la pagina co error 404
      render file: "#{Rails.root}/public/404.html", status: :not_found #404
    else
      render :show
    end
  end

  def edit
    @photo = current_user.photos.find_by_id(params[:id])
    if @photo.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found #404
    else
      render :edit
    end
  end

  def update
    @photo = current_user.photos.find_by_id(params[:id])
    if @photo.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found #404
    elsif @photo.update(photo_params)
      flash[:notice] = 'La foto '+ @photo.name + ' se ha actualizado correctamente'
      redirect_to photo_path(@photo)
    else
      flash[:alert] = 'Ocurrió un error al querer actualizar la foto'
      render :edit
    end
  end

  def destroy
    @photo = current_user.photos.find_by_id(params[:id])
    @photo.destroy
    flash[:notice] = 'La foto '+@photo.name+' ha sido eliminada correctamente'
    redirect_to :my_photos
  end


  private
  def photo_params
    params.require(:photo).permit(:name, :url, :description, :license, :visibility, :user_id)
  end

end

