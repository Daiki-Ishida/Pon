import "./request-form.css";

import { resizeForm } from "../../lib/resize-form";

const requestFormTextArea = document.getElementById('textArea');
if(requestFormTextArea){
  requestFormTextArea.addEventListener('input', resizeForm);
}
