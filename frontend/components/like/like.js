import "./like.css";

import { async, getUrl } from '../../lib/async';

const likeSwitch = (e)=>{
  e.preventDefault();
  const {url, method, id} = getUrl(e.target);
  const elm = document.getElementById(`like_${id}`);
  const sendData = null;
  async(method, url, elm, sendData);
}

const likes = document.getElementsByClassName('like');
if(likes){
  for(let i = 0; i < likes.length; i++){
    let like = likes[i];
    like.addEventListener('click', likeSwitch);
  }
}
