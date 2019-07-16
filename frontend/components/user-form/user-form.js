import "./user-form.css";
import "../error-messages/error-messages";
import "../img-uploader/img-uploader";


const addressInput = document.getElementById('addressInput');
let lat = '';
let lng = '';

const getLatLng = ()=>{
  let geocoder = new google.maps.Geocoder();
  geocoder.geocode({
    address: addressInput.value
  },function(results, status){
    if(status == google.maps.GeocoderStatus.OK){
      let location = results[0].geometry.location;
      lat = location.lat();
      console.log(lat);
      document.getElementById('lat').value = lat;
      lng = location.lng();
      console.log(lng);
      document.getElementById('lng').value = lng;
    }else{
      console.log("Geocode was not successful for the following reason: " + status);
    }
  });
}

if (addressInput != null) {
  addressInput.addEventListener('input', getLatLng);
}
