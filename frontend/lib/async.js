const async = (method, url, elm, sendData)=>{
  const xhr = new XMLHttpRequest();
  const csfr = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      console.log('success!');
      const response = this.response;
      elm.insertAdjacentHTML('beforeend', response);
    } else if (this.readyState == 4) {
      alert('ERROR!');
    }
  };
  xhr.open(method, url);
  xhr.setRequestHeader('X-CSRF-Token', csfr);
  xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
  xhr.send(JSON.stringify(sendData));
}

const getUrl = (target)=>{
  const link = target.closest('a');
  const url = link.href
  const method = link.getAttribute( "data-method" );
  const id = link.getAttribute( "data-id" );
  link.disabled = true;
  return {url, method, id}
}

export { async, getUrl };
