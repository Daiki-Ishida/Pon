import "./territory.css";

const territoryMap = document.getElementById('map')

const initMap = ()=>{
  const center = document.getElementById('center').value;
  const radiusInKms = document.getElementById('radius').value;
  let zoom = '';
  if(radiusInKms <= 5){
    zoom = 12;
  }else if(radiusInKms <= 10){
    zoom = 11;
  }else if(radiusInKms <= 15){
    zoom = 10.5;
  }else if(radiusInKms <= 20){
    zoom = 10;
  }else if(radiusInKms > 20){
    zoom = 9;
  }
  let map = new google.maps.Map(territoryMap, {
    zoom: zoom,
    disableDefaultUI: true
  });
  const geocoder = new google.maps.Geocoder();

  geocoder.geocode({'address': center}, function(results){
    map.setCenter(results[0].geometry.location);
    var marker = new google.maps.Marker({
      map: map,
      position: results[0].geometry.location
    });
    var circle = new google.maps.Circle({
      center: results[0].geometry.location,
      map: map,
      radius: radiusInKms * 1000,
      fillColor: '#83e2c5',
      fillOpacity: 0.5,
      strokeColor: '#4ba9a1',
      strokeOpacity: 1
    });
  });
}

if(territoryMap != null){
  initMap();
}

const territoryRange = document.getElementById('territoryRange');
const rangeDisplay = document.getElementById('rangeDisplay');

if(territoryRange){
  rangeDisplay.innerHTML = territoryRange.value;
  territoryRange.addEventListener('input', function(e){
    rangeDisplay.innerHTML = e.target.value;
  });
}
