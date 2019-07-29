import "./comment-form.css";

import { async } from '../../lib/async';
import { resizeForm } from "../../lib/resize-form";


const submitComment = (e)=>{
  e.preventDefault();
  const form = e.target.parentNode
  const url = form.action
  const elm = document.getElementById('commentList');
  const input = document.getElementById('commentContent');
  const sendData = {
    comment: {
      content: input.value,
      post_id: form.getAttribute( "data-id" )
    }
  };
  async('POST', url, elm, sendData);
  input.value = '';
}

const sendBtn = document.getElementById('commentBtn');
if(sendBtn){
  sendBtn.addEventListener('click', submitComment);
}

const commentContent = document.getElementById('commentContent');
if(commentContent){
  commentContent.addEventListener('input', resizeForm);
}
