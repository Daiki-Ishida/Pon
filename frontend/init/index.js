import "./index.scss";
import "./form.css";
import "./btn.css";
import "./img.css";

const flashMessage = document.getElementById('alert');

if(flashMessage){
  $(document).on('click','#alertClose',function(){
    $('#alert').fadeOut('fast');
  });
  setTimeout(function(){
    $('#alert').fadeOut('slow');
  }, 5000)
}
