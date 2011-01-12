<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="no"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
		<xsl:apply-templates select="doxygen/compounddef"/>
	</xsl:template>
	
	<!-- Formatters -->
	<xsl:template name="filename">
		<xsl:param name="path"/>
		<xsl:choose>
			<xsl:when test="contains($path,'/')">
				<xsl:call-template name="filename">
					<xsl:with-param name="path" select="substring-after($path,'/')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$path"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="prototype">
		<xsl:choose>
			<xsl:when test="@kind='property'">@property <xsl:apply-templates select="type"/>
				<xsl:choose>
					<xsl:when test="substring(type, string-length(type)-1, 2)=' *'"></xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>	
				<xsl:value-of select="name"/>
			</xsl:when>
			<xsl:when test="@kind='function'">
				<xsl:choose>
					<xsl:when test="@static='no'">- </xsl:when>
					<xsl:when test="@static='yes'">+ </xsl:when>
				</xsl:choose>(<xsl:apply-templates select="type"/>)<xsl:call-template name="prototypeWithArguments">
					<xsl:with-param name="string" select="name"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="prototypeWithArguments">
		<xsl:param name="string"/>
		<xsl:choose>
			<xsl:when test="contains($string,':')">
				<xsl:value-of select="substring($string,0,string-length(substring-before($string,':'))+2)"/>
				<xsl:variable name="attribute">
					<xsl:text>[</xsl:text><xsl:value-of select="substring-before($string,':')"/><xsl:text>]</xsl:text>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="param[attributes=$attribute]">(<xsl:apply-templates select="param[attributes=$attribute]/type"/>)<parameter><xsl:value-of select="param[attributes=$attribute]/declname"/></parameter>
					</xsl:when>
					<xsl:otherwise>(<xsl:apply-templates select="param[1]/type"/>)<parameter><xsl:value-of select="param[1]/declname"/></parameter>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> </xsl:text>
				<xsl:call-template name="prototypeWithArguments">
					<xsl:with-param name="string" select="substring-after($string,':')"/>
				</xsl:call-template>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="type">
		<!-- Remove the spaces from the protocol declarations on data types -->
		<xsl:variable name="leftProtocolSpaceRemoved">
			<xsl:call-template name="replace-string"> <!-- imported template -->
			    <xsl:with-param name="text" select="."/>
				<xsl:with-param name="replace" select="'&lt; '"/>
	        	<xsl:with-param name="with" select="'&lt;'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="replace-string"> <!-- imported template -->
		    <xsl:with-param name="text" select="$leftProtocolSpaceRemoved"/>
			<xsl:with-param name="replace" select="' &gt;'"/>
        	<xsl:with-param name="with" select="'&gt;'"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- General String Replacement -->
	<xsl:template name="replace-string">
	    <xsl:param name="text"/>
	    <xsl:param name="replace"/>
	    <xsl:param name="with"/>
	    <xsl:choose>
	      <xsl:when test="contains($text,$replace)">
	        <xsl:value-of select="substring-before($text,$replace)"/>
	        <xsl:value-of select="$with"/>
	        <xsl:call-template name="replace-string">
	          <xsl:with-param name="text"
	select="substring-after($text,$replace)"/>
	          <xsl:with-param name="replace" select="$replace"/>
	          <xsl:with-param name="with" select="$with"/>
	        </xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:value-of select="$text"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:template>
	
	
	
	<!-- Basic Tags -->
	<xsl:template match="ref">		
		<ref>
	      <xsl:apply-templates/>
	    </ref>
	</xsl:template>
	
	<xsl:template match="para">
		<para><xsl:apply-templates/></para>
	</xsl:template>
	
	<xsl:template match="computeroutput">
		<code><xsl:apply-templates/></code>
	</xsl:template>
	
	<xsl:template match="itemizedlist">
		<list>
			<xsl:apply-templates/>
		</list>
	</xsl:template>
	<xsl:template match="listitem">
		<item>
			<xsl:apply-templates/>
		</item>
	</xsl:template>
	
	<!-- Formatting -->
	
	<xsl:template match="compounddef">
		<object>
			<xsl:attribute name="kind"><xsl:value-of select="@kind"/></xsl:attribute>
			<name>
				<xsl:apply-templates select="compoundname"/>
			</name>
			<file>
				<xsl:call-template name="filename">
					<xsl:with-param name="path" select="location/@file"/>
				</xsl:call-template>
			</file>
			
			<xsl:apply-templates select="inheritancegraph/node[label=/doxygen/compounddef/compoundname]"/>
			
			<xsl:apply-templates select="detaileddescription/para/simplesect[@kind='author']/para"/>
			
			<xsl:if test="briefdescription[para] or detaileddescription[para]">
				<description>
					<xsl:apply-templates select="briefdescription"/>
					<xsl:apply-templates select="detaileddescription"/>
				</description>
				<xsl:apply-templates select="detaileddescription/para" mode="seeAlso"/>
			</xsl:if>
			<sections>
				<xsl:apply-templates select="sectiondef"/>
			</sections>
		</object>
	</xsl:template>
	
	<xsl:template match="compoundname">
		<!-- Fix protocol names: They have a dangling -p at the end of the name -->
		<xsl:choose>
			<xsl:when test="../@kind='protocol'">
				<xsl:value-of select="substring(.,0,string-length(.)-1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="briefdescription">
		<brief><xsl:apply-templates/></brief>
	</xsl:template>
	
	<xsl:template match="detaileddescription">
		<details><xsl:apply-templates/></details>
	</xsl:template>
	<xsl:template match="detaileddescription/para/simplesect">
	</xsl:template>
	<xsl:template match="detaileddescription/para/parameterlist">
	</xsl:template>
	<xsl:template match="detaileddescription/para/xrefsect">
	</xsl:template>
	
	<xsl:template match="simplesect[@kind='author']/para">
		<author><xsl:apply-templates/></author>
	</xsl:template>
	
	<xsl:template match="sectiondef">
		<xsl:apply-templates select="@kind='user-defined'"/>
		<xsl:apply-templates select="@kind!='user-defined'"/>
	</xsl:template>
	
	<xsl:template match="sectiondef[@kind='user-defined']">
		<section>
			<name><xsl:apply-templates select="header"/></name>
			<xsl:apply-templates select="memberdef[briefdescription/para or detaileddescription/para]"/>
		</section>
	</xsl:template>
	
	<xsl:template match="sectiondef[@kind!='user-defined']">
		<xsl:if test="count(memberdef[@kind!='variable' and (briefdescription/para or detaileddescription/para)]) > 0">
			<section>
				<name>Other</name>
				<xsl:apply-templates select="memberdef[@kind!='variable' and (briefdescription/para or detaileddescription/para)]"/>
			</section>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="memberdef">
		<member>
			<xsl:choose>
				<xsl:when test="@kind='function' and @static='yes' and @const='no'">
					<xsl:attribute name="kind">class-method</xsl:attribute>
				</xsl:when>
				<xsl:when test="@kind='function' and @static='no' and @const='no'">
					<xsl:attribute name="kind">instance-method</xsl:attribute>
				</xsl:when>
				<xsl:when test="@kind='property'">
					<xsl:attribute name="kind">property</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="../../@kind='protocol'">			
				<xsl:choose>
					<xsl:when test="@optional='yes'">
						<xsl:attribute name="optional">yes</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="optional">no</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<name><xsl:apply-templates select="name"/></name>
			<type><xsl:apply-templates select="type"/></type>
			<prototype><xsl:call-template name="prototype"/></prototype>
			<file>
				<xsl:call-template name="filename">
					<xsl:with-param name="path" select="location/@file"/>
				</xsl:call-template>
			</file>
			<description>
				<xsl:apply-templates select="briefdescription"/>
				<xsl:apply-templates select="detaileddescription"/>
			</description>
			<xsl:apply-templates select="detaileddescription/para/simplesect[@kind='warning']" mode="warning"/>
			<xsl:apply-templates select="detaileddescription/para/xrefsect" mode="bug"/>
			<xsl:apply-templates select="detaileddescription/para/parameterlist" mode="parameters"/>
			<xsl:apply-templates select="detaileddescription/para" mode="return"/>
			<xsl:apply-templates select="detaileddescription/para" mode="seeAlso"/>
		</member>
	</xsl:template>
	
	<xsl:template match="detaileddescription/para/parameterlist" mode="parameters">
		<parameters>
			<xsl:apply-templates/>
		</parameters>
	</xsl:template>
	<xsl:template match="parameteritem">
		<param>
			<name>
				<xsl:apply-templates select="parameternamelist"/>
			</name>
			<description>
				<xsl:apply-templates select="parameterdescription"/>
			</description>
		</param>
	</xsl:template>
	
	<xsl:template match="detaileddescription/para" mode="seeAlso">
		<xsl:if test="simplesect[@kind='see']">
			<seeAlso>
				<xsl:apply-templates select="simplesect[@kind='see']/para"/>
			</seeAlso>
		</xsl:if>
	</xsl:template>
	<xsl:template match="simplesect[@kind='see']/para">
		<item><xsl:apply-templates/></item>
	</xsl:template>
	
	<xsl:template match="detaileddescription/para" mode="return">
		<xsl:if test="simplesect[@kind='return']">
			<return>
				<xsl:apply-templates select="simplesect[@kind='return']/para"/>
			</return>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="detaileddescription/para/simplesect[@kind='warning']" mode="warning">
		<warning>
			<xsl:apply-templates/>
		</warning>
	</xsl:template>
	
	<xsl:template match="detaileddescription/para/xrefsect" mode="bug">
		<bug>
			<xsl:apply-templates select="xrefdescription"/>
		</bug>
	</xsl:template>
	<xsl:template match="xrefdescription">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="inheritancegraph/node" mode="superclass">
		<name><xsl:apply-templates select="label"/></name>
		
		<superclass>
			<xsl:apply-templates select="childnode" mode="superclass"/>
		</superclass>
		
		<conformsTo>
			<xsl:apply-templates select="childnode" mode="protocols"/>
		</conformsTo>
	</xsl:template>
	
	<xsl:template match="inheritancegraph/node" mode="protocol">
		<name>
			<xsl:variable name="nameWithLeftBracketRemoved">
				<xsl:call-template name="replace-string"> <!-- imported template -->
				    <xsl:with-param name="text" select="label"/>
					<xsl:with-param name="replace" select="'&lt;'"/>
		        	<xsl:with-param name="with" select="''"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:call-template name="replace-string"> <!-- imported template -->
			    <xsl:with-param name="text" select="$nameWithLeftBracketRemoved"/>
				<xsl:with-param name="replace" select="'&gt;'"/>
	        	<xsl:with-param name="with" select="''"/>
			</xsl:call-template>
		</name>
		
		<conformsTo>
			<xsl:apply-templates select="childnode" mode="protocols"/>
		</conformsTo>
	</xsl:template>
	
	<xsl:template match="inheritancegraph/node[label=/doxygen/compounddef/compoundname]">
		<superclass>
			<xsl:apply-templates select="childnode" mode="superclass"/>
		</superclass>
		
		<conformsTo>
			<xsl:apply-templates select="childnode" mode="protocols"/>
		</conformsTo>
	</xsl:template>
	
	<xsl:template match="inheritancegraph/node/childnode" mode="superclass">
		<xsl:variable name="nodeID">
			<xsl:value-of select="@refid"/>
		</xsl:variable>
		
		<xsl:if test="not(starts-with(../../node[@id=$nodeID]/label, '&lt;'))">
			<xsl:apply-templates select="../../node[@id=$nodeID]" mode="superclass"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="inheritancegraph/node/childnode" mode="protocols">
		<xsl:variable name="nodeID">
			<xsl:value-of select="@refid"/>
		</xsl:variable>
		
		<xsl:if test="starts-with(../../node[@id=$nodeID]/label, '&lt;')">
			<protocol>
				<xsl:apply-templates select="../../node[@id=$nodeID]" mode="protocol"/>
			</protocol>
		</xsl:if>
	</xsl:template>

	<!-- Copy most of programlisting through -->
	<xsl:template match="programlisting">
	  <codeblock>
	    <xsl:apply-templates />
	  </codeblock>
	</xsl:template>
	
	<xsl:template match="programlisting/codeline">
		<xsl:apply-templates /><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="programlisting//sp">
		<xsl:text> </xsl:text>
	</xsl:template>

	<!-- Copy through other children of programlisting -->
	<xsl:template match="programlisting//*">
	    <xsl:apply-templates />
	</xsl:template>
	
</xsl:stylesheet>
