import "./ferret-form.css";
import "../error-messages/error-messages";
import "../img-uploader/img-uploader";

import { resizeForm } from '../../lib/resize-form';

const ferretFormTextArea = document.getElementById('textArea');
if(ferretFormTextArea){
  ferretFormTextArea.addEventListener('input', resizeForm);
}
