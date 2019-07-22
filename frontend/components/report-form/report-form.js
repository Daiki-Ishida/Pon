import "./report-form.css";

import { resizeForm } from "../../lib/resize-form";

const reportFormTextArea = document.getElementById('textArea');
if(reportFormTextArea){
  reportFormTextArea.addEventListener('input', resizeForm);
}
