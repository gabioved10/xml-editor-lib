import { Component, Input, OnInit } from '@angular/core';

declare const tinymce: any;

@Component({
  selector: 'lib-xml-editor-lib',
  templateUrl: './xml-editor-lib.component.html',
  styleUrls: ['./xml-editor-lib.component.scss']
})
export class XmlEditorLibComponent implements OnInit {

  @Input() showToolbar: boolean = true;
  @Input() showStatusBar: boolean = true;
  @Input() xmlContent: string = '';
  @Input() apiKey: string = '';
  @Input() xsltBasePath: string = 'assets/xslt';
  @Input() layoutStylesPath: string = 'assets/xslt/configuration/editor-config/layoutStyles.json';

  convertedXmlContent: string = '';
  defaultContent = '<p>Welcome to the shared editor! Start typing here...</p>';
  modProtectPattern = [/<span[^>]*name="mod"[^>]*>[\s\S]*?<\/span>/gi];
  rawXmlContent = '';
  generatedHtmlContent = '';
  editorHtmlContent = '';
  selectedMode: 'printMode' | 'alwaysOn' | 'onHover' | null = 'printMode';

  layoutStyles: { name: string; value: string }[] = [];


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
          doc.body.classList.add('printMode');
        }
      });
    },
    plugins: [
      'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview', 'anchor',
      'searchreplace', 'visualblocks', 'code', 'fullscreen',
      'insertdatetime', 'media', 'table', 'paste', 'help', 'wordcount'
    ],
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

  constructor() { }

  ngOnInit(): void {
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
    this.AknToHtml(xmlFile);
  }

  convertHtmlToXml(): void {
    const htmlContent = tinymce.activeEditor.getContent({ format: 'raw' });
    this.editorHtmlContent = this.formatHtml(htmlContent);
    this.HtmlToAkn(this.editorHtmlContent);
  }

  AknToHtml(xmlFile: File): void {
    const reader = new FileReader();
    reader.onload = async () => {
      const xmlText = reader.result as string;
      this.rawXmlContent = xmlText;

      const parser = new DOMParser();
      const xmlDoc = parser.parseFromString(xmlText, 'application/xml');

      try {
        const xslResponse = await fetch(`${this.xsltBasePath}/AknToHTML.xsl`);
        const xslText = await xslResponse.text();
        const xslDoc = parser.parseFromString(xslText, 'application/xml');

        const xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xslDoc);

        const additionalClasses = this.layoutStyles.map(i => `[${i.name}] ${i.value}.`).join("\n");
        xsltProcessor.setParameter(null, 'defaultClasses', additionalClasses || "");

        const resultDocument = xsltProcessor.transformToDocument(xmlDoc);
        let htmlContent = '';
        if (resultDocument.documentElement) {
          htmlContent = new XMLSerializer().serializeToString(resultDocument.documentElement);
        } else {
          htmlContent = new XMLSerializer().serializeToString(resultDocument);
        }

        this.generatedHtmlContent = htmlContent;
        tinymce.activeEditor.setContent(htmlContent, { format: 'raw' });
      } catch (err) {
        console.error('Error transforming XML:', err);
      }
    };

    reader.readAsText(xmlFile);
  }

  HtmlToAkn(htmlString: string): void {
    const parser = new DOMParser();
    const wrappedHtml = `<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /></head><body>${htmlString}</body></html>`;
    const htmlDoc = parser.parseFromString(wrappedHtml, 'application/xml');

    const parseError = htmlDoc.getElementsByTagName('parsererror');
    if (parseError.length > 0) {
      console.error('Error parsing HTML as XML:', parseError[0].textContent);
      this.convertedXmlContent = 'Error: HTML is not well-formed XML.';
      return;
    }

    fetch(`${this.xsltBasePath}/HTMLToAkn.xsl`)
      .then(res => res.text())
      .then(xslText => {
        const xslDoc = parser.parseFromString(xslText, 'application/xml');
        const xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xslDoc);

        const resultFragment = xsltProcessor.transformToFragment(htmlDoc, document);
        const xmlString = new XMLSerializer().serializeToString(resultFragment);
        this.convertedXmlContent = xmlString;
      })
      .catch(err => {
        console.error('Error transforming HTML to XML:', err);
        this.convertedXmlContent = `Error: ${err}`;
      });
  }

  formatHtml(html: string): string {
    return html
      .replace(/></g, '>\n<')
      .replace(/^\s+|\s+$/gm, '')
      .replace(/ {2,}/g, ' ')
      .replace(/>\s+</g, '>\n<');
  }


}
