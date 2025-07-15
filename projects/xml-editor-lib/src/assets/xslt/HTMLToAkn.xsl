<?xml version="1.0" encoding="UTF-8"?>
<!-- ==========================================================
File: HTMLToAkn.xsl
Autore: Fabio Vitali
Versione: 3.0
Data di ultima modifica: Maggio 2024
============================================================ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0"
  xmlns:akn="http://docs.oasis-open.org/legaldocml/ns/akn/3.0" exclude-result-prefixes="xs xsi h"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 

  version="1.0">
  <xsl:output method="xml" indent="yes" encoding="UTF-8" />
  <xsl:strip-space elements="*" />
  
<!-- ==========================================================

                        VARIABILI E PARAMETRI

============================================================ -->

  <xsl:variable name="defaultDate">1970-01-01</xsl:variable>
  <xsl:variable name="defaultHref">/akn/nosuchLink/</xsl:variable>
  <xsl:variable name="defaultRefers">/akn/ontology/concept/noConcept</xsl:variable>

  <xsl:variable name="dateElements">
    date, docDate, 
  </xsl:variable>
  <xsl:variable name="refersToElements">
    role, person, location, term, 
  </xsl:variable>
  <xsl:variable name="hrefElements">
    ref, 
  </xsl:variable>

<!-- ==========================================================

                        DOCUMENTI

============================================================ -->
  <xsl:template match="/">
    <akomaNtoso xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://docs.oasis-open.org/legaldocml/ns/akn/3.0 akomantoso30.xsd">
      <xsl:apply-templates />
     <xsl:call-template name="date" />
    </akomaNtoso>
  </xsl:template>

  <xsl:template match="html | body | title | head">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="h:div[@pattern = 'document']" priority="5">
    <xsl:element name="{./@name}">
      <xsl:apply-templates select="@*" />
      <xsl:call-template name="meta" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

 <xsl:template match="h:div[@pattern = 'document'][@ns]" priority="5">
    <xsl:element name="{./@name}" namespace="{./@ns}">
      <xsl:apply-templates select="@*" />
     <xsl:call-template name="meta" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

<!-- ==========================================================

                  ELEMENTI STRUTTURALI (DIV)

============================================================ -->
  
  <xsl:template match="h:div[contains(@class, 'simplex-canvas')]">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="h:div[contains(@class, 'wrapper')]">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="h:div[contains(@class, 'generated')]">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="h:div[contains(@class, 'pagebreakContainer')]"/>
  <xsl:template match="h:div[contains(@class, 'bottom-notes')]"/>
  <xsl:template match="h:div[contains(@class, 'ghosted')]"/>

  <xsl:template match="h:div[@name]">
    <xsl:element name="{./@name}">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="h:div[@name][@data-ns]" priority="5">
    <xsl:element name="{./@name}">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:copy-of select="*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="h:div">
    <xsl:element name="div">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>


<!-- ==========================================================

                   ELEMENTI INLINE (SPAN)

============================================================ -->

  <xsl:template match="h:span[contains(@class, 'generated')]">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="h:span[@name]">
    <xsl:element name="{./@name}">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

 <xsl:template match="h:span[@name][@data-ns]" priority="5">
    <xsl:element name="{./@name}">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:copy-of select="*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="h:span">
    <xsl:element name="span">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

<!-- ==========================================================

                        HTML

============================================================ -->

  <xsl:template match="h:a | h:i | h:b | h:sub | h:sup | h:ins | h:del | 
    h:u | h:ul | h:ol | h:li | h:img | h:table | h:thead | h:tbody | h:tfoot | 
    h:tr | h:td | h:th | h:caption | h:col | h:colspan">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>


<!-- ==========================================================

                        ELEMENTI SPECIALI

============================================================ -->

  <xsl:template match="h:a[contains(@name,'ref')]">
    <xsl:element name="{./@name}">
      <xsl:call-template name="date" />
      <xsl:call-template name="refersTo" />
      <xsl:call-template name="href" />
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="h:a[contains(@class,'footnoteMarker')]">
    <xsl:variable name="id" select="substring-after( @href,'#')"/>
    <authorialNote>
      <xsl:apply-templates select="//h:div[@id=$id]/@*"/>
      <xsl:apply-templates select="//h:div[@id=$id]/*"/>
    </authorialNote>
  </xsl:template>

  <xsl:template match="h:span[contains(@class,'removeAll')]" priority="5"/>

  <xsl:template match="h:a[@name = 'componentRef'] | h:a[@name = 'documentRef'] ">
    <xsl:element name="{@name}">
      <xsl:apply-templates select="@*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="h:br" />
  <xsl:template match="h:span[@name='br']" priority="5"><br/></xsl:template>

<!-- ==========================================================

                        ATTRIBUTI

============================================================ -->
  
  <xsl:template match="@id" priority="5">
    <xsl:attribute name="eId">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@pattern" priority="5">
    <xsl:if test='contains("document ", .) and @name!="portion"'>
      <xsl:attribute name="name">
        <xsl:value-of select="." />
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@name" priority="5">
    <xsl:if test='contains(" formula block container ", concat(" ",.," "))'>
      <xsl:attribute name="name">
        <xsl:value-of select="." />
      </xsl:attribute>
    </xsl:if>
  </xsl:template>
  <xsl:template match="@class" />

  <xsl:template match="@ns" />
  <xsl:template match="@data-ns" priority="5"/>


  <xsl:template match="@data-refersto"  priority="5">
    <xsl:attribute name="refersTo">
      <xsl:value-of select="."/>
    </xsl:attribute>    
  </xsl:template>
  
  <xsl:template match="@data-wid"  priority="5">
    <xsl:attribute name="wId">
      <xsl:value-of select="."/>
    </xsl:attribute>    
  </xsl:template>

  <xsl:template match="@data-showas"  priority="5">
    <xsl:attribute name="showAs">
      <xsl:value-of select="."/>
    </xsl:attribute>    
  </xsl:template>

  <xsl:template match="@data-includedin"  priority="5">
     <xsl:attribute name="includedIn">
      <xsl:value-of select="."/>
    </xsl:attribute>    
  </xsl:template>

  <xsl:template match="@data-height | @ghostedby | @ghostid | @data-mce-src | @data-mce-href | @data-mce-style" priority="5"/>

  <xsl:template match="@*">
    <xsl:choose>

     <!-- Escludi gli attributi che iniziano con "mod-" -->
     <xsl:when test="substring(local-name(), 1, 4) = 'mod-'"/>

      <xsl:when test="substring(local-name(), 1, 5) = 'data-'">
        <xsl:attribute name="{substring(local-name(),6)}">
          <xsl:value-of select="." />
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--  =========================================================
    
             TEMPLATE NOMINALI PER ATTRIBUTI SPECIFICI
    
      ========================================================= -->

 <xsl:template name="date">
    <xsl:variable name="name">
      <xsl:text> </xsl:text>
      <xsl:value-of select="./@name" />
      <xsl:text>,</xsl:text>
    </xsl:variable>

   <xsl:if test="contains($dateElements, $name)">
      <xsl:choose>
        <xsl:when test="@data-date">
          <xsl:attribute name="date">
            <xsl:value-of select="@data-date" />
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="date">
            <xsl:value-of select="$defaultDate" />
          </xsl:attribute>
          <xsl:attribute name="status">incomplete</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template name="refersTo">
    <xsl:variable name="name">
      <xsl:text> </xsl:text>
      <xsl:value-of select="./@name" />
      <xsl:text>,</xsl:text>
    </xsl:variable>

       <xsl:if test="contains($refersToElements, $name)">
<xsl:choose>
<xsl:when test="@data-refersTo | @data-refersto">
<xsl:attribute name="refersTo">
<xsl:value-of select="@data-refersTo | @data-refersto" />
</xsl:attribute>
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="refersTo">
<xsl:value-of select="$defaultRefers" />
</xsl:attribute>
<xsl:attribute name="status">incomplete</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>

  <xsl:template name="href">
    <xsl:variable name="name">
      <xsl:text> </xsl:text>
      <xsl:value-of select="./@name" />
      <xsl:text>,</xsl:text>
    </xsl:variable>

    <xsl:if test="contains($hrefElements, $name)">
      <xsl:choose>
        <xsl:when test="@href">
          <xsl:attribute name="href">
            <xsl:value-of select="@href" />
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="href">
            <xsl:value-of select="$defaultHref" />
          </xsl:attribute>
          <xsl:attribute name="status">incomplete</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

 <xsl:template name="meta">
   <xsl:if test="not(./akn:meta)">
   <meta>
       <identification source="" >
         <FRBRWork>
           <FRBRthis value=""/>
           <FRBRuri value=""/>
           <FRBRdate date="{$defaultDate}" name="generated"/>
           <FRBRauthor href=""/>
           <FRBRcountry value=""/>
         </FRBRWork>
         <FRBRExpression>
           <FRBRthis value=""/>
           <FRBRuri value=""/>
           <FRBRdate date="{$defaultDate}" name="generated"/>
           <FRBRauthor href=""/>
           <FRBRlanguage language=""/>
         </FRBRExpression>
         <FRBRManifestation>
           <FRBRthis value=""/>
           <FRBRuri value=""/>
           <FRBRdate date="{$defaultDate}" name="generated"/>
           <FRBRauthor href=""/>
         </FRBRManifestation>
       </identification>
     </meta>
     </xsl:if>
</xsl:template>

 <xsl:template match="akn:meta">
    <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h:figure">
  <div class="figure">
    <xsl:if test="@id">
      <xsl:attribute name="eid">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
    </xsl:if>
    <p>
      <xsl:apply-templates select="h:img"/>
    </p>
    <div class="figcaption">
      <xsl:if test="h:figcaption/@id">
        <xsl:attribute name="eid">
          <xsl:value-of select="h:figcaption/@id"/>
        </xsl:attribute>
      </xsl:if>
      <p>
        <xsl:apply-templates select="h:figcaption"/>
      </p>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>
