import "./user.css";
import "../follow-stats/follow-stats";
import "../room/room";

const averageStar = document.getElementById('averageStar');
let score = '';
if(averageStar){
  score = averageStar.getAttribute('data-score');
}

$('#averageStar').raty({
  starType: 'i',
  readOnly: true,
  score: score
});
