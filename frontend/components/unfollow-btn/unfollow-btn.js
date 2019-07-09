import "./unfollow-btn.css";

const unfollow = (e)=>{
  e.preventDefault();
  const unfollowingId = document.getElementById('unfollowingId').innerHTML;
  const url = `http://localhost:3000/relationships/${unfollowingId}`;
  const xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      console.log('ajax success!');
      const response = this.response;
      const newBtn = document.getElementById('follow');
      newBtn.innerHTML = response;
    } else if (this.readyState == 4) {
      alert('ERROR!');
    }
  };
  const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  xhr.open('DELETE', url);
  xhr.setRequestHeader('X-CSRF-Token', csfr);
  xhr.send(null);
}

const unfollowBtn = document.getElementById('follow');
if(unfollowBtn != null){
  unfollowBtn.addEventListener('click', unfollow);
}
