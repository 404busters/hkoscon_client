String cleanHTML(String html) {
  return html
      .replaceAll(new RegExp(r'<[/\w\s]+>'), '')
      .replaceAll(new RegExp(r'&nbsp;|\t'), '');
}
