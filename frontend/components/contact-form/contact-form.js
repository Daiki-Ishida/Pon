import "./contact-form.css";

import { resizeForm } from "../../lib/resize-form";

const contactFormTextArea = document.getElementById('textArea');
if(contactFormTextArea){
  contactFormTextArea.addEventListener('input', resizeForm);
}
