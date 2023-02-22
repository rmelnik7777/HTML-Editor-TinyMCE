tinymce.init({
  selector: 'textarea#default',
  mobile: {
    plugins: 'link',
    toolbar: 'bold italic underline h1 h2 link',
    // skin: 'udimi',
  },
});

function getContentHtml() {
    return tinymce.activeEditor.getContent();
}

