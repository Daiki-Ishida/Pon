import "./follow.css";

import "../follow-btn/follow-btn";
import "../unfollow-btn/unfollow-btn";

function followSwitch(e){
  e.preventDefault();
  const btn = e.target.closest('button');
  btn.disabled = true;
  const id = btn.value;
  const name = btn.name;
  const elm = document.getElementById(`follow_${id}`)
  let url = '';
  let sendData = '';
  let htmlMethod = '';
  if(name === 'follow'){
    url = 'http://localhost:3000/relationships';
    sendData = {
      follow: {
        followed_id: id
      }
    };
    htmlMethod = 'POST'
  }else if(name === 'unfollow'){
    url = `http://localhost:3000/relationships/${id}`;
    htmlMethod = 'DELETE';
  }else{
    alert('ERROR!')
  }
  const xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      console.log('success!');
      const newBtn = this.response;
      elm.textContent = '';
      elm.insertAdjacentHTML('beforeend', newBtn);
    } else if (this.readyState == 4) {
      alert('ERROR!');
      e.currentTarget.disabled = false;
    }
  }
  const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  xhr.open(htmlMethod, url);
  xhr.setRequestHeader('X-CSRF-Token', csfr);
  xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
  xhr.send(JSON.stringify(sendData));
}

window.onload = function(){
  const follows = document.getElementsByClassName('follow');
  for(var i = 0; i < follows.length; i++){
    var follow = follows[i];
    follow.addEventListener('click', followSwitch, false);
  }
}
