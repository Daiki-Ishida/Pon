import "./message-form.css";

// 要リファクタリング
// ファイルが統合された後にエラーが出るのを回避するために、ifの中に放り込んだ。


const messageFormContent = document.getElementById('messageFormContent');
let heightOfLine = '';
let intViewportHeight = '';
let minLineHeight = '';
let maxLineHeight = '';
let messageFormBtn = '';

if(messageFormContent != null){

  intViewportHeight = window.innerHeight;
  minLineHeight = heightOfLine * 1.5;
  maxLineHeight = intViewportHeight * 0.5;
  messageFormBtn = document.getElementById('messageFormBtn');
  if(messageFormBtn != null){
    messageFormBtn.disabled = true;
  }

  const resizeForm = ()=>{
    heightOfLine = window.getComputedStyle(messageFormContent).getPropertyValue('line-height').split('px')[0];
    const lines = (messageFormContent.value + '\n').match(/\n/g).length;
    const num = Math.min(maxLineHeight, Math.max(heightOfLine * lines, minLineHeight));
    messageFormContent.style.height = num + 'px';

    if(messageFormContent.value != '' && lines == 1){
      messageFormBtn.disabled = false;
      messageFormContent.style.borderTopRightRadius = '0';
    }else if(messageFormContent.value != '' && lines > 1){
      messageFormContent.style.borderTopRightRadius = '5px';
      messageFormBtn.disabled = false;
    }else{
      messageFormBtn.disabled = true;
    }
  }


  if(messageFormContent != null){
  messageFormContent.addEventListener('input', resizeForm);
  }

  const asyncMessage = (event)=>{
    event.preventDefault();
    messageFormBtn.disabled = true;
    const form = document.getElementById('messageForm');
    const url = form.action;
    const content = messageFormContent.value;
    const sendData = {
      message: {
        content: content
      }
    };
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        console.log('success!');
        messageFormContent.value = '';
        const response = this.response;
        const messages = document.getElementById('messages');
        messages.insertAdjacentHTML('beforeend', response);
        messageFormBtn.disabled = false;
      } else if (this.readyState == 4) {
        alert('ERROR!');
        messageFormBtn.disabled = false;
      }
    };
    const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    xhr.open('POST', url);
    xhr.setRequestHeader('X-CSRF-Token', csfr);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    xhr.send(JSON.stringify(sendData));
  }

  if(messageFormBtn != null){
    messageFormBtn.addEventListener('click', asyncMessage);
  }


}
