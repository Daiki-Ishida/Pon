class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join("frontend")

# とりあえず動く。ただし、二重でIDが保存されるので要修正。
  def save_image(object, object_params, image_path)
    image = object_params[:image]
    object.update_attribute(:image, "#{object.id}.jpg")
    File.binwrite(image_path, image.read)
  end
  
end
