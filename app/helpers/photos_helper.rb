module PhotosHelper
# si se cumple, el usuario autenticado podrá ver sus fotos o las fotos públicas
# si no se cumple, el usuario no autenticado verá solamente las fotos públicas
	def get_possible_photos
		if current_user
	  		@possible_photos = Photo.where(user: current_user).or(Photo.where(visibility: :pub))
	  	else
	  		@possible_photos = Photo.where(visibility: :pub)
	  	end
	  	return @possible_photos
	end
end
