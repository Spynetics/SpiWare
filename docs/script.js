const scriptUrl = document.getElementById('scriptUrl');
const copiedMsg = document.getElementById('copiedMsg');

scriptUrl.onclick = function () {
  const url = scriptUrl.textContent.trim();
  navigator.clipboard.writeText(url).then(() => {
    copiedMsg.textContent = 'Copied!';
    copiedMsg.style.opacity = '1';
    // Animate fade out
    setTimeout(() => {
      copiedMsg.style.opacity = '0';
    }, 1200);
  });
}; 