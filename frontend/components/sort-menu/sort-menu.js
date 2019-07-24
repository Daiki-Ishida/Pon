import "./sort-menu.css";

const sortCloseBtn = document.getElementById('sortCloseBtn');

if(sortCloseBtn){
  sortCloseBtn.addEventListener('click', function(){
    modal.style.display = 'none';
  })
  window.addEventListener('click', function(e){
    if(e.target == modal){
      modal.style.display = 'none';
    }
  })
}
