import "./message-form.css";

import { resizeForm } from "../../lib/resize-form";

const messageFormContent = document.getElementById('messageFormContent');
if(messageFormContent){
  messageFormContent.addEventListener('input', resizeForm);
}
