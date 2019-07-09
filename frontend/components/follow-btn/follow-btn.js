import "./follow-btn.css";

const follow = (e)=>{
  e.preventDefault();
  const url = 'http://localhost:3000/relationships';
  const btn = document.getElementById('followBtn');
  btn.disabled = true;
  const followingId = btn.value;
  const sendData = {
    follow: {
      followed_id: followingId
    }
  };
  const xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      console.log('ajax success!');
      const response = this.response;
      const newBtn = document.getElementById('follow');
      newBtn.innerHTML = response;
    } else if (this.readyState == 4) {
      alert('ERROR!');
      btn.disabled = false;
    }
  };
  const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  xhr.open('POST', url);
  xhr.setRequestHeader('X-CSRF-Token', csfr);
  xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
  xhr.send(JSON.stringify(sendData));
}



const followBtn = document.getElementById('follow');
if(followBtn != null){
  followBtn.addEventListener('click', follow);
}
