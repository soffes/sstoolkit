<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0" extension-element-prefixes="date">
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes" />
	
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html>
		<head>
			<meta charset="UTF-8" />
			<title><xsl:apply-templates select="object" mode="title"/></title>
			<meta id="Generator" name="Generator" content="Doxyclean"/>
			<meta id="GeneratorVersion" name="GeneratorVersion" content="2.2"/>
	
			<link rel="stylesheet" type="text/css" href="../css/common.css"/>
			<link rel="stylesheet" type="text/css" media="screen" href="../css/screen.css"/>
			<link rel="stylesheet" type="text/css" media="print" href="../css/print.css"/>
	
			<script type="text/javascript">
				function toggleTOC() {
					var toc = document.getElementById('tableOfContents');
					var tocButton = document.getElementById('toc_button');
					var contents = document.getElementById('contents');
					if (toc.style.display == 'block') {
						toc.style.display = 'none';
						contents.className = '';
						tocButton.className = '';
					} else {
						toc.style.display = 'block';
						contents.className = 'tableOfContentsOpen';
						tocButton.className = 'open';
					}
				}
				
				function toggleTOCItem() {
					var listItem = event.srcElement;
					var sublist = listItem.getElementsByTagName('ul')[0];
					if (sublist.style.display == 'block') {
						sublist.style.display = 'none';
						listItem.className = 'expandable';
					} else {
						sublist.style.display = 'block';
						listItem.className = 'expandable expanded';
					}
				}
				
				function jumpTo() {
					selectedItem = event.srcElement.options[event.srcElement.selectedIndex].value;
					window.location = "#" + selectedItem;
				}
			</script>
		</head>
		<body>
			<header id="projectHeader">
				<h1><a href="../index.html">##PROJECT## Reference Library</a></h1>
			</header>
			<header id="fileHeader">
				<h1><a href="#classTitle"><xsl:apply-templates select="object" mode="title"/></a></h1>
			</header>
			<nav id="buttons">
				<ul>
					<li id="toc_button"><button id="table_of_contents" onclick="toggleTOC()">Table of Contents</button></li>
					<li id="jumpto_button">
						<select id="jumpto" onchange="jumpTo()">
							<option value="classTitle">Jump To...</option>
							<xsl:apply-templates select="object/description" mode="jumpList"/>
							<xsl:apply-templates select="object/sections" mode="jumpList"/>
							<xsl:call-template name="jumpProperties"/>
							<xsl:call-template name="jumpClassMethods"/>
							<xsl:call-template name="jumpInstanceMethods"/>
						</select>
					</li>
				</ul>
			</nav>	

			<nav id="tableOfContents" style="display: none;">
				<ul>
					<xsl:apply-templates select="object/description" mode="toc"/>
					<xsl:apply-templates select="object/sections" mode="toc"/>
					<xsl:call-template name="TOCproperties"/>
					<xsl:call-template name="TOCclassMethods"/>
					<xsl:call-template name="TOCinstanceMethods"/>
				</ul>
			</nav>
			
			<div id="contents">
				<h1 id="classTitle"><xsl:apply-templates select="object" mode="title"/></h1>
				
				<!-- Info Table -->
				<table id="metadata">
					
					<xsl:variable name="hasInheritance">
						<xsl:choose>
							<xsl:when test="object/superclass[child::text()[normalize-space(.)] | child::*]">
								<xsl:value-of select="true()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="false()"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					
					<xsl:variable name="hasProtocolConformance">
						<xsl:choose>
							<xsl:when test="object/conformsTo/protocol or object/superclass/conformsTo/protocol">
								<xsl:value-of select="true()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="false()"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					
					<xsl:if test="$hasInheritance='true'">
						<tr class="alt">
							<th>Inherits from</th>
							<td>
								<ul class="inheritance">
									<xsl:apply-templates select="object/superclass[child::text()[normalize-space(.)] | child::*]"/>
								</ul>
							</td>
						</tr>
					</xsl:if>
					
					<xsl:if test="$hasProtocolConformance='true'">
						<tr>
							<xsl:if test="not($hasInheritance='true')">
								<xsl:attribute name="class">alt</xsl:attribute>
							</xsl:if>
							<th>Conforms to</th>
							<td>
								<ul>
									<xsl:apply-templates select="object/conformsTo/protocol"/>
									<xsl:apply-templates select="object/superclass[child::text()[normalize-space(.)] | child::*]" mode="protocols"/>
								</ul>
							</td>
						</tr>
					</xsl:if>
					
					<tr>
						<xsl:if test="($hasInheritance='true' and $hasProtocolConformance='true') or ($hasInheritance='false' and $hasProtocolConformance='false')">
							<xsl:attribute name="class">alt</xsl:attribute>
						</xsl:if>
						<th>Declared in</th>
						<td><xsl:apply-templates select="object/file"/></td>
					</tr>
				</table>
				<!-- End Info Table -->
				
				<xsl:apply-templates select="object/description"/>
				
				<xsl:apply-templates select="object/sections"/>
				
				<xsl:call-template name="properties"/>
				<xsl:call-template name="classMethods"/>
				<xsl:call-template name="instanceMethods"/>
				
				<hr/>
				<p id="lastUpdated">Last updated: <xsl:value-of select="date:year()"/>-<xsl:value-of select="date:month-in-year()"/>-<xsl:value-of select="date:day-in-month()"/></p>		
			</div>
			
			<footer id="breadcrumbs">
				<ul>
					<li><a href="../index.html">##PROJECT##</a></li>
					<li><a href="#classTitle"><xsl:apply-templates select="object" mode="title"/></a></li>
				</ul>
			</footer>
	
		</body>
		</html>
	</xsl:template>
	
	<!-- Jump To... List -->
	<xsl:template match="object/description" mode="jumpList">
		<xsl:if test="brief or details">
			<option value="overview">Overview</option>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="object/sections" mode="jumpList">
		<xsl:if test="count(section) > 0">
			<option value="tasks">Tasks</option>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="jumpProperties">
		<xsl:if test="count(object/sections/section/member[@kind='property']) > 0">
			<option value="properties">Properties</option>
			<xsl:apply-templates select="object/sections/section/member[@kind='property']" mode="jumpList"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="jumpClassMethods">
		<xsl:if test="count(object/sections/section/member[@kind='class-method']) > 0">
			<option value="classMethods">Class Methods</option>
			<xsl:apply-templates select="object/sections/section/member[@kind='class-method']" mode="jumpList"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="jumpInstanceMethods">
		<xsl:if test="count(object/sections/section/member[@kind='instance-method']) > 0">
			<option value="instanceMethods">Instance Methods</option>
			<xsl:apply-templates select="object/sections/section/member[@kind='instance-method']" mode="jumpList"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="member" mode="jumpList">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
			<xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
			<xsl:choose>
				<xsl:when test="@kind='class-method'">+ </xsl:when>
				<xsl:when test="@kind='instance-method'">- </xsl:when>
			</xsl:choose>
			<xsl:value-of select="name"/>
		</option>
	</xsl:template>
	
	<!-- Table of Contents -->
	<xsl:template match="object/description" mode="toc">
		<xsl:if test="brief or details">
			<li><a href="#overview">Overview</a></li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="object/sections" mode="toc">
		<xsl:if test="count(section) > 0">
			<li class="expandable" id="tocTasks" onclick="toggleTOCItem()">
				<a href="#tasks">Tasks</a>
				<ul style="display: none;">
					<xsl:apply-templates select="section" mode="toc"/>
				</ul>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="object/sections/section" mode="toc">
		<li>
			<a>
				<xsl:attribute name="href">#<xsl:value-of select="translate(normalize-space(name), ' ', '_')"/></xsl:attribute>
				<xsl:apply-templates select="name"/>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template name="TOCproperties">
		<xsl:if test="count(object/sections/section/member[@kind='property']) > 0">
			<li class="expandable" id="tocProperties" onclick="toggleTOCItem()">
				<a href="#properties">Properties</a>
				<ul style="display: none;">
					<xsl:apply-templates select="object/sections/section/member[@kind='property']" mode="toc"/>
				</ul>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="TOCclassMethods">
		<xsl:if test="count(object/sections/section/member[@kind='class-method']) > 0">
			<li class="expandable" id="tocClassMethods" onclick="toggleTOCItem()">
				<a href="#classMethods">Class Methods</a>
				<ul style="display: none;">
					<xsl:apply-templates select="object/sections/section/member[@kind='class-method']" mode="toc"/>
				</ul>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="TOCinstanceMethods">
		<xsl:if test="count(object/sections/section/member[@kind='instance-method']) > 0">
			<li class="expandable" id="tocInstanceMethods" onclick="toggleTOCItem()">
				<a href="#instanceMethods">Instance Methods</a>
				<ul style="display: none;">
					<xsl:apply-templates select="object/sections/section/member[@kind='instance-method']" mode="toc"/>
				</ul>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="member" mode="toc">
		<li>
			<a>
				<xsl:attribute name="href">#<xsl:value-of select="name"/></xsl:attribute>
				<xsl:apply-templates select="name"/>
			</a>
		</li>
	</xsl:template>

	<!-- Object Attributes -->
	
	<xsl:template match="object" mode="title">
		<xsl:apply-templates select="name"/>
		<xsl:choose>
			<xsl:when test="@kind='class'"><xsl:text> Class</xsl:text></xsl:when>
			<xsl:when test="@kind='category'"><xsl:text> Category</xsl:text></xsl:when>
			<xsl:when test="@kind='protocol'"><xsl:text> Protocol</xsl:text></xsl:when>
		</xsl:choose>
		<xsl:text> Reference</xsl:text>
	</xsl:template>
	
	<!-- Inheritance Tree -->
	<xsl:template match="superclass">
		<li><xsl:apply-templates select="name"/></li>
	</xsl:template>
	
	<!-- Protocol Conformance -->
	<xsl:template match="conformsTo/protocol">
		<xsl:param name="class"/>
		<li>
			<xsl:apply-templates select="name"/>
			<xsl:if test="$class">
				<xsl:text> (</xsl:text><xsl:value-of select="$class"/><xsl:text>)</xsl:text>
			</xsl:if>
		</li>
	</xsl:template>
	
	<xsl:template match="superclass" mode="protocols">
		<xsl:apply-templates select="conformsTo/protocol">
			<xsl:with-param name="class" select="name"/>
		</xsl:apply-templates>
		
		<xsl:apply-templates select="superclass" mode="protocols"/>
	</xsl:template>
	
	<!-- Overview -->
	<xsl:template match="object/description">
		<xsl:if test="brief or details">
			<h2 id="overview">Overview</h2>
			<xsl:apply-templates select="brief"/>
			<xsl:apply-templates select="details"/>
		</xsl:if>
	</xsl:template>
	
	<!-- Sections -->
	<xsl:template match="sections">
		<xsl:if test="count(section) > 0">
			<h2 id="tasks">Tasks</h2>
			<ul id="tasksList">
				<xsl:apply-templates selection="section"/>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="section">
		<xsl:if test="count(member) > 0">
			<li>
				<xsl:attribute name="id">
					<xsl:value-of select="translate(normalize-space(name), ' ', '_')"/>
				</xsl:attribute>
				<h3><xsl:apply-templates select="name"/></h3>
				<ul class="methods">
					<xsl:apply-templates select="member" mode="index"/>
				</ul>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="member" mode="index">
		<li>
			<span class="tooltipRegion">
				<code>
					<a>
						<xsl:attribute name="href">#<xsl:value-of select="name"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="@kind='class-method'">+ </xsl:when>
							<xsl:when test="@kind='instance-method'">- </xsl:when>
						</xsl:choose>
						<xsl:apply-templates select="name"/>
					</a>
				</code>
			
				<xsl:choose>
					<xsl:when test="@kind='property'">
						<xsl:text> </xsl:text><span class="specialType">property</span>
					</xsl:when>
					<xsl:when test="@optional='no'">
						<xsl:text> </xsl:text><span class="specialType">required</span>
					</xsl:when>
				</xsl:choose>
			</span>
			<span class="tooltip"><xsl:value-of select="description/brief"/></span>
		</li>
	</xsl:template>
	
	<!-- Definition Sections -->
	<xsl:template name="properties">
		<xsl:if test="count(object/sections/section/member[@kind='property']) > 0">
			<section id="properties">
				<h2>Properties</h2>
				<xsl:apply-templates select="object/sections/section/member[@kind='property']" mode="details"/>
			</section>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="classMethods">
		<xsl:if test="count(object/sections/section/member[@kind='class-method']) > 0">
			<section id="classMethods">
				<h2>Class Methods</h2>
				<xsl:apply-templates select="object/sections/section/member[@kind='class-method']" mode="details"/>
			</section>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="instanceMethods">
		<xsl:if test="count(object/sections/section/member[@kind='instance-method']) > 0">
			<section id="instanceMethods">
				<h2>Instance Methods</h2>
				<xsl:apply-templates select="object/sections/section/member[@kind='instance-method']" mode="details"/>
			</section>
		</xsl:if>
	</xsl:template>
	
	<!-- Method/Property Documentation -->
	<xsl:template match="member" mode="details">
		<section class="definition">
			<xsl:attribute name="id"><xsl:value-of select="name"/></xsl:attribute>
			<h3><xsl:value-of select="name"/></h3>
			
			<xsl:apply-templates select="description/brief"/>
			
			<code class="methodDeclaration">
				<xsl:apply-templates select="prototype"/>
			</code>
			
			<xsl:apply-templates select="parameters"/>
			<xsl:apply-templates select="return"/>
			<xsl:apply-templates select="description/details"/>
			<xsl:apply-templates select="warning"/>
			<xsl:apply-templates select="bug"/>
			<xsl:apply-templates select="seeAlso"/>
			<xsl:apply-templates select="file"/>
			
		</section>
	</xsl:template>
	
	<xsl:template match="prototype">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="prototype/parameter">
		<span class="parameter">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<!-- Don't put the <code> tag for links inside a prototype -->
	<xsl:template match="prototype//ref">
		<xsl:choose>
			<xsl:when test="/object/name != child::node()[1]">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="@id"/>.html</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="parameters">
		<h5>Parameters</h5>
		<dl class="parameterList">
			<xsl:apply-templates/>
		</dl>
	</xsl:template>
	
	<xsl:template match="param">
		<dt>
			<xsl:apply-templates select="name"/>
		</dt>
		<dd>
			<xsl:apply-templates select="description"/>
		</dd>
	</xsl:template>
	
	<xsl:template match="return">
		<h5>Return Value</h5>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="member/description/details">
		<xsl:if test="para[1]/. != ''">
			<h5>Discussion</h5>
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="member/warning">
		<h5>Warning</h5>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="member/bug">
		<h5>Bug</h5>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="seeAlso">
		<h5>See Also</h5>
		<ul class="seeAlso">
			<xsl:apply-templates select="item"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="seeAlso/item">
		<li>
			<code>
				<a>
					<xsl:attribute name="href">#<xsl:value-of select="normalize-space(translate(.,'-+',''))"/></xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</code>
		</li>
	</xsl:template>
	
	<xsl:template match="member/file">
		<h5>Declared In</h5>
		<code><xsl:apply-templates/></code>
	</xsl:template>
	
	<!-- General Tags -->
	
	<xsl:template match="para">
		<p><xsl:apply-templates/></p>
	</xsl:template>
	
	<xsl:template match="code">
		<code><xsl:apply-templates/></code>
	</xsl:template>
	
	<xsl:template match="list">
		<ul>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="list/item">
		<li><xsl:apply-templates/></li>
	</xsl:template>
	
	<xsl:template match="ref">
		<code>
			<xsl:choose>
				<xsl:when test="/object/name != child::node()[1]">
					<a>
						<xsl:attribute name="href"><xsl:value-of select="@id"/>.html</xsl:attribute>
						<xsl:apply-templates/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</code>
	</xsl:template>

	<!-- Block for a codeblock -->
	<xsl:template match="codeblock">
	  <code>
		<pre>
	    	<xsl:apply-templates />
		</pre>
	  </code>
	</xsl:template>
	
	<!-- Don't put the <code> tag for links inside a codeblock -->
	<xsl:template match="codeblock//ref">
		<xsl:choose>
			<xsl:when test="/object/name != child::node()[1]">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="@id"/>.html</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
