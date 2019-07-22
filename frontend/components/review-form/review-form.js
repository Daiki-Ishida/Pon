import "./review-form.css";
import "raty-js/lib/jquery.raty.css";

$('#star').raty({
  starType: 'i',
  scoreName: 'review[rate]',
});

import { resizeForm } from "../../lib/resize-form";

const reviewFormTextArea = document.getElementById('textArea');
if(reviewFormTextArea){
  reviewFormTextArea.addEventListener('input', resizeForm);
}
