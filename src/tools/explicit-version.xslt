<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Licensed to the Apache Software Foundation (ASF) under one or more
  ~ contributor license agreements. See the NOTICE file distributed with
  ~ this work for additional information regarding copyright ownership.
  ~ The ASF licenses this file to You under the Apache license, Version 2.0
  ~ (the "License"); you may not use this file except in compliance with
  ~ the License. You may obtain a copy of the License at
  ~
  ~      http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the license for the specific language governing permissions and
  ~ limitations under the license.
  -->
<!--
  This stylesheet lists all dependency and plugin versions that are listed explicitly.

  Usage:
      java -cp Xalan_bin_distribution_jars org.apache.xalan.xslt.Process -IN pom.xml -OUT pom.xml.out -XSL this.file.xslt
  --> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:pom="http://maven.apache.org/POM/4.0.0">
  <xsl:output method="text"/>
  <xsl:template match="pom:plugin|pom:dependency">
    <xsl:text>&#x9;</xsl:text>
    <xsl:value-of select="pom:groupId"/>
    <xsl:text>:</xsl:text>
    <xsl:value-of select="pom:artifactId"/>
    <xsl:text>:</xsl:text>
    <xsl:value-of select="pom:version"/>
    <xsl:if test="pom:type|pom:classifier">
      <xsl:text>:</xsl:text>
      <xsl:value-of select="pom:type|pom:classifier"/>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
  <xsl:template match="pom:properties">
    <xsl:if test="node()[fn:ends-with(local-name(), '.version')]">
      <xsl:text>Version related properties:&#xa;</xsl:text>
    </xsl:if>
    <xsl:for-each select="node()[fn:ends-with(local-name(), '.version')]">
      <xsl:text>&#x9;</xsl:text>
      <xsl:value-of select="local-name()"/>
      <xsl:text> = </xsl:text>
      <xsl:value-of select="text()"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="pom:dependencyManagement/pom:dependencies">
    <xsl:if test="pom:dependency[pom:version]">
      <xsl:text>Dependency management:&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="pom:dependency[pom:version]"/>
  </xsl:template>
  <xsl:template match="pom:dependencies">
    <xsl:if test="pom:dependency[pom:version]">
      <xsl:text>Dependencies:&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="pom:dependency[pom:version]"/>
  </xsl:template>
  <xsl:template match="pom:pluginManagement/pom:plugins">
    <xsl:if test="pom:plugin[pom:version]">
      <xsl:text>Plugin management:&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="pom:plugin[pom:version]"/>
  </xsl:template>
  <xsl:template match="pom:plugins">
    <xsl:if test="pom:plugin[pom:version]">
      <xsl:text>Plugins:&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="pom:plugin[pom:version]"/>
  </xsl:template>
  <xsl:template match="pom:project">
    <xsl:text>&#xa;Artifact:</xsl:text>
    <xsl:value-of select="pom:artifactId"/>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="pom:properties"/>
    <xsl:apply-templates select="pom:dependencyManagement/pom:dependencies"/>
    <xsl:apply-templates select="pom:dependencies"/>
    <xsl:apply-templates select="pom:build/pom:pluginManagement/pom:plugins"/>
    <xsl:apply-templates select="pom:build/pom:plugins"/>
  </xsl:template>
</xsl:stylesheet>
