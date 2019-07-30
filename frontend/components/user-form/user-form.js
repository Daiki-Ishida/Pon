import "./user-form.css";
import "../error-messages/error-messages";
import "../img-uploader/img-uploader";

import { resizeForm } from "../../lib/resize-form";

const userFormTextArea = document.getElementById('textArea');
if(userFormTextArea){
  userFormTextArea.addEventListener('input', resizeForm);
}
