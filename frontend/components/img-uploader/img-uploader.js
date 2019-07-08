import "./img-uploader.css";


const imagePreview = (event)=>{
  const file = event.target.files[0];
  const reader = new FileReader();
  const preview = document.getElementById("preview");
  const previewImage = document.getElementById("previewImage");

  if(previewImage != null) {
    preview.removeChild(previewImage);
  }
  reader.onload = function(event) {
    const img = document.createElement("img");
    img.setAttribute("src", reader.result);
    img.setAttribute("id", "previewImage");
    img.setAttribute("height", "200");
    img.setAttribute("width", "200");
    preview.appendChild(img);
  };

  reader.readAsDataURL(file);
}

const attachedImage = document.getElementById("attachedImage");
if(attachedImage != null){
  attachedImage.addEventListener('change', imagePreview);
}
