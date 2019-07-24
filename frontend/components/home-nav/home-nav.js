import "./home-nav.css";

import "../sort-menu/sort-menu";


const sortBtn = document.getElementById('sortBtn');
const modal = document.getElementById('modal');

if(sortBtn){
  sortBtn.addEventListener('click', function(){
    modal.style.display = 'block';
  })
}
