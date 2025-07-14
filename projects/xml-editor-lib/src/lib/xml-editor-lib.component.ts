import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'lib-xml-editor-lib',
  templateUrl: './xml-editor-lib.component.html',
  styleUrls: ['./xml-editor-lib.component.scss']
})
export class XmlEditorLibComponent implements OnInit {

  @Input() showToolbar: boolean = true;
  @Input() showStatusBar: boolean = true;
  @Input() xmlContent: string = '';
  @Input() apiKey: string = '';  // נקלט מהצרכן

  convertedXmlContent: string = '';  // לשימוש ב־onConvertClicked

  defaultContent = '<p>Welcome to the shared editor! Start typing here...</p>';

  modProtectPattern = [/<span[^>]*name="mod"[^>]*>[\s\S]*?<\/span>/gi];

  tinymceConfig: any = {
    valid_elements: '*[*]',
    extended_valid_elements: '*[id|class|name|pattern|src|href|data-*]',
    verify_html: false,
    xss_sanitization: false,
    forced_root_block: '',
    force_br_newlines: false,
    force_p_newlines: false,
    convert_urls: false,
    entity_encoding: 'raw',
    indent: false,
    custom_elements: 'span[class|id|style|data-*],container,block,~inline,mod',
    valid_children: '+body[mod]',
    content_style: 'body { margin: 0; } span.akn-mod { display: inline; }',
    height: 400,
    menubar: false,
    directionality: 'rtl',
    protect: this.modProtectPattern,
    setup: (editor: any) => {
      editor.on('init', () => {
        const doc = editor.getDoc();
        if (doc?.body) {
          doc.body.classList.add('printMode'); // ניתן להחליף ל־alwaysOn/onHover לפי מצב
        }
      });
    },
plugins: [
  'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview', 'anchor',
  'searchreplace', 'visualblocks', 'code', 'fullscreen',
  'insertdatetime', 'media', 'table', 'paste', 'help', 'wordcount'
]
,

  content_css: [
  'https://fonts.googleapis.com/icon?family=Material+Icons',
  '/assets/css/specific-editor-styles.css',
  '/assets/css/generic-editor-styles.css',
  '/assets/css/customized-editor-styles.css'
],

    toolbar:
      'undo redo | formatselect | bold italic backcolor | ' +
      'alignleft aligncenter alignright alignjustify | ' +
      'bullist numlist outdent indent | removeformat | help'
  };

  constructor() {}

  ngOnInit(): void {
    // הוספת ה-API key לתוך הקונפיגורציה
    this.tinymceConfig.apiKey = this.apiKey;
  }

  onConvertClicked() {
    // פעולה לדוגמה – בפועל אתה יכול להמיר את תוכן TinyMCE ל־XML
    this.convertedXmlContent = '<xml>תוכן מומרים</xml>';
  }

   onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (!input.files || input.files.length === 0) return;
    const xmlFile = input.files[0];
  }

  

}
