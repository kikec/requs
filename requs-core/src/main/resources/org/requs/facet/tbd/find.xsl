<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:digest="org.apache.commons.codec.digest.DigestUtils"
    xmlns:r="http://www.requs.org/" version="2.0"
    exclude-result-prefixes="xs r digest">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*" />
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-stylesheet">
            <xsl:text>href="tbds.xsl" type="text/xsl"</xsl:text>
        </xsl:processing-instruction>
        <tbds>
            <xsl:apply-templates select="spec/methods"/>
        </tbds>
    </xsl:template>
    <xsl:template match="methods">
        <xsl:for-each select="method[info/informal]">
            <tbd>
                <xsl:attribute name="id">
                    <xsl:value-of select="r:identifier(concat(../../id, ':', info/informal))"/>
                </xsl:attribute>
                <subject>
                    <xsl:value-of select="id"/>
                </subject>
                <description>
                    <xsl:text>Method </xsl:text>
                    <xsl:value-of select="id"/>
                    <xsl:text> has </xsl:text>
                    <xsl:variable name="total" select="count(info/informal)"/>
                    <xsl:choose>
                        <xsl:when test="$total = 1">
                            <xsl:text>an informal description</xsl:text>
                            <xsl:text> that increases its ambiguity</xsl:text>
                            <xsl:text> and has to be eliminated</xsl:text>
                        </xsl:when>
                        <xsl:when test="$total &lt; 4">
                            <xsl:value-of select="$total"/>
                            <xsl:text> informal statements in its description,</xsl:text>
                            <xsl:text> which increase ambiguity</xsl:text>
                            <xsl:text> and have to be eliminated</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>a lot of informality in its description</xsl:text>
                            <xsl:text> that significantly increases ambiguity</xsl:text>
                            <xsl:text> and has to be eliminated</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </description>
            </tbd>
        </xsl:for-each>
        <xsl:for-each select="method/steps/step[starts-with(signature,'&quot;')]">
            <tbd>
                <xsl:attribute name="id">
                    <xsl:value-of select="r:identifier(concat(../../id, '/', number, ':', signature))"/>
                </xsl:attribute>
                <subject>
                    <xsl:value-of select="../../id"/>
                </subject>
                <description>
                    <xsl:text>Step #</xsl:text>
                    <xsl:value-of select="number"/>
                    <xsl:text> in method </xsl:text>
                    <xsl:value-of select="../../id"/>
                    <xsl:text> has an informal signature </xsl:text>
                    <xsl:value-of select="signature"/>
                    <xsl:text> that increases the ambiguity</xsl:text>
                    <xsl:text> of the entire method and has to be eliminated</xsl:text>
                </description>
            </tbd>
        </xsl:for-each>
    </xsl:template>
    <xsl:function name="r:identifier" as="xs:string">
        <xsl:param name="text" as="xs:string"/>
        <xsl:value-of select="concat('TBD-', substring(digest:md5Hex(xs:string($text)), 24))"/>
    </xsl:function>
</xsl:stylesheet>
