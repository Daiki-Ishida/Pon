import "./message-form.css";

window.onload = function(){
  const messageFormContent = document.getElementById('messageFormContent');
  const heightOfLine = getComputedStyle(messageFormContent).getPropertyValue('line-height').split('px')[0];
  const intViewportHeight = window.innerHeight;
  const minLineHeight = heightOfLine * 1.5;
  const maxLineHeight = intViewportHeight * 0.5;

  const resizeForm = (event)=>{
    const lines = (messageFormContent.value + '\n').match(/\n/g).length;
    console.log(lines);
    const num = Math.min(maxLineHeight, Math.max(heightOfLine * lines, minLineHeight));
    messageFormContent.style.height = num + 'px';
  }
  if(messageFormContent != null){
    messageFormContent.addEventListener('input', resizeForm);
  }
}
