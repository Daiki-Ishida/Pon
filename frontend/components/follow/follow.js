import "./follow.css";

import "../follow-btn/follow-btn";
import "../unfollow-btn/unfollow-btn";

import { async, getUrl } from '../../lib/async';

const followSwitch = (e)=>{
  e.preventDefault();
  const {url, method, id} = getUrl(e.target);
  const elm = document.getElementById(`follow_${id}`)
  const sendData = {followed_id: id};
  async(method, url, elm, sendData);
  elm.textContent = '';
}

const follows = document.getElementsByClassName('follow');
if(follows){
  for(let i = 0; i < follows.length; i++){
    let follow = follows[i];
    follow.addEventListener('click', followSwitch);
  }
}
