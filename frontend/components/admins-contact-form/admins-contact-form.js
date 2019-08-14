import "./admins-contact-form.css";

import { resizeForm } from "../../lib/resize-form";

const addminsContactFormTextArea = document.getElementById('textArea');
if(addminsContactFormTextArea){
  addminsContactFormTextArea.addEventListener('input', resizeForm);
}
