class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join("frontend")

# とりあえず動く。ただし、二重でIDが保存されるので要修正。
  def save_image(object, object_params)
    image = object_params[:image]
    initial = object.model_name.name[0]
    object.update_attribute(:image, "#{initial}_#{object.id}.jpg")
    File.binwrite("public/images/#{object.image}", image.read)
  end

end
