import "./like.css";


// const likeBtn = document.getElementById('likeBtn');
// const dislikeBtn = document.getElementById('dislikeBtn');
// const elm = document.getElementById('like');

const likeSwitch = (e)=>{
  e.preventDefault();
  const btn = e.target.closest('button');
  btn.disabled = true;
  const id = btn.value;
  const name = btn.name;
  const elm = document.getElementById(`like_${id}`);
  const url = `http://localhost:3000/posts/${id}/likes`;
  let method = '';
  if(name == 'like'){
    method = 'POST';
  }else if(name == 'dislike'){
    method = 'DELETE';
  }
  const xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      console.log('success!');
      const response = this.response;
      elm.textContent = '';
      elm.insertAdjacentHTML('beforeend', response);
    } else if (this.readyState == 4) {
      alert('ERROR!');
      e.currentTarget.disabled = false;
    }
  }
  const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  xhr.open(method, url);
  xhr.setRequestHeader('X-CSRF-Token', csfr);
  xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
  xhr.send(JSON.stringify(null));
}

window.onload = function(){
  const likes = document.getElementsByClassName('like');
  for(let i = 0; i < likes.length; i++){
    let like = likes[i];
    like.addEventListener('click', likeSwitch);
  }
}
