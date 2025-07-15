/**
     * Convert the HTML source to Akn XML
     *
     * @param htmlSource
     */
HTMLToAkn(htmlSource: string, metadataService ?: MetadataService): Observable < string > {
    let url = './assets/xslFiles/HTMLToAkn.xsl';
    return this.httpClient.get(url, { responseType: 'text' }).pipe(
        map(xslt => {
            let layoutStyles = this.configurationParserService.editorConfig.layoutStyles;

            // parsing the string to html and get the metadata in string format
            // get the <div class="document ..."> element from the body
            let htmlSourceHtml = new DOMParser().parseFromString(htmlSource, 'text/html');
            let documentBodyHtml = htmlSourceHtml.querySelector('*[pattern="document"]');

            let xmlMeta = metadataService?.getMetadataInXml() ?? this.metadataService.getMetadataInXml()
            let xml = new XMLSerializer()
            let meta = xmlMeta.querySelector('meta')
            documentBodyHtml.prepend(meta)
            let source = xml.serializeToString(documentBodyHtml)
            let converted = this.xsltConvert(source, xslt, 'text/xml', { layoutStyles: layoutStyles })
            let pos = xmlMeta.querySelector('meta')
            return beautify(converted)
        })
    );
}