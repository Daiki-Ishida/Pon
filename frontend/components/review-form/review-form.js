import "./review-form.css";
import "raty-js/lib/jquery.raty.css";

$('#star').raty({
  starType: 'i',
  scoreName: 'review[star]',
});
