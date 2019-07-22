const resizeForm = (e)=>{
  const input = e.target;
  const heightOfLine = window.getComputedStyle(input).getPropertyValue('line-height').split('px')[0];
  const intViewportHeight = window.innerHeight;
  const minLineHeight = heightOfLine * 1.5;
  const maxLineHeight = intViewportHeight * 0.5;

  const lines = (input.value + '\n').match(/\n/g).length;
  const height = Math.min(maxLineHeight, Math.max(heightOfLine * lines, minLineHeight));

  input.style.height = height + 'px';
}


export { resizeForm };
