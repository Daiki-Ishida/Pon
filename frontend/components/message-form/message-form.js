import "./message-form.css";

window.onload = function(){
  const messageFormContent = document.getElementById('messageFormContent');
  const heightOfLine = getComputedStyle(messageFormContent).getPropertyValue('line-height').split('px')[0];
  const intViewportHeight = window.innerHeight;
  const minLineHeight = heightOfLine * 1.5;
  const maxLineHeight = intViewportHeight * 0.5;
  const messageFormBtn = document.getElementById('messageFormBtn');
  if(messageFormBtn != null){
    messageFormBtn.disabled = true;
  }
  const resizeForm = ()=>{
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
}
