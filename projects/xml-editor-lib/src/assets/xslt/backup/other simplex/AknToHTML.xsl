<?xml version="1.0" encoding="UTF-8"?>
<!-- ==========================================================
File: AknToHTML.xsl
Autore: Fabio Vitali
Versione: 3.0
Data di ultima modifica: Aprile 2024
============================================================ -->
<xsl:stylesheet
  exclude-result-prefixes="xs akn h xsi"
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:akn="http://docs.oasis-open.org/legaldocml/ns/akn/3.0"
  xmlns:xml="http://www.w3.org/XML/1998/namespace"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  
  xmlns:ep="http://www.euparliament.eu/"
  xmlns:fmx="http://formex.publications.europa.eu/schema/formex-05.56-20160701.xd"
  xmlns:fmx1="http://publications.europa.eu/resource/distribution/formex/xsd/schema_formex/formex-06.00-20210715.xd"
  xmlns:akn4il="http://www.justice.gov.il/propetary.xsd"
  xmlns:AKN4IL="http://www.justice.gov.il/proprietary.xsd" 
  
  
  
  
>
  <xsl:param name="includeMeta">false</xsl:param>
  <xsl:param name="docPrefix"></xsl:param>
  <xsl:param name="collectFootnotes">true</xsl:param>
  <xsl:param name="defaultClasses"> none </xsl:param>
  <xsl:param name="text">chapter</xsl:param>
  
  <xsl:variable name="default">
    <xsl:if test="not(contains(//@class,'ignoreDefaultClasses'))">
      <xsl:value-of select="$defaultClasses"/>
    </xsl:if>
  </xsl:variable>
  
  <xsl:output omit-xml-declaration="yes" method="xml" encoding="UTF-8"  indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="h" result-prefix=""/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
      <xsl:apply-templates/>
  </xsl:template>

	<xsl:template match="*">
		<xsl:variable name="ln">
			<xsl:text> </xsl:text>
			<xsl:value-of select="local-name()"/>
			<xsl:text>,</xsl:text>
		</xsl:variable>

		<xsl:variable name="root">
         akomaNtoso, akomantoso,
		</xsl:variable>

		<xsl:variable name="doctype">
		 act, amendment, amendmentList, bill, debate,
		 debateReport, doc, documentCollection, judgment, officialGazette,
		 portion, statement,
		</xsl:variable>

		<xsl:variable name="documentContainers">
		 attachments, components, 
		</xsl:variable>

		<xsl:variable name="documentContainer">
		 attachment, component, 
		</xsl:variable>

	  <xsl:variable name="container">
		 address, adjournment, administrationOfOath, amendmentBody, amendmentContent,
		 amendmentHeading, amendmentJustification, amendmentReference,
		 answer, arguments, background, body,
		 citations, collectionBody, communication,
		 conclusions, container, court, coverPage, debateBody,
		 debateSection, decision, declarationOfVote, div, formula, header,
		 interstitial, intro, introduction, judgmentBody, longTitle,
		 mainBody, ministerialStatements, motivation, narrative,
		 nationalInterest, noticesOfMotion, oralStatements, other,
		 papers, personalStatements, petitions, pointOfOrder, portionBody, prayers,
		 preamble, preface, proceduralMotions, question, questions,
		 recitals, remedies, resolutions, rollCall, scene,
		 speech, speechGroup, summary, tocItem, wrapUp, 
		 writtenStatements, 
		</xsl:variable>

		<xsl:variable name="hcontainer">
		 alinea, annex, appendix, article, 
		 book, chapter, clause, division,
		 hcontainer, indent, level, list, mediaContainer,
		 noteSection, paragraph, part, point, proviso,
		 regulation, rule, schedule, section, subchapter,
		 subclause, subdivision, sublist, subparagraph, subpart,
		 subrule, subschedule, subsection, subtitle, title,
		 tome, transitional, blockList, 
		</xsl:variable>

		<xsl:variable name="block">
		 block, blockList, listIntroduction, listWrapUp, 
		 p, toc, crossHeading,
		</xsl:variable>

		<xsl:variable name="numberedBlock">
		 blockContainer, tblock,
		</xsl:variable>

	  <xsl:variable name="inline">
		 abbr, affectedDocument, argument,
		 change, concept, courtType, date, decoration,
		 def, defBody, docAuthority, docCommittee,
		 docDate, docIntroducer, docJurisdiction, docketNumber, docNumber,
		 docProponent, docPurpose, docStage, docStatus, docTitle,
		 docType, embeddedText, entity, event,
		 fillIn, from, inline,
		 judge, lawyer, legislature, location,
		 mmod, mod, mref, neutralCitation, object,
		 omissis, opinion, organization, outcome, party,
		 person, placeholder, process, quantity, quotedText,
		 recordedTime, relatedDocument, remark, rmod,
		 role, rref, session, shortTitle, signature,
		 term, time, tocHeading, tocNum, tocPointer, vote,
		</xsl:variable>
		<xsl:variable name="listItem">
		 citation, item, recital,
		</xsl:variable>

		<xsl:variable name="marker">
		 marker, noteRef,
		</xsl:variable>

		<xsl:variable name="link">
		 a, ref,
		</xsl:variable>



	  <xsl:variable name="lineBreak">
		 br, eol,
		</xsl:variable>

		<xsl:variable name="pageBreak">
		 eop,
		</xsl:variable>

		<xsl:variable name="subflow">
		 quotedStructure, subFlow, embeddedStructure, 
		</xsl:variable>

		<xsl:variable name="foreignText">
		 foreignText, 
		</xsl:variable>

	  <xsl:variable name="foreign">
		 foreign, 
		</xsl:variable>

		<xsl:variable name="authorialNote">
		 authorialNote,
		</xsl:variable>

		<xsl:variable name="special">
		 content, 
		 </xsl:variable>

		<xsl:variable name="references">
		 componentRef, documentRef,
		 </xsl:variable>

		<xsl:variable name="protectedhtml">
		 b, i, del, ins, span, sub, sup, u, img, 
		 </xsl:variable>

		<xsl:variable name="html">
		 ul, ol, li, table, tr, th, td, caption,
		 colgroup, col, thead, tbody, tfoot,  
		 </xsl:variable>

	  <xsl:variable name="meta">
	      meta,
		</xsl:variable>

		 <xsl:variable name="headings">
		 heading, subheading,
		 </xsl:variable>

	  <xsl:variable name="num">
		 num, 
		 </xsl:variable>

		<xsl:choose>
		<xsl:when test="contains($root,$ln)">
			<div class="simplex-canvas">
				<xsl:apply-templates />
			</div>
		</xsl:when>
		<xsl:when test="local-name()='img'">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">img</xsl:with-param>
				<xsl:with-param name="tag">img</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($doctype,$ln)">
			<xsl:call-template name="document">
				<xsl:with-param name="pattern">document</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($documentContainers,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">docContainers</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($documentContainer,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">docContainer</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($container,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">container</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($hcontainer,$ln)">
			<xsl:call-template name="hcontainer">
				<xsl:with-param name="pattern">hcontainer</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($numberedBlock,$ln)">
			<xsl:call-template name="hcontainer">
				<xsl:with-param name="pattern">block</xsl:with-param>
				<xsl:with-param name="tag">div</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($block,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">block</xsl:with-param>
				<xsl:with-param name="tag">div</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($listItem,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">listItem</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($inline,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">inline</xsl:with-param>
				<xsl:with-param name="tag">span</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($marker,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">marker</xsl:with-param>
				<xsl:with-param name="tag">span</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($link,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">inline</xsl:with-param>
				<xsl:with-param name="tag">a</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($lineBreak,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">lineBreak</xsl:with-param>
				<xsl:with-param name="tag">span</xsl:with-param>
			  <xsl:with-param name="special">addBRInside</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($pageBreak,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">lineBreak</xsl:with-param>
				<xsl:with-param name="tag">span</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($subflow,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">subflow</xsl:with-param>
				<xsl:with-param name="tag">div</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($foreign,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">foreign</xsl:with-param>
				<xsl:with-param name="tag">div</xsl:with-param>
				<xsl:with-param name="copy">true</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($foreignText,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">foreign</xsl:with-param>
				<xsl:with-param name="tag">span</xsl:with-param>
				<xsl:with-param name="copy">true</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($authorialNote,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">subflow</xsl:with-param>
				<xsl:with-param name="tag">a</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($special,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern"><xsl:value-of select="local-name()"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($references,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">references</xsl:with-param>
				<xsl:with-param name="tag">a</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($protectedhtml,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">inline</xsl:with-param>
				<xsl:with-param name="tag"><xsl:value-of select="local-name()"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		  <xsl:when test="contains($html,$ln)">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern"><xsl:value-of select="local-name()"/></xsl:with-param>
				<xsl:with-param name="tag"><xsl:value-of select="local-name()"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($headings,$ln)">
		</xsl:when>
		<xsl:when test="contains($num,$ln)"/>
	  
		<xsl:when test="contains($meta,$ln)">
			<xsl:call-template name="meta">
				<xsl:with-param name="pattern">metaContainer</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="element">
				<xsl:with-param name="pattern">unknown</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>

  </xsl:template>

	<xsl:template match="*" mode="outer">
			<xsl:call-template name="element">
				<xsl:with-param name="pattern"><xsl:value-of select="local-name()"/></xsl:with-param>
    	</xsl:call-template>
	</xsl:template>
	<xsl:template match="akn:num"/>

	<xsl:template match="*" mode="meta">
		<xsl:call-template name="meta">
			<xsl:with-param name="pattern">meta</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
 
  <!-- ======================================================== -->
  <!--                                                          -->
  <!--                   MAIN TEMPLATE                          -->
  <!--                                                          -->
  <!-- ======================================================== -->

 <xsl:template name="document">
    <xsl:param name="pattern"/>
    <xsl:param name="additionalContent"/>
    <xsl:param name="special"/>
      <xsl:if test="contains($special,'addBRBefore')">
        <br/>
      </xsl:if>
      <xsl:variable name="defaultClass">
        <xsl:call-template name="findClass">
          <xsl:with-param name="source" select="$default"/>
          <xsl:with-param name="find" select="local-name()"/>
        </xsl:call-template>
      </xsl:variable>
    <div>
      <xsl:if test="@eId">
        <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:value-of select="$defaultClass"/><xsl:text> </xsl:text>
        <xsl:value-of select="@class"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="$pattern"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="local-name()"/>
      </xsl:attribute>
      <xsl:attribute name="pattern"><xsl:value-of select="$pattern"/></xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="local-name()"/></xsl:attribute>
      <xsl:apply-templates select="@*"/>
	    <xsl:apply-templates select="*"/>
    </div>
    <xsl:if test="$collectFootnotes='true' and not(ancestor::akn:component)">   
         <div class="bottom-notes">
            <xsl:apply-templates select=".//akn:authorialNote" mode="destination" />
         </div>
    </xsl:if>  
 </xsl:template>

 <xsl:template name="hcontainer">
    <xsl:param name="pattern"/>
    <xsl:param name="additionalContent"/>
    <xsl:param name="special"/>

     <xsl:variable name="layout">
        <xsl:text>layout-</xsl:text>
        <xsl:if test="akn:num">n</xsl:if>
        <xsl:if test="akn:heading">h</xsl:if>
        <xsl:if test="akn:subheading">s</xsl:if>
        <xsl:text>c </xsl:text>
      </xsl:variable>
      <xsl:variable name="defaultClass">
        <xsl:call-template name="findClass">
          <xsl:with-param name="source" select="$default"/>
          <xsl:with-param name="find" select="local-name()"/>
        </xsl:call-template>
      </xsl:variable>

    <xsl:if test="contains($special,'addBRBefore')"><br/></xsl:if>
    <div>
      <xsl:if test="@eId">
        <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:value-of select="$layout"/><xsl:text> </xsl:text>
        <xsl:value-of select="$defaultClass"/><xsl:text> </xsl:text>
        <xsl:value-of select="@class"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="$pattern"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="local-name()"/>
      </xsl:attribute>
      <xsl:attribute name="pattern"><xsl:value-of select="$pattern"/></xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="local-name()"/></xsl:attribute>
      <xsl:apply-templates select="@*"/>

      <xsl:if test="contains($special,'addBRInside')"><span/><br/></xsl:if>
      <xsl:apply-templates select="akn:num | akn:heading | akn:subheading" mode="outer"/>
      <xsl:comment>hcontainer</xsl:comment>
	    <div class="wrapper" pattern="special">
	      <xsl:apply-templates/>
	    </div>
    </div>
    <xsl:if test="contains($special,'addBRAfter')"><br/></xsl:if>
  </xsl:template>

  <xsl:template name="element">
    <xsl:param name="pattern"/>
    <xsl:param name="tag">div</xsl:param>
    <xsl:param name="additionalContent"/>
    <xsl:param name="special"/>
    <xsl:param name="copy">false</xsl:param>

    <xsl:variable name="pos" select="position()"/>
    <xsl:variable name="layout">
        <xsl:if test="akn:num | akn:heading | akn:subheading">layout-</xsl:if>
        <xsl:if test="akn:num">n</xsl:if>
        <xsl:if test="akn:heading">h</xsl:if>
        <xsl:if test="akn:subheading">s</xsl:if>
    </xsl:variable>
    <xsl:variable name="defaultClass">
      <xsl:call-template name="findClass">
        <xsl:with-param name="source" select="$default"/>
        <xsl:with-param name="find" select="local-name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="contains($special,'addBRBefore')"><br/></xsl:if>
    <xsl:element name="{$tag}">
       <xsl:if test="@eId">
        <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:value-of select="$layout"/><xsl:text> </xsl:text>
        <xsl:value-of select="$defaultClass"/><xsl:text> </xsl:text>
        <xsl:value-of select="@class"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="$pattern"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="local-name()"/><xsl:text> </xsl:text>
        <xsl:value-of select="self::akn:td/ancestor::akn:table[1]/akn:col[$pos]/@class"/><xsl:text> </xsl:text>
        <xsl:value-of select="self::akn:th/ancestor::akn:table[1]/akn:col[$pos]/@class"/>
      </xsl:attribute>
      <xsl:attribute name="pattern"><xsl:value-of select="$pattern"/></xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="local-name()"/></xsl:attribute>
      <xsl:apply-templates select="@*"/>
      
      <xsl:if test="contains($special,'addBRInside')"><br/></xsl:if>
      <xsl:apply-templates select="akn:num | akn:heading | akn:subheading" mode="outer"/>
      <xsl:comment>element</xsl:comment>
      <xsl:choose>
        <xsl:when test="$copy='true'">
          <xsl:attribute name="data-ns"><xsl:value-of select="namespace-uri(*)"/></xsl:attribute>
          <xsl:copy-of select="*"/>
          <!-- xsl:copy-of select="*" copy-namespaces="false"/ -->
        </xsl:when>
        <xsl:otherwise>
           <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
    <xsl:if test="contains($special,'addBRAfter')"><br/></xsl:if>
  </xsl:template>

<xsl:template name="meta">
   <xsl:param name="pattern"/>
    <xsl:if test="$includeMeta='true'">
      <div>
      <xsl:if test="@eId">
        <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:value-of select="@class"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="$pattern"/><xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="local-name()"/>
      </xsl:attribute>
      <xsl:attribute name="pattern"><xsl:value-of select="$pattern"/></xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="local-name()"/></xsl:attribute>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates mode="meta"/>
    </div>
    </xsl:if>
</xsl:template>
  
   <xsl:template match="akn:documentRef | akn:componentRef">
     <a>
       <xsl:if test="@eId">
        <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:value-of select="@class"/>
        <xsl:text> </xsl:text>
        <xsl:text>akn-</xsl:text><xsl:value-of select="local-name()"/>
      </xsl:attribute>
      <xsl:attribute name="pattern">documentReference</xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="local-name()"/></xsl:attribute>
      <xsl:apply-templates select="@*"/>
       <xsl:text>&#x21D2;</xsl:text>
       <xsl:value-of select="@showAs"/>
    </a>
  </xsl:template>

<xsl:template name="marker">
  <xsl:if test="not(@marker)">000</xsl:if>
  <xsl:value-of select="@marker"/>
</xsl:template>

  <xsl:template match="akn:authorialNote">
     <a class="footnoteMarker">
       <xsl:apply-templates select="@*"/>
       <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/>marker-<xsl:value-of select="@eId | @GUID"/></xsl:attribute>
       <xsl:attribute name="href">#<xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId | @GUID"/></xsl:attribute>
       <xsl:call-template name="marker"/>
       
      </a>
    <xsl:if test="$collectFootnotes='false'">
     <div class="footnote">
       <xsl:apply-templates select="@*"/>
       <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId | @GUID"/></xsl:attribute>
       <xsl:apply-templates select="*"/>
     </div>     
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="akn:authorialNote" mode="destination">
     <div class="footnote">
       <xsl:apply-templates select="@*"/>
       <xsl:attribute name="id"><xsl:value-of select="$docPrefix"/><xsl:value-of select="@eId | @GUID"/></xsl:attribute>
        <xsl:apply-templates select="*"/>
     </div>
  </xsl:template>

  <xsl:template match="@refersTo" priority="10">
	  <xsl:variable name="location"><xsl:value-of select="substring(current(),2)"/></xsl:variable>
    <xsl:variable name="reference" select="//*[@eId=$location]"/>

	  <xsl:attribute name="data-refersTo">
	     <xsl:value-of select="."/>
	  </xsl:attribute>    
  
  <xsl:if test="$reference">
	  <xsl:attribute name="title">
	    <xsl:value-of select="$reference/@showAs"/>
	    <xsl:text> (</xsl:text>
	    <xsl:value-of select="$reference/@href"/>
	    <xsl:text>)</xsl:text>
	  </xsl:attribute>         
  </xsl:if>
	</xsl:template>  
	  
	<xsl:template match="@eId"/>

	<xsl:template match="@class | @akn:class" >
		<xsl:attribute name="data-class"><xsl:value-of select="."/></xsl:attribute>	  
	</xsl:template>

  <xsl:template match="@href | @akn:href">
		<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
  <xsl:template match="@src | @akn:src">
		<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	<xsl:template match="@title | @akn:title">
		<xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
  <xsl:template match="@alt | @akn:alt">
		<xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
  
  <xsl:template match="akn:td/@class | akn:th/@class">
    <xsl:variable name="pos" select="position()"/>
    <xsl:copy>
       <xsl:value-of select="."/>
       <xsl:value-of select="ancestor::akn:table/col[$pos]/@class"/>
    </xsl:copy>   
  </xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="data-{local-name()}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
  
  
  
  
<xsl:template name="findClass">
  <!-- 
    finds a list of class names inside parameter $source associated to 
    an element name $find, assuming the $source is shaped as follows:

    [chapter] pippo pluto.
    [article] paperino.

with the element name in square brackets and a dot at the end of the 
class list
  -->
  <xsl:param name="source"/>
  <xsl:param name="find"/>
   <xsl:variable name="search">
     <xsl:text>[</xsl:text>
		 <xsl:value-of select="$find"/>
     <xsl:text>]</xsl:text>
   </xsl:variable>
   <xsl:if test="contains($source,$search)">
     <xsl:value-of select="
       substring-before(substring-after($source,$search),'.')
     "/>
   </xsl:if>
</xsl:template>

<xsl:template match="akn:div[@class='figure']">
  <figure pattern="figure" name="figure">
    <xsl:apply-templates select="akn:p/akn:img"/>
    <figcaption>
      <xsl:apply-templates select="akn:div[@class='figcaption']"/>
    </figcaption>
  </figure>
</xsl:template>

<xsl:template match="akn:div[@class='figcaption']">
  <figcaption pattern="figcaption" name="figcaption">
    <xsl:value-of select="akn:p" />
  </figcaption>
</xsl:template>

</xsl:stylesheet>