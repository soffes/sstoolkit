<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes" />
	
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html>
		<head>
			<meta charset="UTF-8" />
			<title><xsl:apply-templates select="project" mode="title"/></title>
			
			<meta id="Generator" name="Generator" content="Doxyclean"/>
			<meta id="GeneratorVersion" name="GeneratorVersion" content="2.2"/>
			
			<link rel="stylesheet" type="text/css" href="css/common.css"/>
			<link rel="stylesheet" type="text/css" media="screen" href="css/screen.css"/>
			<link rel="stylesheet" type="text/css" media="print" href="css/print.css"/>
		</head>
		<body>
			<div id="indexContainer">
				<h1><xsl:apply-templates select="project" mode="title"/></h1>
				
				<xsl:if test="count(project/object[@kind='class']) > 0">
					<div class="column">
						<h5>Class References</h5>
						<ul>
							<xsl:apply-templates select="project/object[@kind='class']"/>
						</ul>
					</div>
				</xsl:if>
				
				<div class="column">
					<xsl:if test="count(project/object[@kind='protocol']) > 0">
						<h5>Protocol References</h5>
						<ul>
							<xsl:apply-templates select="project/object[@kind='protocol']"/>
						</ul>
					</xsl:if>
						
					<xsl:if test="count(project/object[@kind='category']) > 0">
						<h5>Category References</h5>
						<ul>
							<xsl:apply-templates select="project/object[@kind='category']"/>
						</ul>
					</xsl:if>
				</div>
				
			</div>
		</body>
		</html>
	</xsl:template>
	
	<xsl:template match="project" mode="title">
		<xsl:if test="@name">
			<xsl:value-of select="@name"/> 
		</xsl:if>
		Project Reference
	</xsl:template>
	
	<xsl:template match="object">
		<li>
			<a>
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="@kind='class'">Classes/</xsl:when>
						<xsl:when test="@kind='category'">Categories/</xsl:when>
						<xsl:when test="@kind='protocol'">Protocols/</xsl:when>
					</xsl:choose>
					<xsl:value-of select="normalize-space(name)"/>.html</xsl:attribute><xsl:value-of select="normalize-space(name)"/>
			</a>
		</li>
	</xsl:template>
	
</xsl:stylesheet>