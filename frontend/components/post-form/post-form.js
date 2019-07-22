import "./post-form.css";

import { resizeForm } from "../../lib/resize-form";

const postFormTextArea = document.getElementById('textArea');
if(postFormTextArea){
  postFormTextArea.addEventListener('input', resizeForm);
}
