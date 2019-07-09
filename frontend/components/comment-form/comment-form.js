import "./comment-form.css";


// コメントの非同期通信
const sendBtn = document.getElementById('commentBtn');
if(sendBtn != null){
  sendBtn.addEventListener('click', function(e){
    e.preventDefault();
    const commentUrl = 'http://localhost:3000/comments';
    const commentContent = document.getElementById('commentContent').value;
    const postId = document.getElementById('postId').value;
    const sendData = {
      comment: {
        content: commentContent,
        post_id: postId
      }
    };
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        console.log('ajax success!');
        document.getElementById('commentContent').value = '';
        const response = this.response;
        const commentList = document.getElementById('commentList');
        commentList.insertAdjacentHTML('beforeend', response);
      } else if (this.readyState == 4) {
        alert('ERROR!');
      }
    };
    const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    xhr.open('POST', commentUrl);
    xhr.setRequestHeader('X-CSRF-Token', csfr);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    xhr.send(JSON.stringify(sendData));
  })
}
