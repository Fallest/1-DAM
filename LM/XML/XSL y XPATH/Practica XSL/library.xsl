<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <style type="text/css">
    h2 {text-align: center; position: relative; font-family: calibri;}
    table {text-align: center; font-family: calibri; width: 100%;}
    th {height: 40px; font-size: 25px;}
    td {color: white; height: 50px;}
  </style>

  <html>
    <body>
      <h2>Colección de canciones en la página Web</h2>
      <table border="1">
        <tr bgcolor="#35cab8">
          <th>Título</th>
          <th>Artista</th>
          <th>Álbum</th>
          <th>Duración (s)</th>
          <th>Guardada</th>
        </tr>
        <xsl:for-each select="/library/song">
          <xsl:sort select="artist"/>
          <xsl:if test="@saved='yes'">
          <tr bgcolor="#4d5a8a">
            <td width="30%"><xsl:value-of select="title"/></td>
            <td width="25%"><xsl:value-of select="artist"/></td>
            <td width="20%"><xsl:value-of select="album"/></td>
            <td width="17%"><xsl:value-of select="duration"/></td>
            <td width="8%">Sí</td>
          </tr>
          </xsl:if>

          <xsl:if test="@saved='no'">
          <tr bgcolor="#4d5a8a">
            <td width="30%"><xsl:value-of select="title"/></td>
            <td width="25%">
              <xsl:for-each select="artist">
                <xsl:value-of select="data()"/>
              </xsl:for-each>
            </td>
            <td width="20%"><xsl:value-of select="album"/></td>
            <td width="17%"><xsl:value-of select="duration"/></td>
            <td width="8%">No</td>
          </tr>
          </xsl:if>
        </xsl:for-each>
      </table>
    </body>
  </html>
</xsl:template>
</xsl:stylesheet>