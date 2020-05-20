<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="sepm_tb1" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[日期,,.,,发电量]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.Integer,java.lang.Double]]></ColumnTypes>
<RowData ColumnTypes="java.lang.Integer,java.lang.Double">
<![CDATA[1ZUCR1?(.M1?LFU1>t(M1?C@S1?11m!!~
]]></RowData>
</TableData>
</TableDataMap>
<ReportFitAttr fitStateInPC="3" fitFont="false"/>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
</FormMobileAttr>
<Parameters>
<Parameter>
<Attributes name="temp_para_type"/>
<O>
<![CDATA[sepm]]></O>
</Parameter>
<Parameter>
<Attributes name="paraDate"/>
<O t="Date">
<![CDATA[1589472000000]]></O>
</Parameter>
</Parameters>
<Layout class="com.fr.form.ui.container.WBorderLayout">
<WidgetName name="form"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="form" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<NorthAttr size="35"/>
<North class="com.fr.form.ui.container.WParameterLayout">
<WidgetName name="para"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<Background name="ColorBackground"/>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.parameter.FormSubmitButton">
<WidgetName name="Search"/>
<LabelName name="日期:"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Search" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[查询]]></Text>
<Hotkeys>
<![CDATA[enter]]></Hotkeys>
</InnerWidget>
<BoundsAttr x="184" y="7" width="80" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.DateEditor">
<WidgetName name="paraDate"/>
<LabelName name="日期:"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="paraDate" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<DateAttr/>
<widgetValue>
<O t="Date">
<![CDATA[1589472000000]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="64" y="7" width="110" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="LabelparaDate"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="LabelparaDate" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[日期:]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="SimSun" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="11" y="7" width="53" height="21"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="paraDate"/>
<Widget widgetName="Search"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<Display display="true"/>
<DelayDisplayContent delay="false"/>
<UseParamsTemplate use="false"/>
<Position position="2"/>
<Design_Width design_width="960"/>
<NameTagModified>
<TagModified tag="paraDate" modified="true"/>
<TagModified tag="Search" modified="true"/>
</NameTagModified>
<WidgetNameTagMap>
<NameTag name="paraDate" tag="日期:"/>
<NameTag name="Search" tag="日期:"/>
</WidgetNameTagMap>
<ParamAttr class="com.fr.report.mobile.DefaultMobileParamStyle"/>
</North>
<Center class="com.fr.form.ui.container.WFitLayout">
<WidgetName name="body"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name=".SF NS Text" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ColorBackground" color="-1513237"/>
<Alpha alpha="0.23"/>
</Border>
<Background name="ColorBackground" color="-1513237"/>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[144000,897774,144000,72000,432000,144000,723900,723900,723900,1143000,1143000,1143000,144000,72000,6683432,5184000,5184000,432000,144000,723900,723900,723900,1141920,1143000,1257300,432000,432000,6683432,565265,144000,1296000,1152000,1152000,144000,432000,144000,723900,723900,723900,1141920,1143000,1257300,432000,432000,6683432,565265,144000,1296000,1008000,864000,864000,144000,432000,144000,723900,723900,723900,1141920,1143000,1257300,432000,432000,6683432,565265,144000,1296000,1152000,1152000,144000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[360000,665018,1008000,798021,199505,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,798021,365760,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="5" s="1">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'sepm'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'sepm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="1" cs="3" s="1">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'d3'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'd3']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="8" r="1" cs="3" s="1">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'rm'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'rm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="11" r="1" cs="3" s="1">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'solar'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'solar']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'sepm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="3" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'd3']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="7" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'rm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="10" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'solar']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="13" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="6" cs="4" s="4">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" cs="2" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="7" cs="2" s="6">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="7">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="8" cs="4" s="8">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=TODAY()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" cs="3" s="9">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="9" cs="4" s="10">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="9" cs="3" s="10">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="9" cs="3" s="10">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" cs="3" s="11">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="10" cs="4" s="12">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="10" cs="3" s="12">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="10" cs="3" s="12">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" cs="3" s="13">
<O>
<![CDATA[计划发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="11" cs="4" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="11" cs="3" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="11" cs="3" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="12" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="13" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="14" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="14" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-5850655"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[发电量(MWh)]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="48" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-1"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-1" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_tb1]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="发电量" function="com.fr.data.util.function.NoneFunction" customName="发电量"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="6d46db1f-d921-42fc-ba5e-eb6c8680d5fd"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="14" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="15" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="15" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[完成本月(MWh)进度]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="48" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
</Chart>
<UUID uuid="01a40379-2007-4d64-a2db-d01c79489303"/>
<tools hidden="true" sort="true" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="15" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="16" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="16" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[完成全年(WMh)进度]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="48" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
</Chart>
<UUID uuid="b3776e59-d3c0-41b7-a9dc-151293b1d3fe"/>
<tools hidden="true" sort="true" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="16" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="17" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="18" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="19" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="19" cs="4" s="15">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="20" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="20" s="16">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="20" s="16">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="20" cs="2" s="17">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="21" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="21" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="21" cs="4" s="8">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=TODAY()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="22" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="22" cs="3" s="18">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="22" cs="4" s="19">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="22" cs="3" s="19">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="22" cs="3" s="19">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="22" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="23" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="23" cs="3" s="20">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="23" cs="4" s="21">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="23" cs="3" s="21">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="23" cs="3" s="21">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="23" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="24" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="24" cs="3" s="22">
<O>
<![CDATA[可用容量损失\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="24" cs="4" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="24" cs="3" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="24" cs="3" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="24" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="25" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="26" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="27" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="27" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[D3热耗趋势图]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_tb1]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="发电量" function="com.fr.data.util.function.NoneFunction" customName="发电量"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="fb39b75c-9946-49e1-9b22-33f3e5e06b9d"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="27" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="28" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="29" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="30" s="24">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="30" cs="4" s="25">
<O>
<![CDATA[负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="30" cs="3" s="26">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="30" cs="3" s="26">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="30" cs="3" s="27">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="30" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="31" s="28">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="31" cs="4" rs="2" s="29">
<O>
<![CDATA[热耗指标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="31" cs="3" s="30">
<O>
<![CDATA[累积实际热耗\\n(KJ/kWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="31" cs="3" s="30">
<O>
<![CDATA[累积协定热耗\\n(KJ/kWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="31" cs="3" s="31">
<O>
<![CDATA[累积热耗\\n偏差率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="31" s="28">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="32" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="32" cs="3" s="32">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="32" cs="3" s="32">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="32" cs="3" s="33">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="32" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="33" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="34" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="35" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="36" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="36" cs="4" s="34">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="37" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="37" cs="2" s="35">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="37" cs="2" s="36">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="38" s="7">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="38" cs="4" s="8">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=TODAY()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="39" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="39" cs="3" s="37">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="39" cs="4" s="38">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="39" cs="3" s="38">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="39" cs="3" s="38">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="39" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="40" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="40" cs="3" s="39">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="40" cs="4" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="40" cs="3" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="40" cs="3" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="40" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="41" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="41" cs="3" s="41">
<O>
<![CDATA[上网电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="41" cs="4" s="42">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="41" cs="3" s="42">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="41" cs="3" s="42">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="41" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="42" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="43" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="44" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="44" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[风电利用小时数]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_tb1]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="发电量" function="com.fr.data.util.function.NoneFunction" customName="发电量"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="aebda255-a329-4c87-8eda-83a2ebee89ef"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="44" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="45" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="46" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="47" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="47" cs="4" s="43">
<O>
<![CDATA[利用小时数\\n(h)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="47" cs="3" s="44">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="47" cs="3" s="44">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="47" cs="3" s="45">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="47" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="48" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="48" cs="4" s="43">
<O>
<![CDATA[日平均风速]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="48" cs="3" s="44">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="48" cs="3" s="46">
<O>
<![CDATA[本日负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="48" cs="3" s="45">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="48" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="49" s="28">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="49" cs="4" rs="2" s="47">
<O>
<![CDATA[平均风速\\n(m/s)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="49" cs="3" s="48">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="49" cs="3" s="48">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="49" cs="3" s="49">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="49" s="28">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="50" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="50" cs="3" s="50">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="50" cs="3" s="50">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="50" cs="3" s="51">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="50" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="51" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="52" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="53" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="54" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="54" cs="4" s="52">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="55" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="55" s="53">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="55" s="53">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="55" cs="2" s="54">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="56" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="56" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="56" cs="4" s="8">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=TODAY()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="57" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="57" cs="3" s="55">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="57" cs="4" s="56">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="57" cs="3" s="56">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="57" cs="3" s="56">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="57" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="58" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="58" cs="3" s="57">
<O>
<![CDATA[上网电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="58" cs="4" s="58">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="58" cs="3" s="58">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="58" cs="3" s="58">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="58" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="59" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="59" cs="3" s="59">
<O>
<![CDATA[负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="59" cs="4" s="60">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="59" cs="3" s="60">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="59" cs="3" s="60">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="59" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="60" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="61" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="62" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="62" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[光伏利用小时数]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_tb1]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="发电量" function="com.fr.data.util.function.NoneFunction" customName="发电量"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="cac63103-658c-4d2a-b21d-e4755d5acc3b"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="62" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="63" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="64" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="65" s="24">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="65" cs="4" s="61">
<O>
<![CDATA[设备可用率\\n(%)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="65" cs="3" s="62">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="65" cs="3" s="62">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="65" cs="3" s="63">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="65" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="66" s="28">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="66" cs="4" s="64">
<O>
<![CDATA[利用小时数\\n(h)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="66" cs="3" s="65">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="66" cs="3" s="65">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="66" cs="3" s="66">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="66" s="28">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="67" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="67" cs="4" s="54">
<O>
<![CDATA[天气]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="67" cs="3" s="67">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="67" cs="3" s="67">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="67" cs="3" s="68">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="67" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="68" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="96"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom color="-4144960"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom style="2" color="-3092011"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1513237"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="48"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="1" size="48"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[S@j&JPKieRN2#sAJFmHIGGMlNkp!fb&1LL&&6aT\6okU088logWR:jA-qQZlHABj6#76sJq1
A)7mFT%t\^#E%o+0Hl1XE.*ZY&%f>&38g7-eNcOqQ.UiS`XUW]AaA1_nika_SNc38UuSEJj^7
\io#'ZW%#h-ph'KIp8b&kcIkC4&Nkkqdcodb;?.Xg#qaM)-2e[$__k,!Vs.\2;>pOukDNu:`
DIb;P1#O=9<gSPG>.8Q!Qnl\'/cE;7dARS!9J/!"L\."9)<BAACpR(.P'C_m1]AQiq/Lm"Y&-
fqlm_u!&Xa3Gq$$h:P=Zdh5f9?#L5F-hgY,SXhP!K<:8mSbXgCjkW[qfTY^KpdP+XW\J=J@(
%J5o^lj@\*`f"o!CB48+CYiTmXMYq@p:6DkIY)>Oj*lgL,PM;_=^MA)mc&'e&D[rNTDdkUi6
b2OO_3SJSt<"5+to4^!:OV6Q^TM6&4+OUCm0.'q>9%0r%4id`2nUX9u+naPQZT2^ndA/7gu\
uR^qa[BWlIbpnOb!%f3QNfjn.&apig1cK;EtIuPOogoHTP;_ZMkBV![Uo]AC_,VehX9"&BHYL
P@?7c]AC^SFm1X=04E\Z85DF$8\:Y$]A'`(pK#h.s.lS"pOPT&0N.Rl36KTdJ#CpIU&\;`N^#a
Tk5Te$B'\XV/:FJRFNE]AMKKdXhMDt\/dmRE0h57`,9'S65]AR^?NhJHO:4DLD0'c/e/Vi81+D
YaF0KhPV^!ARUTDp-4#;*1%D=j_(%<#W6/YGD6s=qdNedjJ?"W!Z-0'%(XobQ?&b5.<;'Zqk
<Xc$6c(]A9)=BWe&o]AZE:`@#U.,S`D1NNX?kkbnoX=b)]APQ,/cN0G[$Phf9'KFDB%A8"H#uY4
b3+:*M+Wcg3pB4"sBLt-$C2%a&LX3(!5Bq\o4S%jj[NUE?cMqZ@dkI_\e!At7Ntq]AK:QVdj^
*GuCm<.Dc"_uqpTBa5keWV:.nePP3S,P3rFb[.SbUI[_URZ!^=eg0bEnS1#5-j-EWIES%.md
q;35bd)dESRX\&fctS<H4OoM_5hp1(Nh)p3UfPKD(BdPM1+DTaX,N$1rm?r4AYUU979V#,Mp
NiGhB=E2A]A>@Cf[(V+r#,-6uje&q9,a\/la7@T]ARI>\pcoDDY._!S6(%<cA39jk`O6.<'uj,
B)F$n4'.iHBF]A$=[#8+\>.f<Fnd>@Z0Wt/WHeH=<0W$maKFO(b%(h9(<k4N5aW]A;$potqFJ#
4mOa)fXe)$0`,c]A?+2bFa5(mLQL+u<15N+KuU==4+GrF6XfTksS]A0':)'Ead3*<3)^q]AO$1&
-XH:?&3#O%A^aO<>8^&'^,;*e#be&bQkX4ngSBJ21[d`X=rnCUg9[^+!:hiE#'^_p#0+e)7'
hq5+$.qAYt2co]AF;!=-Bo2>$1Png7sO'XaV6cUg!SDo%j+r0-b%urG(O16"<V(MF[O'HVVrP
H<ijh98-^"Z`+,PYK<TVVRK5s@U$:N<C:duFe-$j>-[hs(l.MQ=*d^Klbeunc%ffkb&R'JG8
hUml)<t:A-gr1nC@XJc.cV:d'o>Oa/s'aVAj7/(rYloB"V'o7Qr-gL2FD/Ei:"5M`"kcIgrA
n!+Q"7m\0F:.H9BYE=@c(&_KF'\*[jsTb4(8N*5,Ln[N/TE;kKP@KafD`QkuhER2<E[B;NZ1
O(aQnp$uW@Kn[07ka0*d-Xmo0b&Kbp682b[J3ulD1-eidXisJC,U?m6((#_1YY_<.k9]Ad!eK
!nEYmCcb#>eZ>R769IjJLYel$6dlS-lN2V[5hJnjmZr_[@@3DFhjN\Dgr9Z4*)_qWZ=CU/,g
6)pk2:GHnS7+>oV^2(RlJuh@Lfuo*R:&#*D[af&0W[aJcL/r%qSe_>FV^Kpn"]Auq34@\G&<O
W:l^,6mKn64H(5t9[UnG_9DWccZqp5mb@9lmoD8D*E*gpC;_$rJ6WVYQ`F@RgU$?Sj5nDXkN
bG9K(bNm6)sX[f&?@TLCWeIq-\&'S5a]A9!%8eMXSQgkd;_qWot@p.3jWlPbF^hg3>Wf_=0Qc
G(N/MHd1::4J\\c'A6]A)AI=1C`W;lD/V9jfF"9tb.1m\or4TnAA"?7Dei7$cL::Y,fj7`/0&
lOR/f507]AOj6gkleB]A84Q)9ZX6``NZ44+n9%^@*n#WlBkA(fD7m06&Uf?dk"j*1riKjaUe!R
[_SI?*WEj&q+#cNT<%At>6)Ra]A/T-Lg19W%8f5Lh;=R87P6VU,1]Aq.uV"n+?7L93i`):@_)I
\&5WRk2+]A:dZEo=N1Jq&SIA]A^Nc\1,D\L(2IMKg]Aa\>/'JscZP[^@+Ghdi1j?pa]A]A'\o<Pl7
gE%<\aZ_Np>%!VR(,u33UOrXL7&adW;=9M-3^jCr<s&K9?NS!7!fQG^`q),?RB%>V*-K]A'o+
e-FaFqqgnL_@hhLjqE$0>U]ABoI^o240i<,VaZ6SBD-a_iB:p(/<^NU>/%TuB@@G.[KqkY6Be
#$jVJ]AJ0.(&gH:uR9pS>h&AP9!5.OcT!Oo*gul%RtqQP[iWM.8s3k*FguL:r,^dEel-,gs%]A
.q*cT@K*bj7ImYU;9r:W-U(Z!YfGIQ'#]Ao&SdBD+DWnc,s4I:D,2k\\fQnBV2$]A(T&9f#@!#
T(#K=;c+F(GZioYPms;<SN[^'#Imd2/Wq>bDc8cC\4c`.Fh?j@Kf=Ga(b;P<@']AcN(Hm2;IQ
8+X7`aiX<d,^^]AO0kP$ZP+qEL9&=Y7q0j(78)a2]AE`3Y>T[UsL]A<O\pY_s$EoYkYSl/P$RKL
9-8;Lo@jLn9*bo)`BrO?;4PI>4u9-=B8&U[k.QqaS_mAF?SWr,7"o?g0eaYVgLKgPEPp]AXZm
A6Et@n>P)-bH`iq_C&gcl5PI?<>TdUPnF73"!Ag&m)67t9Z4\G#*B'UreDGo7?Ipj@&"o9Us
=j15'bj+*C/1*Y=11L*U[bjiTm@);g^I#ntZaEWQmX9TS@]A3+?a=VT5e8Ki54$tud`<O\rSF
S"!ar-33@>KW[):<4?[Q4),<aHKnc<$hk[YiZlQ37&c9Bu:J.5*NG\pb>s._&XR('^jT,%2E
>:,C/fbOct=]Aq:0!QakG5+"-&(Fi_V(XQ<24_X41hW&O5(EOnsgf)dp1Sa3YM4`(u)OF!$Qp
J,kch@CY>5TMH\%C.9P>Q!uIcP/DQ;D>8lY&K$V"(ZCPhD?3u;flc_(#5(eBn4@j5LAPk(qb
W>j8DEpHfI2:b]AM3"V'XWOcCdAb&_^;YH!*df3<rkTJ[mbA$MKd'2cu[&#E""8%9iUWkCguc
4<u*T93@7lo\Y>ZN4N/`H0JQR.n(`FX@M5oLa+#9N',Oi:Q\oE@Ht#-DWs=Bj3BJVoU9ffT_
PUl/^fF>q6@aa6ZONi?[9mnCp!:;5/P?lfrlQ+!sbiC?kS?m,bcs;I+mOQp-c%%^[T0[%/k:
jh:q".T`Q7TGiq[B8WIAH#`:?`:EQ9+1p4KGbhTr+GO?1&,0*7m%(qcTFuYeKCL"Y<#>+G`1
Mi9.k$'C:5%?t?7*g6=(-&QT)F%=S8E`1C2LH05;L?u2ODnEYd9.UB_B[c=RaM%$rm72;F>3
5Z(k;jPN_jHs>$*0$TE6\]AIt8BFD`n9Ul#MBSL(n0sP!WaarV`WcVh+\oh7;-.6@YsBXCdR4
qtTcdXjHa1gI2Z)=tB^7cnnl6daLb\j4WVmCOl%s/$PmH^.q'<%Ks!'6)go3dW:.TYtZ/V8(
]Abo&("'GjIcrWf2kCMC>$1o6H($n9Qi<2FX4BT%98Lq\#\P>J_`dfLc1f_K+:]A/k,6e_,^qS
((P1)gJuTunr<DUH-)/r&&J1#cOV2rmpE;c6qQk1,%r!:QDoYqF\>c!Vcpn<j*O)f+IP2B07
84S>;VWcE`=mMgXO_YCmlJsL`bs+lH#B:4p.3K-3QZ[Urjm.YfGNo%+hHe?hPmtAQ\7bZ,KZ
==A=%8oQJ3p*.[%tQDO,+@GQ$8@=-S%"gh%PHQ-6gYS-q3@(d0K6KqiHjRsgln),^MS=,j="
^*=QXcNe18if7ZA;VVnuhf;iQ5F,DL.Z3M=deeZ9q;,1X;fP1W(UpQ9Ese#=%R;E1.D>e6C&
+@6@D1V$ksFuRAJ,c;r.Uccddm^cak8ZIZ7dR57?OuTf"it'%?Z8q"RD]A7VBK.QdmMCkSs9H
B,DU8@"?sB[Ym<"N,B\8?X3;_R?Ii7SW-Im?C6ihdC_o7dHbO9FKbt'p;KX44>t(8#5sa*Hq
`s()S;lP2A=e42FOd2DGr0>1nCZ*OD7Hb?:nffg2M.V&SCtE1i*c5!,-JJ]AepD0u3?o'5f>O
o*/H-RAZ%`'(THmWUR=:0`eT0$nCk3Vo#c\@-gNnZV<`\(`M+U<bm9qg(*]A9tK(_CD.*-*j2
@uVs^,Oo8"hj]A-uW@*W"rhXD=mV*3ZSu[:]A0AZ^rC%n2?ZG-G7O>4X5f1P?f@*1^_75ubgDm
t&,:]A+c&jMm0#T8s^*_t5KdGr#q;?f+\<lkgjf<HC&=4_VA6)PK#>i:7EUR&*&g\6.>Wr520
Z#=j[pc3MTV*-:GV:1g+34rA*oKdT.nHHF7]A]A]A;Ru@\kWc#U8f&'T1Ol#gaB(@7)L\RXQjb9
aTusL8'>2Np\t2`DX'n_403:\p15fg_\QY^>&`4UF%1F%qTBiW'N0Ro9f#jl?,unfSA$<8ZT
UL&M20^W+9(PdmMO[!0:0ng[;TI7ZeLb+<o_-2[&I*/:f7*&T1Le2[>kE$c-<d.ZmNPh&5Po
`LPq@@jH6B%s[!qPfDXsjf`QR&2D[A`*U!f2+!F^dl:ttZfUU/SG=.pIYj>1?Ccm3Il!(*&e
j6?FF9MoiRlU6hF3OQWVYRsCT_U1n9&bc_T)t:0VA.JBVFG]AhbAoPXURP(RN[Q&\gbEQT0''
AN;3brr\.1=E[IeA,_G-?6o13ld(-p@@'QY0_dELZ6#a3@Sia]AsmsdI!CZ>!f16'W.K7?4+N
^qB1Ja_sapt4aV\To=Y[XIDuA@n/5X6*iqDX0B.gcV@XD2sFF(9W_UT#K+58sE*d0$,?[qC4
<t=V'N%jmMs7f0`?X_Zs:nF-5ceFsHE7q,A$0'+,8UGjtR>+>WlS>:Eg3@2Qh6^,Nnl3-,o-
raOOKp)_nV6BlMck0cGZ;t[5,NRr6ZbT;i`lktU0\"\adS)6Eal)_>\,4fS''6;IA*7I?qUW
:*,*!Cl=ndT/jkJn9I?Q-@YgtQG#L>F1$[#l`T^Wes[0W0"&fRM0BN?rn.`&Ul!WXS&9r+;c
irEFTq+(a7MG8<81\ct69.H=*N+E5@9,o(D`>KK\I6'=EZ'"Dcl9-_fm@4%`51)`[uA/=Ul>
rjK,@3)3q'<B%EV"q'8Ie+.q@Q<P&HtN;.lOt1u1bXQuq,$p'4JcQg_!glhiG$CiQN5&MDOe
,f[oR*E+5,JM831nqhZiA%5!h?R_;(,s[/(kY8E7UaH]A,/%=4?L1E7kZ5+f\."Heo*+,f58J
d8>BLc"eeKqpld.3W_3OZKAf_"TH")pMg`]AI_#0tlV=@?,6M.&-0@pO>UJWr;BRkL+f2\UJ`
itl5LRFBf_MdqQ6HMr_k`1;^l*I4oc5>19U_sBfp.+egh')(J`:$j),G4n+$nC?I%+8e>V$U
U*jS@RPLUQ>+c-_$1U(mR_h.%pQc<%G\)3I?9?a$I>m<peIE-m=UW-odSaa4"85c/>"Yp!qZ
b$iS71YUK?66p!2G2$1oPl>E2(Qn&kKR%ef0q,MAUWBs84%lS0,:ARPCCj=hU;M"m-RgOq#a
;gBp!T_U(mo;;1`W\U%eXTF2X@^e,+.9lf@rJfL@>Ylaq<4>\NJ\l+GJV;)$Q"lh+<hB!qYC
q0Af2-*aG&1uWr9]Aa<L[&Zbk!r_gh*V$Nr7"n8DcN(t?I1Zs,T<m#^^PYU!;h2lUl9kdmB0>
(]AO%k.XF>aV<oFqX8%=Gb)`8KMO)^E*=X+f5ol\ZW54:_(0gFIj(^H<bbW+?lS"`b=bahg,u
(<`:$6^ek5HH,NW/Bc83uUZGVXUqs^U;l;lZ[kEtP=sSueBb/CR(Sr)]ATBSoi`u9n4_ni?SB
'Is['sN&M-Q=QWTHl:4hU38+PIldc&'lRSbNVt2QKTN$FDd/u1.p1c>SlWmKlQR'BnJgfrCA
LX,8GuCmdohZLS;4^Vk=CHmT7g*=0>bWXFZmW2N]A'Prid^fOHW`.Slm054Y0S^=-o:gCV?]A>
.Y:FBkEE+@fF#Rk5d2B_4Op!Jn`<d>PakMsqqQ-M$>nV)&d*STBU2^".;=U.,,JK*0q__LOW
7Tk5Ybg(;csj2h@X;ebP@7PF,SOPBfhIPDTD@j+F[4qUXPMJo&.gKE5]A/KS1(=]AhOu8o;.G-
4#pIc^k7FRm`;QOO)ItA)l[BV$6E`'di^=YJ`*C$j"fsI-ErNGs&7+$k5_B>\WnT3qNNr)kP
=GZ(kTZA9Wao-eNKo@Ng[p6:(u(f,r8h3:oQmgYn=lj>;GlcK&aIaV,M_&,rc4M#>1(44$_K
KB^O9oPKJl4@,K+Sq&/_aKrep7tSNSX%C^bQ,cecD_#AVSADS#GoJcJo5jWf5q]ARoBa'kG3h
=85cj#qE[Z`iIEH]AC-npV)+__Dc8Rp6G_cC\1up$lgB4dTW36:+@b-9#427j[fi)kq%c3fkY
l+4!5UR#j,DaRi_67<bh;;#ocgUi'+Jp*"os@sSL<>/dsH*@b]A7]A-=f>I+>&%NuG%A/H^fQ7
/<9:DS"hIkgJs;''\6O.L<mXM>g>f0,`pMbeVZ8tpK!lK+?lr<X]Ahi8O_6)AF]A;Z"Z#E9>EB
N/HuK;H8s$@a)W0X#V=f4I'S<H3TuIG(G,e=LG&cXIqC."a_`^o?NZBW4YF9QDDGb\bU22@_
E#rTa:@EH#?d0;,p49T\KVqtH%m8Ts9l0-T0kGVS-8CXorA2]Aar5a.m\'jeIu[)+FKnBk5Gm
BbbJ!\4!d_%)[m9Y$%_8-:,_[rjHVo1po[YLloTD`ZnE$q[bM/rbFq+@u=-J70LnR4NROXG'
IXh&A*n#fO[0]AiH^6@&]AXs2'AZAtajuYZ`N%,n39E!Z;$*^,3;M"2/j?!u@K4tEhk;N@&,MG
.D.:`+B3=G*P9pmcK9-DQ*cr\^O5Ao8)-\t`"cN#!ag&<cGBEMubSK>pJS32\.PpEVS+k<,,
&HcNPTKI5iM;fj&VZD2E2#SiUos1O+`UM2HW.VTFdjierDih_Ln\0m<neb:P:0E)htpm_Jtr
2"gLaD-HA"uC^H6)/!6JTV:gm]A1G-&Geg]AUQ@V32XALr\\^OrlHgr6rs"=6B>Y0L3u5B8Eso
BtMQ-GuH&$Pom#en;BtF.S:(N!f=j9)FDI3pRkdTh^$PKM1#&e";'8</?gdt"(m81'`RpN/7
TRP4WfPs"iq?"[UIK=-K5dhI[sK&SdE,VUlkl\,-077g.EH[0j2!nMGb[:ls<]AneaIdkd)UZ
hFq'Q1\tLe5k^p("(o`CoC,o;aRhKXBXU,B2ot,RZ+o7)PTlP`peIH$.inQ^4iV37hc=Z9G`
o.Fj1"^8'g>quVk'5e?cV9O)f8>0@i>4jmUN_c818usPQlk1'q>DY,CYTMZ%]A0c\?:8bHb&$
jl`-';E]AVPlZ\%)^/5eQsNh?/<b/N,7gDMgS1X)I[$;q%c\6=]A?S@QqmTGA"]A.Qt6@R"5WNt
Rku^BPXA*=&rl"_:5]AJ+m+gqAG4JZcj\>Nb.2+52<U6C3isWiPp9Fl>[:eE+VYufl1jJcNj;
tYnA4*stfC=<Yj"9g@U4,lGTOtGl<R#rTAFS.ZlL?:j<(jAL$if_e;<n3>HW+#Q"CJqO>M<"
aO9F0G)6&X,5gJX4<-`(B$MC>FULN_7IpRkL*I@fe$b4+<aDoC?o`/Dpq,<'Ik0/g&<tg+&Q
QctUIs-]A\_I`a]A[.]AQu,D<KX&slXL_;J[<(kA&,*d7:iP*pH@lSrWX?#ETf(!DXRPeP+RmGG
8tmJopF>>@unP"<8_o@>d9=cEV"\FK6HD<_YJW)+1LbJ.K//.5D\WK)qJbQL>JP,Ob>B5X0u
8,"e1^W1::"l/F91H9;Kpp_U*)[`ar^3"MH@1r4+6caZ2*Em"ir!fV/8eA0M>bIq)jWLbBAj
d)Rp=>1D>Q8qbF/7V3^i2CKgO>O;oL,#=?r8!PUTX0o/rfXQnKea4LL0OkN0iB@^du?u4i7P
lbGS?KY.`%m/Kd'XAL3@tno*/5:k8oM2ouc!0Hn?q(Kr5mERJ(9gM=rA@L$&n)R.[?IY=kc+
tJ9'$Xu9ZledFu7D^%C0]ArfCK1.=BrWFG]A7":pCU43VB:A4-[1]Aip>7+We4\l>>G<&'''+X!
>d8k9Xa))fqS$0=S@`f0XZ$LUpU!qh\I^`Eg,G>*@:deQ[/O?cj@2j@b'bTIRQY(n83a9,eX
Y]Ajg`0mZAJc9-o=($/mZ"T/Q(YYGEp<tu1'e3iX3&aO5+ZkQ%Cft/-/TJa6<cL<LCM7D095$
uRD;K\q."Sr*J\%Pij91dk,e_FOh`lV;5C1$+1,=rcGcjs3"mpaSNgT?ThQl3aFi1eA3-\GW
&$D2U&=hSm`8fW9O@"E(=h"+bp:qmDcWkig=L;l8>#S"?$"[B<tDi)&mlfog'ms64iP;nk(I
jFV6n#u@-53\ELG8IlU(H^ZAZ1Tr$Dn1W_(!#eBg.;d"5-'?a'\3nSO3h&`Qlc?M-,%LM*]Aq
'5g@!pTC@K-Br7<#J"YI`Na->WhR7Ua,0;:L`"fPtI7o\b&]ASYtN()FP4De[l_`iB4r^$-_H
P%a<(94P6`8P3i`l$L&iXGs%"dO&,&JS$-lQKAFAj4\/p[TkGdXtm+ZZ1)*RH8/[+H!?b?JC
)&J23a:iMZS#LJf]A^KIsCe+H)A-de>ORdSnq5kT%=$!0]Agd$f,403R617UJ$gXXp)`,gklbT
9DJk))er7XEpW$tNXEZ7"p7;`U.hh7"3udUJ)I&\S4jde+rSEd,s4Xn=h:T'T,iS_JU1qA<8
m+k_NK%;f/aUkilbe3*40p%`q!%p5^in"P:>ln)M);D[IcRfUTp8X6i4V!Z=A8(ofaJ1Po\O
grK1BneQt_R5;X\%,c&q_s6B/]AC&YS8@H4+nGb93s!&Tk<pPbs]At)')#ci1EY^q]AWe4Q/fXH
c@PtJHu).P3j-rVN1f!C#egZ*H#&71ITL+:5!'Kf-@RIiWm1oD-2:ghV-;Xb>f!T$?0o/SPj
0#P:cX7r092nGqs`@#1BGbVAh7Dp9Iu8e^#Kjij83/Q&*:Q9'I[mL,?/=_l=?%\K(^*=+/0e
!Pn]A-hk3%[M&:pTfL3ha"M'JW/Uf]AR$fQ7#hYtE#Vf'L)LPUYb+,Y>0Y8^>1;,JJ0XB!,*\X
m<@Hjof93>ZGNB>?jsI-/%gnOT_uGG':Pl9(YmRjM?>iN=-c4^5Af[!TL_h)LTt34rkE]AP]Ai
XRK!lV[HladcHFbSa>kDbikg_XLd[i8Jp?0NX#Ft./@5Gb=`#V;srn[;"7#bY'h%?uL9fGTc
qT\pi2Cl=,Z?ce$$Uo<;)78suDKdDUm>&i'^`/,]Ajh%6'27?d@U6Q'"7fiQ#s7W='YUj.?\6
m-,A<[!iQ;@kM$CL)o#JkQBIiW,!o$b$i.C*(7RkKn+M?,A!^M$Q2GCN!MRiT#cM&\5tbl=u
C-C/4BF8caOP"/dD,a'[m,E8!B(j)kVq%Jp2L*C1Hr$#6F41@i@D9FJ4dJA)"4p-3(95e/e0
,1)&q+G%Aji6eSH>FGZ/Gm%R2(-r%7u$uo:0U//!pCa:G8";WE1++/l/uYd-^@ft>VlP0XF^
n,ZOhE9QrQTb$4Z9Vkfq_I#R1.E/Zqll.)^ul[Aj$j$jTglUC#gB@]A2O0J$`]AaS=tH/WrPfB
GRSD/>C9'`Z#T*Kf*Qf==PG\F*lO)mB7t`9=R9`A$\`bRTHsn_*;O]A!qaj((i^("&jKe1>l[
$9DXHq$"NFA5uVei9[#.0'"Ls(Ik:\2AWDX3^u&<=uMmb#YR2sb55>^p&D&\r2&>t:3sqCBl
.aIg.'n6F&@"1ifpD^q3QRFU\GBaEZCPjikV`HS-ka;le<!%H/Y#MO`LV3SecWQV<VO@3j^K
F.=+Qs[`[0!c_tC^-Ae$^?W0BbjXAk_7TeFgn73;+D,!bEnhO5Om4KN)#45/Su4?ISS1CFgu
HDZ5eqlI9i+N?RLIag,FHt&(L$HbgQ\p%8.0Q[%@;:6$S<Kp2J#e%#a]AW[7.4@;E`4me<"Jc
1arLW@[M;IX$ei.i&Jh<VQ/2l5#=%=eHR^Ud1*WWrbOi*CFu#F+dXuC&U`do.b!8D0h/01b]A
V8h!q_2EbgP53UH.=c/A,6hTrp6IQ#7,M2gn)(a:Hg2-5S6XU?56kRV_S4Z/<&W;B&7A^H92
T@FqP-^;Ou4)!mqS^X&pp)rbbjF?h\8[/EhoF27XXY]AWG?3[b1@AR;`".E"^ugA-\bMVDdQq
,)d['8!Je<mZ%('V8:Z;/V".l1-31b!rb!qDceC_,eduloNXIB=a"=_bRp@.ZXaZQA.pEn^^
QYGt[Ibj';1/l4sD8b<"$Kc?G8M!c;-MU%25<qc%'JUp780LgI\J.fR46G&`CJ"!2jp5;BY)
=ukCM:S$M"_haA]A(ll;]Ag"E3_Fi@CK+2gPFFV_[Z<K/!ip#/YI^P1HGah`a]AR/LF)phSh:oH
kBcWE>#\AT\j]AflF@I+!CtZ0fO@M5H=3PS!.3dr]Ao=sXV)*AR;htpqj/9qgR0ff)8KC+V2@W
`gL!\K=\@.X5;alTdYU6;,I;d5ZRg%T\D\Rpj\`8pko*Ij)j\Rifr<$U7L7sD>BQ/Ed7,WHU
AVUT'@2N/0n+UVIu^$b`3nOmlkQ%i]Aa<uEZ/0E'*^3$L;"%Up<PE&'CZ?f'M3+QLdp)5hI/]A
Xrgu__F$<iW</]AS6.OjIXY?#\Ea(chD>pp%rt6PDiqB1f%R<cc/h/Wm7OFAnlW_`G%^dB&(_
I%?2Dp7;0DD+!Cc^gs,=6:MWS7&^Vsk;H#8P1HoNV?W#b$<6dJ,Onm3Ns\j(I5A&#4.P0+B2
H47-W2gQ>DfnGTj"lFa,I+.B6pD'eCDOXZp);A9S+MZn)>c%c^E1iiA7o()I0?W7acGhBl*k
W#;c0LMH?onjsP!VUh>HPJj+j2"a_$@Q6H:&L=Pqu$`/&*fd,knTUmj?RFZ#?)FH=uM';edZ
[$_4Hp;@8gGdEK5n:_^f;3AeQ?<TQn",GCo+NBi9if>D,6DoUX<eOjT*EsW+WK/2d't)&OV8
%]AQ"D'Vh5n0q3hZFt1r^7"I>a<<Q[<V_9[s`k,gLl\$G!X9=`.E>f"hn"G_U;j)m+SE\dbZd
<[@Ok&d]Ao.Ic-sf]Acg,kRVTkXS</$F-8F_r<0Yg?EIu<cTfAC8SU2[6Mn9/-]A-1MhNXRpX;r
@H)[c:.j=6.?Oaa-GO-l]AfQg_D$%eqUR^p7q\`&X88CKZ@]A(CNUFMY$3ZC$Va,en&`]AY@;a3
.#:aWUUZ/-rLd"s2N<[)EY6%>SjYSs?!U(V<c*M]AZ=5\?p0iJWg/KMdk;1Z$kSOLWc)/.'7D
TT.`p2"G,`M-lXngXIfqe)np&::dR-#`&k:4/r!e/-JpUpGBI[<FMaJH9+YZ__MR0g(e74X!
c"6m7[^F@.T6_Y[GF<"_XpK%Vai/PIWfKrH\VdPtg=TAC(u3)ct.=\S(/N)eJo<`ngdD;]APm
7d#ocN%i3qK"M"@f.(JUThRRRmQ#2XL]At:JC4&+CN]ArA!F0Q7hC[oV-]AH4uheV/(C\cT>),6
jfV\MH%LoM*Yc/XuuX96]AHaH=pnQqOGa?m>WsC#g'"a:um(5o(E*m^:"E_[s+UIRG3</.GRl
.SP$t*Fp0`)+9*6KaLk^&EA:\BBM4BeMlgnU6)GTtU&ubSQK]A>mDt$<@?OhR-Su[H!<IkHcJ
&6e-SXJ/^Wc!&5Ll\Y-femLEcOJh=@l<?AUC7ejP\e^oglgf8$+;3..^F?d\&HgQ,)oqbSjh
hl9Mo$Ln=<Fa[TPd%T;/K#6U"Wl,(_[TJSd!.8FhS]AR$TSTJh?0k(HUp9,d%L!O@[)':USGK
__h:5Njp>iQLiA4Rko:-amIiW!BKhAFT+MkPM1&i_S&-_>35`0:BQ3I]A=[KAgWl`"]AC=@!M&
o2l?&\9?R)#-:gt4KuZZb>g0H=/LOaa_mG%M#9E.%FmY573FCUpS'oZ*?0j?jdafi1\T9Yuk
NJYse7h_R+@CX1f5b:]AUd_jEM$.L8TdFs?NhPj+^?]A.I]AJQ9o99aV5E0%rMGY]A?i![k05P8a
-m@kG2J]Ag:8RtI=;Df=khY%1D'B%rK/8>s6j[+]Adm=MH2u_HTF0`qPEpp$4\K8V[p[!:-Bp3
$.Nl)3a.N?6iO]A$s`7QDI6N7DS'Qk+H/gm+MG1%A8RQHe2!=%Ecm>(kdG!-[o%q_KkSdu$>"
<4i:jbd#JaKK=Qf/o!W,]AH<$WmB#H.M"j/Pi\,:&(<VZG.[%A3;ZF&M2[_75Z(Buj[ed`*WG
tRn"J+03p.0q@2KBXk>uDW:3P2/Hq.$0ugd;S>SGXIp2a,J$W7r!fK:>a.7W'eYldi[MrG8j
B-QVoub>&4Lh#fViBg<nd"$%MSO':s7+JD<M:EqPP9iS=Y#Q$$7Cj*<u'1PI"F[Zuiji4t!8
;Q@eQ13dl,V"N6TXQb?X\V4f4e:HV\>2%aTBnI;rtQq=XZ=mt4o<o^_qP.6r-I-tZU]A&iF*Z
mjSD3d+krE-*Sa0_Ia]A3Z/7G.doDC1\6?NJ`K^Z+B-A<WK9loN0eqdq'4[S(i-D*/Nm:;;0T
O1Vucp^P52DId+sG$>dIW<jbneV]A,jJ$glg&^oZX:t8]A)YX:A3K`Sq\&$+/i6XNc<G"O5B?h
%^PcQ`kjdLTF!V$`]A3AJM%ak4P8no-Uta21902[!@5pB,`;1o4'j$\s]AN<n:>jQ?68VnE&`?
Kn;>GYH5aPjaI1`L4aP@hos"YK*c<8M/R5.;>6NhWWtq"oa1HPA8a+\5E@YY8W*./3nHjk]AG
=iNr;.cle69fYi-c7Kc$l:DV<TDE$iG5q/`1aQ$mY,j=Hi9M"`^jg4;%\?air$OA*=[#f^NT
PF5K<pp64*j367/9MC7a]AgmEQ>1A*)n/W^2F^BsIVq3(f9MV9tbG_q,oP<1"7F)s<NZ[N\_8
^-Kp*SZlEqoV^Z.&`<45#HQQE'\`=$@=^%/^Eia+Y&H^GMh<TjVFlEfVuT_i7BF7;c^a7OWt
GMP]A1ZD`=nc[bRX`U9)#T`"&iRr'OK>m+hja]A0MtWJ`foS2m1lbT]Anq'"mUi?h:GP!W6Sc:h
Y&=(]ATGIB^8O@;RoP6S/^rVl)cW6<(U\&A6H54_$!;/A1_i,'6mg1K(F]A)#%d?@8,/XM"m:I
D!Ws8A7!(<Rk\=c7S8S,goOM+ek(LU=)%m;cYlLIW57_O:csC*r.F76qZg^J7^rmPiQ98Zc'
:J7Z,"C;/rr?\FhK[VQX+LBegJp@$UqXOXVo)\9JF(E`_?7Fq*\Lfln!1$)R='3GQ3r@h:!l
*aUg)4UC&`%$5hiCf4!ufjcct"_)7h!+fJHAYI_5QlH^<D4WAM3oU+hZJ1k1lM#$^<$,6npi
FSmF%&\M;[^US.I6D?5oV-34HjrI)(IG&^.pe:Wel(#)rZA>q>rDH;]AhV!Jjb%hEjiS'>lQ@
3#XV!XEH1Y0N<L]A=@G=S=>Q\Y,7(N9Y!\51_kg4/ge_XnDeH?PUF??"MZ\.dOaSGCS'e\*2/
jk%Bbm`\/8#''jo^\((*iIp&G\bYMrY"\"UJc=`hG(:+n.eGC4?O<UO:jA`G6hP6[cH@ANHq
%';qeSr=%*,sCW@cOKb25p)Nk.-bq(6rTo1))Y4!6kD5,^t=fr`%>6]AH"e[!1AJdj/JCo3ZN
EN'$L+g`,G3`YJ&I/u"&cc6eRp;X,F0GV,f/[9\f"MloQQ2Y#eD\WVfBCrB"J%=RI>>`)k.5
#8@;Nj;I!Rr0^f8lG3<-W1#KqUE5'MsOM(XH2TrtSY?kVefb=39sAp]AV=\3]A93NF;ef7421)
oq<H<a;LkT-TX>fqTB@*]AkM2D%e/ll?7n_7Q$s"&(WPi'n*9$IrT4"]ANqcke1[?l$Bn:=XS]A
%DK\of<ss%YiV@n&-R2dNf*R_*Xd<iH^%2Q_8gXfK[/494?]Ap(dpN!&VnMkjO8q^f?-/aEW3
M!g$JaZAf5tbA!KnrG2lDbX'L6-@tOLKTb3EO>JU6qE5T]A?\ldjq$hbtt=TsLKjgQM_Z[?P9
"l$kIqZKWq?1Xql$jPls/(eV2(5;?1@i2UqUKo?Ic3qU^Y-R2&Rm>1AQ;!IPWr<6>@,uK+Zk
(=b/M$1$PbU?9Lo:p'T!k?N4S8pgMK#6iPMplAb=>j_nL;pR-F@8\+#GC)/bL\QZJ%eXO[>B
[brVfB&d92Gg#J@#h^!96,ronk=R2@r=[tepbNT)B+(39jV9?ONnddFekDn+jB3W&J0ao\@g
mEeWf*Q^)rCi]AVgArX3>G'lVUQhI.HLW^Rd^^_N[*YF"PdjQulJqn-JAjlCr`02O7HF,j.AI
hg^%X%r$:`!%e.!C*QZ30d[fp]AT^taRb[`W&K$Bd3&He(nE-EOIdRbP>h(8U?)GE8'%&'V>q
h\@TuocGFlIU-nHb2W%Uqn3$rZ?(G1'mY[]AGN0Q=a?fkUG2,AHh:[_IKt[7MpJs)We)1gAJh
0)d*el7sHXlaSq&^==cntcXIrsmN7ZoQ:-.]A`"9Q;,+>$C,jBS7[!D!=?=D[E00DH4^bQ6O=
AVj/a0"4<r$S#H)cnq0:5lMmAr1Jc]A%4YL3p>;Zc.;;\Z]A.6.9oi)eVe+]Ad=%A/:SD#g>8:n
\9f"'%HU-=7u$bN-g:YeMQAR6`RF^5:b35c6Ia')u=%Bgit(ualXs(Qi^?(A7#c8GZ`CE%Q_
<e[gc:Oi:d*[dhLJ+K=l`IE0F#:En;1u-u?[4D`dbV35g?h`/`HKDkHfS=DX]ALq\M%&@jBWu
+TrakkRfT,Angl=q\)2"ri:>+mr/#/4alYhQ9sOZaVYd9aJ&BTaa^jNB/Gk%\7b<$>KK>_#/
!e\./J:VN.fjQKbN>ABDC3"L9CctbWj-#^kT$OPU_0;YKdu(1Z<--OO.rU)_#TEG-:Y;_Sl-
0rq_3(P!I(AR39,]Aob!lV$3/WofANO8h`@W^K(Z'51YApii$6DJeu$;@r*!eE*]AU#oT#&<l&
*`Y:feKBF^c)2uF,?h8[@9r!YskK4P2h^kJn2-#!d6tUfTPo`d'gcV[7Wtsr;2IloJ<7SZE,
:XgXSe"mI"nKlF0*?K&bX2ponu0NFGY!00SuETVQ:6rlbn1(/2Y:9&1t)#G.IX&rQ39$1?%G
H(eGCJ&!=i'(bDVNQ#)?kG-:i&G#IapK:&`I'Q&V_hi2Z3M$[r3A-@,qBY@=a7Lo1L!laaJ)
Y&&[Xj9);l"+7l]ACn?1M9e!EIL?p4X1n(FK2`U"ls.$CQYFL-O)''!kc8F;!;2@@&itsBbRg
7Y00a$?Ch'TlJVMHH#+Wf,Y`8F..jZpP!T=^mA$Ol0U>Dj]AlE83HCp>5RW8W+M/0B1OKZe'm
Uu)XLc>%7.h7<4q"8.5E#*&%5]Ao+">`i4[3@t'JW>V7WOZ[lGlhTnq%T=j0%?BP2$1'/t\#[
Q&p)X?Qi-+Wh-4@1a1`H^Xg^P4M6mdt\O"2r7egsrpq'7ed/<A<:Ctm%P/;tmJFL7n9YrUK1
JNP'-'4YOT`c@m(718iSd6c@lC"(Beq$:Ch\$D/0P/eV>.'?Lq=g$<bB8Xka>rOAD87.[Jhm
.Fs%@9T)7fIem6P1<jDWM`r1]A6?UW>.8[<Ef/E^>!LgM!K+"Bi15NP(,a'P(d;D`G]Ac#:")'
%h)tON4X,dO,oe4KG5iSLJHJb;ihX%#0/8gIr6`IX5ZKupcZ6(Z;=Amn:JYil+u5gta$`0m?
Uu"aRNe+8`eg:`7Ek]A#/U0Kl)@a@f&AQW&h64IZr!9tLJt\O]A#'a$t+SIjf<?CJU*Z*3aMtW
SJ15<RC*OS7/1\m^r),s+g;kt<Er:IS9niKEQ5Q3DX*50fGW%f0h@_de<1O/hchL&69@bdB,
alrG<i;<\8=lM[X&VC]AmQ(0ajJc7=2K8GkKBF=XsNbuS5)U`0RBTaLh8g$ran&(Q>6uP5Y8_
,sSSALR%'rPLRj^Y:sD9Xi(?4RnJG?CbQCn+-cG[+L6+cPQ2Nq[XB`m:;2V-GGKTTQs+^8-!
DHqU9<Ll/7t*-Oa*B.dD&7bF5oi+uoPq&(ma3<(9R]ApYAEQk<N0J:h0eD5=PY<qt4NG[rG5B
]A/o-fXK>%n6=+Iq)p-U)?bPSDp^0dB9%siI.9c9gCM*Q3VPp&eNXW#k=44m1_'J0qa]A.C`R[
g!4u(uLs*1K$Cq]A_\4L@M2c@3unbld-IN5#>i:&N/C;(0-d7e7qiO2)mE:?4gLc&'[NGST#t
hB#*?o;parf^AV2@Udo3LDST9>$iG"E1IFd;LCTRF@;]A0Guf=5Is>G-U[-SXfZK'-5BD]AHhn
bkZQh>Rr1?P"[U<'fW;c)=65Yeu#>UtigU&YB;LB['?>agT^H:[#R_#,G7';EWSb$q.?)k1?
5AD\gm54tB,rNCI72\s_/0YkMXMVkht!=jf1@$8eZAS^t[DSKNIB1&k.`KTIcPEXl2Qk*ue2
!HLg5[.qB%K=S&f-@Zd<^-??W59DH6:VS,I',a-har>S_9JpbE13"j(7DgiGh:ASgLElj**2
^:?G/[M/E1%T]A[WcP]A0q%;!*$\jr3$5glR-QEp%M>`(n_`:dO*4)RoK#)S-_[T&MLsW6SLbJ
ie@pmT$;JQiLBB##r05Q"5UZ0mcQ0DO,LQ"`\>!eXOS9HJ6EY7@\;ZNJ'!@?4!D&0d8DD[Tm
FEONNkTWajJX_6+dBfn[cq2dPt`\nEQ)!]AedEM6i3;:_3RWc_N6[VdXRtr2D$1T"=]A78AFlS
F>&\C\ctdt1,>DuWn46uNGUFNVHNb^>6,sq[oD]A_t^3C9FA%OX!$>758R/pJaI5[,I7iu7:?
&?OrMtOW;.a?H5Jpur=Tgd*YDkO*1,73ZQkTKoMIu3E3<2Ji*eYV(4+#&OWa1:.+ZaB6:,e7
=q<M`mB<$4R(B5"+CAN]AsE(GpXgCB''$$hWoZ)a6k:VRAO%L(f!g`Us&37p!sSeet#B[R9Ce
?4Gf'k;L]A=2=`t=N.KUs79,GX`WeSi$46l'QIn+-r0/ocbkYOB+ShT.\8N+/JmoMpcgT"u*g
\q#BWcf0C/,kK,(`Y<oooQQ2X<m@)&h@SrI>87bprY*&f;tfpI2o"?G5$d^@ZF>%#L6rZ`sg
o6Q-2uD4=(UJB`t''Z^m[0$:%#6E0JHQB4+iOR6J*)@nlfii^O%.Za]At[)>SD'O)DC%/*I8!
<V#H,RgM<^kSb;m7;etL[>lmU4_h;J&7'0on)kJPL0!gFF0e&f$W7>=)E'\3UW\7Y?9Go?_b
!"B(0!5=i;<)Ig]AOGAT2EnA+j-<j)UD;nrbq1d^uTpgnYODD$"_'1T>FhZu<^jfNps++sAi,
f!Q"$OKE"c?/7m^W)(AmdmUlBlInX#!Hk[)rlX(40"EeBB%f<@_N9FBno<8o%\(i2d?+?s("
[XQnc:PkHZJ61NIVg8^Eu*q%lZt9k$`M1oFJ..f!U.F"H`e=Nu'"*59!Vl%P%dCQ(+K`'BC(
k]Aar\9?!,,7cp/B,V3\:FY"ngVUgDBZ:"?65:Eu5raq-n=q07_^G9foseTm':"KpLcX[VoCK
*mr_"!9mlNRp,;<jP*:oK)Y/Y?e\[XFj94lWhI,mXcL^*ERqt1#\.?2V,$PS!-9BHup70['G
oB,fEk`(^EbR`U2Gb9eYdJEqWr/k"(:*k#b'+X(AWh*VED2jG584bJmVI6b=0BQc&!H_o6U.
+EZ0Z1qDuCa7Ftpr.[-,SeT7Nfj*k%R/)Z`o+MYL>nfVm0q.HIl#@lVpb@Pnj6AM-?>K#pa_
u(N&VW[!GHdY[?`b%gR%58WhhGJXmk1?_?foj?Lh!LITa.Uf<8aNYM4;6E!so-%@JA$=fi#i
fg1c00N)Di(Vr=^#&_C&Jn%UnZO9dtNZ\Y7cG95]AG>[c_n/CTG8R.LNR0=!-9[0<.iq4):ZR
eP#0@^;+rc:^s%9R#8>+M\$d,?/6lB$YYDIXF<T+o7G^Ai(Q0je:kA#gtBF,k>'lImQV,EV=
"#;I]A=N-6W>C30H@1+OBf8RX3?rcSSU!=g"#A$/EHBO'`t]A=^=4`r(&Jnp!6hFL;QOMX4f5O
kbIVFgJc"'s8O(N4[f1fei]AcJa[B6\kO9bj2>IfJ'i>frEG3mnZ\.oUWT3*;%m&Ur-$`q<h'
.e<F7V^CrrN>?U[Gd^CC;+t^)Pk;jWhi"*iDnT@S_]AGX,`HcBH8XLVLK]AD0G?Z@Vd;'En+uq
W=g\\I(#`k_D87XojqcrCr"lBXF&d"[4W'[2hmp!'YP,.89/sV99cBf)N<Pp`lG`(EHenWh.
Hof^la[U"b^GjVQC3`9]A`W_'[[R(-WI56Lf:KR+k,>s4d.5(1RUD`A(3slBaQo8O^dhZsRA\
4=]A>h.6Y5)Hl523BbgoNY(jjO"(Ij,/5^='1,r:.@4@$9g\r%,S(g@V6nVJ"oZU1imePKiA\
3Qd/UDdX;1c0!.3"EeWtNg;bCXo'Fb5_i?1RUT'TC`7#n7t,=J><,*o;K`4Tq&]AK=5ZEgt-6
&6@1*Mt]A=Xm.mK=)E%Y]AnVYT7!?UDHE-V8!(OEX@jq!;!3-_n8G&3s$+]AI`Ap;,#qb'BU98f
!UJ2:/S<%6d`98DqjQXtaXu*3VLj@4ij='bhRq5.C$K&;S?EsVLlhgFVT^k@.2IYM)?n&08%
m)#<Y9#_PaLi1N0M-/7+t!'=,qlO;*)NI$r<cBK"_X9<$ej:8,M:9/Dn@\D@1!d7+1O)/RX$
Vjl)&ZmK71(6o1^nbe#G9*ULl=s&.-+:g\:,ALWA7SD>nFH,2o"aBFY`*^9o#sA;,f#+^FE\
V8:RlFbs/mZ\e!@>fZ7^m(4r1d/uuu`C!;!2uro8a)b<g<_/X\Vf+c9EkiJS,P^[M.!,\X9*
"9WURT&n!#O6-8p7^c6<^nJ[l:ef'dLgs>E(EIO/&MV="[tJ7KPDt*-<A4eJ*baHlc#cPJpL
LYac.tV&Bd!XtTR[$<m8e2sAYE+9+eG/W^@SMiX53J!h6h`+rEJh(8,&.$oC&'K(s!pZ:+qr
BKdY;[2n"0\bPMX55l^b;H22[/.*#N,EIdZT,V\X6,&F\Ct>n.5l(93C%i1]A1_f_T>)@lY./
,ta7oP>[TUnI8jE#c0DLpW$gun:k!\g5T5I]Ao6"4>6MlLiprU^*Edu@??5/5OEam+:7cM<Un
%9g^*0pVW;]Ag1nd'5GYi["``.9lVuR$b?WIj/,eJTD;T:i'E@+QduNF)O$>'r&t'\.M.S>i1
Zj+_bXH7.04>S]A7HjbM:9)fe7A1;k_D!*dHuK@`oi42^G+%LMPX7=$9e2EdMB`A$s]A-&89"K
aWNADLppBsH6?`F`I[nL,V2ZQ!-.\C=%6NG6RM`M_#3X@WG\C&f`L#;N/[`0@p![.?"IiGpX
d;ZeGN#YW#(:T_?66L_(,f_eW=I#!j-u'nq`1lq;$bqa\n8/N=oSTE-71Q4_$(/X>6K)9DK+
]Ap=!H:nI/D<eL=</?46NWX!+J*7`g96[Gj]A_KTHQ5mLPifN*e`R.kl164BU5<hk@kG)3ARmC
M+taf]ANU@T%O-OGnV#b:/"'G^>^#j/'Zg@>6\f^h_/d^cK//'o"+t6qBBV^$,-m:,b%;@24,
5?`XmaH)FNoieh1%sFfT"PWQY<j-I##7I#e1;149b8!ID]A,IIeTC_D(R]A<4Q-a8,`dG.OiC8
pGB"CG:U9b12qX*KFt/7TlFERJnOX&"m0k>/V[V^Ln"M8,V.X)_5t8I,J86n]A/^4G9O2]ADj,
`M%@WI9++f/fuG^hqlKF/IJnA,bdg]ATADOYAkJH=KGl%.7[lCX=:8WZB[&W7uIUCkeE5',eM
EaYB6T1,5E4ji!gntA5c>;1nh%ZDr8^OYMHJs8$3TMK83L&34P]A$2LZsYZ/S8K6NtmO*+2Sd
Hu'srrZmWDlEsd$jT+%AYa!2X[f/JNohG)@bhI-6PGj7`O_rG/fKRE8.gNd94s&=oU40;L#E
!/gd,NDJTH,,V@KcYDGXEX3iRn?lWUIp:4r457ke6LPAN[]A^o[:i6fA:><ZcAY';C6kh(#sQ
ce^;nc9=>oo-i0OkRO+0k`K$qJ@fH+%Xg7A4I8'^JJRF+V=a-Pd2W3pNPZ>_qgl-%<7ojQ5n
FN->gTV34GAgnY-"_A/2hoF:<Q(`F)'cQd+h'*Q=4ar45X)G;97qkl;&d=K=R^4Eh'9i)9A&
qlQNS$/7E9E4-aAMnG[KHZ0K`6"j?Z[fG;d&m3W6:@X2ba2ST;h4d;[7]A'?B0("A*'sLM'q;
?[o!4X(::q#S(rtmd'G@VgQ$U`aF>uA`WQme9q-3kco?I/riNW<;BPO/?M5Z,Lr>[m<2S6h]A
)g!Scq`dSZF/W85oDV?R@E]A=^VAa\*phE60FJ_mH-L6(Sq*%4&*j[K?Y@Y`nB=:0u\\->P@r
i:oh.C=q`A6W+<iXmJSL\fjon<GQOj.2=FZ:(a#DnomI>a4E0%l\rZ,XMt"Sb)EG-a+Oks-:
i:ZG%PgW&EI`29_H^=OKXRh!)<Z4+Ed2"nrB)>UH@;j!^g(US.]AL2k,NsdVG.2Za#I(hFS8L
usN&gONP*4r&W.@K#1lrJocm0$:8U'nDQOu>B0e$%oo[bd&YmR1(VfdS:(9b$ao=0ETh@&)d
0@mYNA+Y?+=!M?N/@'(eUigh6lc/JKU2=,;G3.-5+E#U*?rNj[T3nYmO1F-#duU#gVB1%m_I
XUMb]An%X_6Ht1I75ZRH?PFA6ke]A)_W>4.I7`>s\PuU5/E$rhG"/0%020n@RH/rNrh2V0bq.J
LmC0d.JaU9p/<!T`qn$*ZN0]AX[cI51pPL.ln5lu+-_iI%*IX)[*W_p<WBtB#6dd"[&TOP^YE
iKB#V9^Ac)D;2$M*!#>EY']AlAcdp\.nMK+3^5@NrDN'Rp"`[>WrXaA=At`"7aA`geLJUbamZ
0cA)d.c%V"QYQ@l3=h(![;j?@a5DpmoXDp`iG$36_<`nFK0@j]AX,?1RpK"0GudI?UHaP\Np7
%t.?MSuNOM*.,4EhPakoGaA1M*>tq(Xl&JT'bAc/O@rdd[jAg#^tn8=]A/utoE-%ZEY`#,(8c
,MKGQ*Ir.Rf=B#(2b[9qZ(\c1S7`Ue(RXO[km@m6A$gB`q=)bGH6XdVa-:$^ht\D$uerB\2[
H5q9;8ZinDig0!AdN6.oeYQKL+X')sar"`dZ8<Vil4<\V7Tn"#AHMu"1NF&9K]AC>[fEI8qhm
L_/J"M(X1a@M#YqDHkWQcJT7U@r."q+H.nc8N#>k"gL*V6Z3qOS:W5QBmh9#$gL%i5]AUB#jf
a$n^)A@_>,",itmImb04;q4IS>qYmeljC$nZq%M581L>Gp5oV*F$6>9R2#56_dD57IDdS:5s
M^&Lq_M!kZjh,`)<Hc*R6$D;+!#bfDC#9r]AjO^N5K(LD'Kdofm<s]Al^O=hrppJ,C!+Fs)27?
eu:Ue-ak#Xpc[#Y9`t!n%a.kV1uih0\<hZY%eD=i:&jpW_r8n,5BGS=H-lH4sUVP/T<i'*1j
_+QW+&Y]Agm8qa#!l1bfRV9<fd'fCha!_2.V0%';lb"g1aMlLk*HMXN33\EuhXmp71Y:;#q1G
qH7/,jmMOE%+"FLL_tkUnOF5bqV9H$hHDGYboFR!,<Bo`clOcA,cRRTQ!VOmRSE$moN)nAXD
[cXUq9#9o?.)l4*_70lkD_h^?H(i79CeZp;'fmI.GS^$1KZdODtt(#Gos,A>fm7o_d:iB_T:
mVUu=o+-osIspG^NG\<5A@uHu&eA[shpWV*Xh@l%>.Ib/mpo7ujL/UuEBune>?'<<qmHj=H4
Inj,YBcFXA;+V)t$RKAX1DLf(B?]A7+]ApiEVk!H[oI]AJN=97j6nf;"oc,2k@kd0pqQ@s';r!Q
YEP_3k594;&3/n=;)o''*[01$SeX.]AI1rKL=U#L@!qT"@\YF50=2H_@AB*,>XX/(4)?P%s.9
ek+bg:t3K1^#Xu0iCo:0"d\,(n.<a/Lc44NGe$&CG0ri)f>fB1gDu8Rn)G+5L!S':@X"L5CI
p.hePm-B3lU,Z?HnlZp#'akG;oq<Rj!P,N8oDka2LP8@.>+e\\+KiiZ"]A?64TK.aq^RBc8i4
J-oh:XEfRdc1U@doT0LQki2)@[[@:_qV9Ofe$ZGrF?sq)^:<*-.64t+=ld!qN2i*]A=LIGnr=
3p"UqflVK-i1KC!@'kOolLbP4>81p&+\[#Hec+@gWe"DUZ;Q]A<PAqk)/`e]A"je"[A3rW.O^S
($3\s;\P#$CqaY]A!$-T(8X]A,bUq6+RD08h5<n/k%+`8S.'Y/b$BFt^7sG]A-^/;Oe2kJ_6iZH
C%t,mqK[f?B74-%`ou2/Rt.?i"8\[FJkgaotf`H&T*;.8O#C&`sV<Uc8fWA%9XT7VWZX?5&h
(2Ns55PC6`&%7!/>D/kXUufaf_im#'1,^R'WDQ&sJeiaZ_uY9b"ql`sLn3$0GGP_fX1$WLp*
Bn6na>\O1;?s.t2`E?b]A\Ld_5Gd*ZWI`3t7B2^=Cr5LQokhe'$B2mh='i'i]AGU?[_o!C4#M<
Xd',Q=L=cN?q`ZX]A1&(6P(8i?5:^Yi;J^Z2?WAbBk\^VGpk9a@DU453Ts;Y40)r!t<gPYG>@
icbbigQ%XaQUpC,!el1&4GO#2lL]AGUk]AFJ$oP'@.'dK^L+F38p>FdNoO,!2qf@5d@Rp%!>p-
HNBRpk/(C&E4WBZd<BuF1^WUGs%DZ&A0FdC1^/AQc*f_VMAJ4dS+[H`C67'o]A=g9A8T7pk_u
%7P09??L]A.hMACiL4(k2dOm)UE-d&cD@aUkJ&asuh(6Wq1M]A/oYKPc`[62FXeDAUs^9F0+(a
/UER\=D!59Yb]Adk@oR6DWT!\u:6<cfhSroH-um%9GRW-^=(FTjOYbK\Ddo?-KZ<i0+WJQu;%
#2nT$SLSs#jDHOT3dl`tQbL727mu5FgZFmT3,gIb/oXN,di/)^,b*HZ'inMpj!nraSrF69Vi
[P<Y$'Ef9-0R/V+Y5mmXF1R"37%TuX_f_l'E_N:!)nu,(8,>I+128T0pd#SGZ7;^cF-"HK.5
7)=J1\[G"mB6qbc1R>:KaTihWpqTT*thZ%G4kE=ddD&mHgJkdYVq[s\O9UhCg,0;&fi:s$=B
R&4;IfLOt>_*VUAG;QHJ*N8P5Z<_Y!^DKSZgj8(s@nQ5XL9Tmj-]Anp=4akXX:ug?G?gF$]AZ>
<]A(A]A!r_MYXWKU^bG]Aks4Y<Vkrk4?4>RL+f^QU/]AI1O7$2WC@Bp&XguWM_mk-o\5U)+Q'k=`
mOl6<[W#3!+H0ftBW1Ac'jAGc=@&K:(KU#KYST<[ef<odGI$OJ]AeZ.$2lsH8@69_F4$%KIrd
$@d4;<$eYhZP^fI_68un+,ND+q^PjDL6mHKFOS+&c.=B.`eL)5He,]AA]ArjFP:l]A<e2^d\k22
!oZ>]A-kYT\-AeW=.)Hip3uqhX5NH0?JmZ5?=XRGZ-]A43Gq0rl<3rN((4Euf&UhB70mF^@*1>
MbD/2HgC_J[)kEp'@ort9gUu]A&)l=7+=_G"N_mg[g3%4!@/GMadG`sm0AgOl3O*)Y-rZdJ"Q
.,?bS`L3Z'D7F;a_`TXcK=Et;PW(ONB$P#U/FL;OC<R^1_[bm)WC!8#eqWRQ,=^=^E1L$MTu
A,KQ[rNYjn7_Ll6(_h9;3ARqku6L$UH`Q.2Pt0=RRh>\lC,)+4.%98Nc`:0/*rCEF_H,(sIt
[[&D,F)SP"h/'oVl@B"3M/tLcUFKrl7\>&nFV)F-S\rl,mO,flsSM6c$qBV,QnpDPF[b8cko
fO53N8qZZP2kc,<D#_R?QDA&\[(R$&C72mGl.XPB.P]AL/E6@^3%k%1.*jJ5m!&)-jS8p5Umu
%(+f79uenZB$raRJuZcf:7jl,+qeC$N2Y!mUI=8'-/_LH;[:.U3a4LorOVbHoMlk=qu;_/tZ
%(>_SmhcsWgY-a!cG=q6.!MFn<J..YR$K*Bm)aPiZ3Yp!*V^tYV>\[]Aci'[sOUFn/*,??DQU
(jd=B0<\s2\+3p"@25=giZfX5tVnp;\8$k/sJp,nS\74Atm$pl>.RL+b'!AU@=fKD_%*ZA<#
u`)p&kfWn5cSbB19bLL7<&9-!X-2U[J6F2Cufb-@l,*gEcg&^>'"G>QOP8?IKp7%YVOZl=[r
DPCPZPo5&l<>;d3H!F:(fh^J#`mgnVBm)uF?5HuE*]A^V9KM.Kc+`#HePp4"s"pDY=++4a9$-
RC=\C%>$mLsb:EkI^_q%,a+'YIZW;U<kV=\nidZs>.+Q)I+=lVAsWa[!sO#(cO!Q=)%5e)c(
4\Ym^P@OJudJejQoA+bB/i:%U?ZR9smlUpWaT]A*>k'\R3H,=)'dgh0\`a:_tm=,P_3'eO5=G
E&XM_<<l<T+f_(S,%TAqe\ZO7_WnDP,W,)+'Cn/UqEU\5t)\W=!)]Ap"Rsk'9/$ad?)%#WT??
t]ATig*m6!l&'>q.Y5.1"-0f_q.<ugSGncF7Zj'FJYGg6m8r5!BJ,A4qS2d^GKrr2CioaNria
07o;D%RkIpS)","b*en[JCfrSt`%c\`W:"PGQ0B^SPKhf\-=+FDCk&NR&6`%J[B/36c@ZZ[*
"*(aa+iU_SlZ+&mY8W717J5D^CRaA?"T^JjWQ!erH:4K/UYn#II%pFtfsUO9klqbmS\AoA`t
K/Z:Vn<bX/7X03i8$aq5HCiQO^b!k0Ob#%UFEa&Linq0P<sR(O`[8'`5=61aSIU^H?ZTk]A(Z
<W&HMVIVeF@rT1:/TQU:>13#ALY/@SmP<X"6jTU_Wb*B\eb%Sd18>Rm#1MK>i<oKeKWq7)YO
>mHQO50gI?=GCF7?L@*!+e/6-4jFSLW)WB4j^>5'#cZdd0R68aEP/lB)gHLdlidg"%R6[u'!
VC^L%2IE[Cjd+aZ35uJ_,'*tQa%RVU0FMD@@GQ,3!sr6UF*'Sld#Aj1AGlkqk97$]A#@\aEd+
DA@[5*!#(.lp^lkuGGPUdf!7C(??09Oi?+Xc+<J@gZcG4[Hi;*)c6u)$t.)lB]A^>$u1FIRgX
pnH\/(T2T]AW=gg>/.82<[MoHu'cF@k]AE]A_IY<s(4l4_!t)eQTJNaHrL#au>@Q$4,'0+rU-36
`aK%)";)!oK@;NIn\Qi;(Xm&,p[qFjl8$Bb6BS<sa`S4/"RcZW/O:^8r/BElNTn,h(p`Y##6
$eO-rUd)Ge?JXY&gR%"4R8;!/,1_@?**Ote!'2ps;b"+er]A8?43G@\84bO=<4s-,X*lFWai+
TP[VlH9t")kb+`:*TDf&\\FY)-du76YJ]A'LOKuQ3\+q0WiA[Aj]A#Jp/60;IXNeF"R4oS'eA[
M[8a3!tH$1X7*Ej./8kRpWNL><W\N\,&!CY(VTqPi\&35rqefpU+_55EIQsL`7K_H+EE>20F
/'#j&RQ;N>Y$<LsGHY,;rNVSFS6-gQ:J2iY,Sp33jma>Qq&TTXoIUMagZ`NlODe_o'Z`BL7u
!\14=,>[IH`888gHK>6e<mC>%a(e%?YpUm&o2mRahLoOa6%T,88U:XK_h#oo;t"EiG]A`Ys#9
2_TBmT\5>6%&[-Tlfu#^&h'$JJIq%*/*t_!9J/cK(15F#G#KZZqR#F-A_.5F.Cju,n<TO0lq
n1KhXZn6fV`^3f8t>I:BGTW8D2oD[R$cFXIE\dQ-;t>hl&egUlre.W<#[1"3W"0\n'+ge;Ti
8t@S`mn/CIrjNJWL;26mlrO5`Rtl;pkQOoY%pNi#BiLol.0^BBNA>'<=CK]At[t!0aHnhM/dP
"l-N8jAik'eD>)Kpqnl:HX*jDOl#065(+?>>J/54ol%&54%B<REV$]AD#LW`,6R;WX(g=c_nQ
>^/G<*t`2O$5iK7Z$&dK@0A=j-rnD;2J.fW"\**fmZp0$tdfa"Td6A_>PZq@hA1n^T,\8kt]A
K?]A*^oMj%lH$J-kT&1P)Eh%5ulOa<0YIf(jW7TWq.QlsHJ\2/7ElNts8\qi,:oK-o=nEu7\e
^`'gPcWX^C"*#NAu_lYocu&N@$Jc<]A@Q3d5o'rO^qKjib`rid;2X<=\sV)5k3(^J5pX[[:RO
p0)Y>]AcM>8HIEk>>AP;675S=nQ:&Iih#inf)2^Pp'[gpG4[7P4,L`5_cka8=EXrhu;Q9:@a-
l9LchA>p#IS&T*rYf9e5\;@_`d+)"tJR0?[,c$I3gGE67lK*9KA6;,b/fj'@]A=5l%97HE4.8
/aK'%%`ueo8@VVlW>Yb09OW%$$aX=e3(m<rQm3_kY39<BZo)[g.*<[%\%eoq^`Fi12;*UO4,
-Z,Lj'KV/%5`%[8=HRI1;TBtKSWk"@`/g=WXXP,./'[MA2!Bul#5XS)[?UqmI`[!k4p>elO?
cSZ#$oP!C"45nH<DK([,jiI@!;,^G>sq*mWGT7G38/$P]AEI31+_AggclDi:A3Z6:htJM20>X
tSLCcm5ZTam&d`h/IHB+-.N[B&8JU*HTDD^j!-'FZ8V1>-:E$\Up8Gh8#U85cSH_Ba4Sj(b<
k[c`;`,hf%,;H&-o@jY$jY>7q=mF[pghjVT<&&k@:8R1ls-<EL`R8'I<%73&8)s$_l&gj.Z/
.rT,<$mGD-+KOle0kb#>gFL\k-XXAB<ITD^h-$N@)\R;n*>'2^g;HItSOZS?2!sM8n\qnMZB
j9AZZa[KThL3U+QeOIMF0eU$MsV1>>%!Np%:Ie>95nE14u(/85MO#7NJcg/sT.jVqmS9Tkb%
's!P(&H8J$?rV=G@1*kR")h4po1rI`=KZjb15XD=^VSDW#Q5abQ5!;VeG#5.au]APp)]AXi>dA
1V+L?Tfo*s6i=bV`Ggl-9)n5PJ<hX#@i,!s9!9G48:G<TF.ENb,L7.\/=`:M+X9KijPm?KT-
g5.5.`1m:'bVY"D1iZZ:rhpT&"V7FaM*)ZA=?=1gY3B3_O8A=90`U%VmJ\@-T6mWi60MHu:S
Le>q1\pA)aQPW]A9E-!%$8"\`tTT2,07uHMK*AN+%b3_ZBSa;<F;V-Z^-4R7qF>)lWe3<IJ'p
nG/I[d)M??/=$SiIm5N90?SUd$a>qThAo57PWN=dYic$M1U2LNeo@l'KCK$=[!+4Ze-N<CbL
9_K1oBK>"_0KM%bmr,L9a\&/lJ]Aj&Wb)K)6+MouK".E'UX#7L#"4/]AG0\+]A5k8Z&dQV8&O0S
,U:^c*i6fhM)/M=BHe_XN6S"s>%"OG>,1_N#>01":cg]A6W-)P%_"ROC5ZgqpnD@<H^9OC(n[
JdU&r/A//.nMPPd!&S^?h0s_25?;XWf94$/+RoCpM>uc*4Q*RF8@Ese;"9p*W0(BSf=PiKP2
35eI.lo8A-eHEG=A6N=70g3<Q3;#<0*rW$LPS)14iAj18^VHD]A4f=4MLan>NpX\r]AEZi+8q1
tenm_<i-ZaSL]AVn*784SJVU<VPAA*\bmbPkYr1+#@n(2,t(kL%mgF+Z!-<H'I8pX_2P1Z1?r
V=S/A5@2?i"Hf@Y:U07OW9uDia5mn$*m@pcJFX'\BJslo'4oVL7-B#?@$NcW'3(WP=@Ee3D[
V"\sp<kk'jg4Yb!oucag=>F,*,*lC92.nQ-T-/)CEr<qh_X%M&\KTBQ%:YcV<gS[`,;NlB?=
`<2Y+Pkshc,I(6g9)JEF"6f14\l$/)Wif@D'GYh3F5$Qa!Q/TY[ISUI%L*\<k:g_X(:q94Eh
j"crrV"R%(J9?]AK6+7L.k[;hL1A,Kf!_E.l*Dhj(n[3bVQHqI]ArPcgK<]A`i*OV%$"%oo6OZd
>]A5]A:H=?Tsb`KZS4j]A\rj\KFA-??6?[CbX33nnItQ":elJ4L8!#7>dL^*a`aV2g34oC#-ml?
@!1ET-<Y!1prtOAfl4*$F4Q,qg(;)n(b6kHNUEoRX@Fl,(2SRF=>bslAM0"6uuoek*MFu(<9
c.8Dqpn8[rD?\Q:Z1S\i(A\fut!DY=%onX_WBL\FP-(WL]AUEV=U=E,kO?K.YjoRbt&n'idER
S^kDpj3,\NkG3E&bl`6]A%tF+p*=Y[6od#g+P8j^5o_kt4p\!rjm1dVNL(m^A.ibZ%(Z(dO0o
):3H#Ij:;9AIk]A=>Iu`$U67W]A$$-Lm&!KaTZ!:bK!Wm,c`Ch@7Do*0G;DA9!5Fl7Ei(;MmU`
;N,?adqVb:?j!$L\]A*Tg&oAf&h^'e@D7-+OkWX^q6DcoM9-HP"^it0VDUp?`_+_!UY!tJXJ6
?sMAhlS1R5EDZ'.u,sBaJ;2.I,+XS!U^KQY7>&8N#O:nNcK$0'(_IO.7G#O"3G+/SeHBen"n
h,OdtUjjr?O6bgq$DR^j8?LeB7fnmlCEOe-INGEt&am]AS:VL$"?'Q:jNQXknP[0`haDQhAt?
M$KafDneP=LZP:Hpe`(qG@q$U"hdohN>^*>^e<aQE$_G=%0%oa3=Ya:rTj0;/o(khDEVUOB;
G`88S_jm;`-3(Q.7Or#6c"A^Hg5T\bkuh@4YfDl,+/[60"^/G<=5bT,l2ne>/o!LTCElK*(F
9QUH<Yhju:gD"""!_EfFa4\@&=hqtXB\C'^od7R&m;W(lADm@"@I#,%2&+304/I(Z?]ArP`/`
rCP=FdOJMP^!/!/fA7T'r((9nqM^$F\s0%geTB8>sHfJ!^ecRn0H)$T:ReP]Ac\eN@@7@3^bF
'#A8YHJp&'uS>DBb)M&C?(ZrG7)Ic%`s;M,DT,JqZT)\m?7`*@d:Oo]A!3B?8kf(#=;0m]A(/?
?I[=Cn0J.!"W-XS/@&N4c9!slZP*GU3+O/Z't3Oh1)*TqVZ3ZKN?*^mQ^$E+7<E;'9K9'alN
i6#&RGi!Ye(Lg3l"HQlRa.cMWX!U]AH%DX6/+)3\(=nl>U(K]Ah`18NH[a#pZMR(kpO%ug/*Y9
\7K1F+OUdPGEe3$gTn$fD\X?)'ZpOW21f>b)^fPlt),NC&!fb=>+?">ofa'C(T%5"0(#dUV`
`s@'['-^Za+c/'a2NKAFAbV;$sLt7Nac"NVV93leAC*+_3`LP6)*p$$80SPTk:!X%1KZ>K]A4
]A6L@_&pYn]Aa=;;iMU#SN4JeAJSu5n=Ptk:5T"rA`=4[++;Wr[SUs'Ac\]AZsfk:XJmAb`AQQ6
ANr-P$<.E;5/L>KJC78tp&HM.b=[Q'8!t5VcY)Wd3-LQ:i,36C'J!="97HObN(=KY843+1%u
kKJHcVhM/d9A-AWWO0k<X7L=a2+#3cMsg0grYd=P/d6_CZGhT#5;-n;.5]A+c'R1Eac:kk274
sTjIM,lb7TnJ<Y8PDA/(=Q6Bm(83Jl-'Uij3!"oRVX@aJo.AiGcVQ0\/]A/ZNUePF7J>5^M2+
2.!mA?-12odo4]A?!*%.B&N#r?YhHUUD6\f0>=79MI[4XmRglMOfI&H_*]Ao)Y"VfF7e8SFV,<
$BW.9K&:SqJuRC.4)<OFtmi#-JObuM"%RB#a5XS+l$/"::g_f(O`V?5%feW_^)lc35iW[%6'
6g7OCpIV^ajG,(o*&6/6B+"![+CPG$rblDnE9Ho]AG'4hc(8n`7TJIV*o+m=`#Zp`U`)m!Qhb
F)d,hGrok19dL:(;?"fK73))$>5)j"1&/o)ann(+Xm/Um9@?MT^-2ZGNT/8_ZekC66;F9\kN
;3^:cB6>(u,U<Z7"Pk^CC[gH%OrJ)X_\>A%&^[3L?0?G7EM)^r^FPlU%>BIZ=YnsbB_E6!H[
2cVR`!rGa$`T/"`>:Sf`_<d6!_s4#6SXl.4lmW8mBaQ\Gs>9H(fj@[XXN<)j7P(LVgKl]ADgd
RuOZ3dtF(rV>:K<glL\5CTYl&Gbr^PgOr>a"_L.U$!/_j/$)r\P2Q,)TY<MRI)A[4C2de(pG
O8(.($g'IG.UAoR&gNdkrUgiTl-5<Vb&7_KpPeW<_-Z(Ob3cGfU.eF@!l>fpB^;qCSi?B,%A
aAROb5"-iuGWQn6o\op47?3Jr(LD6KfR7c?T=!=ojim9V,*3><;]Afl+F0da)?q&'qrQPG!QN
QfcHZjZ$CrTSrpCHf%(dK%&isDYHZ,=5oJZJTf[!8a@CcCc,C$"$(go_;J+/k>\64ZK.J.TE
ec"AHSLZ?%&8d=`!L;W"WYGW1Oh*fH4.(=+b"&pif(5Bdl9"\jJ:7/%V@2)5Q(2t4q%gc`'D
OTP5#Reg%=Cr<cX`WjntSY%2fsr"3r&@.#"c4VU)>0l.!/o*.6P?qpd;^J-F's]A^G)bJG#Tn
YdUu`CW?-t>pBM.;nl`P#]AsuiG[C^T;eo]AD/TWNIlHJ$n-MUDs@!]A_BP#H:bKOjG\aj%B1ME
mZ,B;tS>'fG&sB;Bq%d&P8\SrGg$VP_he4TtqY)e\Et1=NPYCq[i(O++4c=r^B^Vem>S1dZ]A
ghs6D5_)UOEs26&'ArQ8HO$dI,r@@Zk1Wn0Sg)_+DDU_sf'MhD`KjsuIYk&ci=;<"k9On<'H
]A0Q%\k]A^MjMT4(+"SsJ.7co`5:ttA/?7<@im<1We2Z4+M=E[%J@KZ/]Ai6Pg,<pT#TDj@^5lC
/gd_rU&1@hT2Ot*9SD>2`".M&OM!L06r-[&?;qF1Lpf;G2u7d<C9mYfN>i6[AeAe:;B"d7pW
q\MV;(VX>oX??sFgaF?64.R-"<fQK1O%Q"Yc1mM4[)ET?f80gXEc/$p@YI8C$WHgTrn+d.^>
(eIle^6I$O*kWT'9@H=mhS`.*4#'56i42r$^i/L\q#kR0V@On5/'L]AKY088"]A*rN!Sh1#0+H
m="EsIGkEYD)DFg1jMKZfHY1`"hcYF822\=g:F%-Om^&PnVLh^WA\eho>;J+^k+^=0LF1`03
nhX_DE_&cZ<CO$Z7o(S94kU'Eh7EbV673DO<',V6m9(E]AZ,*dZ^gnf-O*sC19E+,8PkWV,TY
hj8Tq]A=cm,raMK_7bHVq1']A,@S_\^t'BmH1T6e!>1:=`^^V)[n;!$Ni?D+H(!#Omi^/>n:ru
_WCW8CJLdDP[P+3P1CN.lOo]Ar:p]AF+FNMdXX>uBUMh.#H"^&&cdF5FA%@%%*d3%OQa$T#*h@
ba.Uc^M6"R4q_F03tQNis$D&'17+arDrgN)+rFGtPIr=j$R0JD`ZQ8$5?onqn\eN9!OaHZs)
gJiJ?>7kUab"LZkhU[jtXYm'fKr!$`9*mN*U]A6]A*Yp')u'Eq&mu0*n)QTSfe(Yb?u8N$E%;T
'`g;k1'AX#i=:'WE8-F";]A:1492ld)`U]Ah'@0H=daMsZjJdIJF/0#lY;5,O?js"S0@R-$S89
-p1$T$Tj&4$-1Xs#6h.?>N0?0)_:]ALKCla"kgp3SOP8>D$+=_uQ=JP!,tIO'W7/+"]A<_\)j.
TYl;2Z*<VZI-nauIZ%in"X;TXQJue$g;X:.d.E6A<@IFdld;+l\*<DV0PVu<h*;!s5A(+:\.
s%eI`hEO=!kWOrlaC\lAH+^gFYYh/b6,7i@sI?*tYc;T=89`8UEOcH5au6K_o6@^@;r`,n;[
.B@6L9BR_J9X+2Uk;i_:B;##4P76->HK7rUe)F[fOa4mrJH\(#dK'c?EKlHaL=!VBsQ7jJ4'
YMZP\"l,$7,.a=;3.Q]A<%"d4#4Pjl#Unq8^'aNko1+Zq&Q?@KGB*ZhgSk&@H7AZM`7&es)u6
IiWU+F0%+@]A-7m.V!.hn!!>MT&Q!7;f]AO^bt04!InP\_'P0Z))4:]AJt6`Budb8nW(7a%AW;%
R!"eAkhup'n]AntS0GMQg"<)&\2]A<mrHP<BT"2?LM7cY249ZMcl+L'GtAb141(PcAR2p]AnbUD
"&3/mnGbEI_g(bd"8O@5s3c`-e>,cHc<Z&lnJ"2j\mbhSe/o(@D5R3<.nc!;U4-?"A6VbJdG
*Ia;lO#FH>/LmuAGn/kdEhtH.Y"u=c<9?oqGH0*P5`.aumFCJY66$nur2[0JRW'T;89^F:Md
3auM/WSiVFd3(,LB42MGg1[G.^j4@NM.1e=6q#'*p(-K::5sA(Z*9+c[WFQ4O]AG`fhc-$V:Y
LlQ3==W::8Up^$+(RBu+TX[X>RRh9L:?BZ8G(nqFOm7TGZ3`Y>h=^W`G:Y\!Jh\K/uKiZ.Dg
s6dTL5JFh(Hqsn]AJ;]Ajb"2eG4n;Dm,=N%REA/hPjS/c88'7GnbD+n'dp[<eg!H&G)s%)9\DP
PiZ[Q/=1r?M3.g2LhD<^$S=a5%+A.S/\,_0^$cRc6f+&Ou0KaM@*LNa8m\R`\is8EM5=p?r5
J"[0:)0PZDiNhNb=3X1@\\b+O66aO2oVO'$V`k]A'\S-LT0CJ[#p-U<O4DGqGK^oN+%]A(eGTI
k)eX7BlGcpXC$DjpnRC>LenKr`g,[C/k2r-*s.ilU-RJ9h'<;?W:f!R^-!QD<Kc/2Iq8hM6r
Li[-FoeT;G\/>;jUP/"iqqg)QXd!V1h[E65DJP%87BgWG2GjU!N9O!X\PAV/eE5@p80ld^#`
!4=TPc?*RKC<oS]AXWV9C_V^GDTjN-4,nsn!hL/O=/ao\q.E8*!R$Cau#13'ss57H]AF]ASA*X:
73:'(+G:2;$r)lb7pdQrikI>6l4?5d.^AY[QK&`7@(,hrWf_C#0uYN*Vc3[%p3]A%/kW[><7;
qR]A-sCokV+p[1U5_XBgs"D'lQ9_62G=bK?/9IFtG0"."Y$8#o1/0&slF[%tEin:uL=)%-D^+
&#]A:O[eTN77.$2n&`PVM28>f'/Y!dnC.T@h/`E`N=n@F$b_HJ2K5;n*ucS9QH9(sK(M]A7HG^
/?eL1g90PIXa:g0FJ_-1t0`W*_#AuPVF:XP_.0f'/H\cf&<P.:c5I5^ikE$V(MOc"_2E:DCs
3e>4fUQA'8d6+Td!*'S$Z%G@"0HiW#=Zgh"$Al`t.?IA5fX70W=EcTSPICl82sO6oJgiO03n
3[sQPQN<,4c5&@n"m"'g]A!P,ZO\!fl233)abb,s,p/bbST_N!6Qb\k6EQn?e>:T.%fg_Y6>H
$K$3$6:,Y`%3Gd/eA6uK]A%9dsD!!]ASJp"&f6)WMe^k9\pKN$c!6;9*-4ZH_7uQ-[^5TF<)/1
,sKZN@eTGET`]AN$S"?Qg@?(6aj]AbqUoF%Rat4h9#AXt9.8Tsi:pbd.rnjc7r/N^=,<>1@S`M
+!_m0'adltjI^;ua*q\Mdf1O'k*qs?gH.1>+PScu^F-I.+&Jn[><WlY:J>$1h"KXdB<=`NXV
NSt9MOOa6^L.;1DjCh(bqAg]A>[]A-i=D4qW7mXD<]AorW@Dh>LG`s55$/!1KA>f?-6"$l:eJ'R
*s(TRe4qPGV%bi9'8j]A9qoSkZFg%n[J5`>@a%p(5"e^`3$ncWuj9W:VBp$mB0A[Se'0rWYq_
Ejc*.gAl+P(YS=fHS4idI=A_h9T62\-.fXXNAEBOPhs&)`*,*"m'L?@]Aq`SI^^qCEjPe$[Z#
GHnW\%&t,WpL^SeLX3V%d5`n$e,oc<T8F-Lmq5IC$GCO+SESjW<27fI",BKOa<M%CIAeF0lG
/SZda!:CVZlkm*-2l0#uXmW^;0`1?o338]AJ8>_+-m+;oT82"d.K"C!sJf![RF:S'"BUPj<3t
;c?Ug+$p6*b1kIrs1*tL1>K,Dqobb>E^9mqGG;m"j7!0/b=5Egi9i8\?'0-Fn:Xr28[`bj9L
<aYHUU\j?3Y_$e^e:L&T/*Wrf&^`GTPea5[677E]Ah_]A#_>6qh,/<N7ms5n'bu,QeSts)$]A*)
'`I4*m.U4]A(;H.`ii+YaKFgXU:eQ"k\V0P-94OT0Tb(-#+<p(=V%I_-/*Ndri-pR@M>oN$j3
^UOccUDqM8,W>a@CttJHq#L7j)s]Al[+-%\"UC6OOct$5lHA3:%0^1frjjTgpJ\%+.lHB;dpS
R(J#t3._*k'WN2iB,BiJ_CaN:T\9%p2#WN8+Q\7SK8DB,.9V",#6i\p84r^"1j6/*?'\2H%P
&ObqRK2!KlINc-p;HrrphlSMo=d8OD+*d$4IF35VrQrWNYN?r$lQ_p+JUMrR3MokW<%N4sj+
p&o>WMbA[2;=<5.[C,H#D/!o*RLV?Z/oD-p:#[ndGUOmU8u_=n5BHJ+(nq$pc>an9bdZ5DfK
=%R.OAEf*K3-sl!K&5WkLM%i"a=u]ALp.r_Z2=jXk?q4<baAT)n[4FpLGT"etgHL8)A6gRm'C
`N-Ap=[u$+U`8mk;ne,AuqNL?fFR;cqZTNZqF3L\ia'^#=FBD?NB49K&.='A=O'j6==G#&&$
C-e,$e\13R0S5JX#%ob3Pm$)HoI]A+Q2t`!'i"pO4to=Z*qcm'u^!SZ_thqWm7jKNHJna1m:L
9S\MRISKEPZ0?t7i5f;E/*Q2Ha7;Ram8]A:>(p0QtFID6Ymu\WbcCugp1V"b)r7\5KGNjd=\2
l*=4Uj<N142HrI"&Gr^fSZsEg#dFRDlXSpG*VYFG[oAIq:f7N\KZt(s`1CoiZ`=4*4NQT<cr
fGV"c^&'N6Ap!4m!!b9ZXbs+!g3dcnf_l;79f@SWLWp4:J_2r/HXCJtkAYmSWr7k9-d=Wqe4
t%Gt,>Q:BPXg4fl%q6OAB_b__1b9@X/F(/7hX8>IkEeS/;c(OCouXFk=SRt>MF..ri0_rR<F
).82[cR\F<+@\1l=QJKXeXMeGPC[1>ghDoagg3H9l<cR[JG=mt5(hO)mFem1i.J<"0pcAg5,
VY7%lM6AjR-bgul5,n.pS[N@3X*h/EpA%&:"@EACX:4B:-N%+>1q]A<;54*?3RpNekq;G]A!`.
[!p=9#`ORVq;@l:dR04!u#S(47Oo\Q+FK<C/UG@qD9l&t4Q(nU"k(p>Z\P+1qZW"D[OeMt5I
12n`Od1N%ZC'Hg^aOfL!2+OWeA0jlGhI3N5hKQocM>d@)?kYpA@Q<n:G9TPX/j)fR[0rs^U5
"'iYl&8ZAQu?"I%/77raj\_75Q%OM5_S5tnfjBiAgSmX.KPsO]A91?XVl%eOiDc#sq1r(or9M
d#2?:uUO_$`Z"%/c_BPK2\:ZNF^f>tZ*XRbm8^f`k1+3Q:>7EY)d=Jq[#m-Q3PB(N_;bBim\
5MCMOh"5*O!Fo!W-&kXZ<5:K5B;[1-.EfG/>$;uV#XnY`o`WYeBALrH,s>,6]A-8#hO(Y!Hn8
:ZgRJecfpAk8EXfIK&RtQ&#I"CaQ6_EB?NJD&KU7->=7k)Od?i4&f0*F=2!C$]AXr=Kd`<Q:$
3dAFt3^T[tL0H$$nri^^AesXHLX6]A)jdV_4Oc49hUs2\iK^:A`EXk"t`P3.f=20[ctjd;Y6'
o+roJ=Bl$>'=.1XJ0gui^*u!2jM,T>1<lo_LhOG^_3JfU,]A`^1;40ghL.mEM,ma<"UKYoaMO
NV``UUe"_3]A5A>W7Sr_Ja%f5DSX6l<cRVCg`V8#5nFMn>H_8qX;<rN+]A*=US`m*!+ZC%r^Xo
*_FUU<E3`B[2Kr#)%lcr'Wb`;OVI)l@G1nlNELOQej(/nor$R!)]AGXmBr^;iC^7T>"4fCh@_
94_'Y69s]A=;m]A8)IYnQ\q1E#4t"`8uBt-UJZIiGSAXIaNi'p7?V:d?*`u(Ad5J/`sO9>Kf9P
B):G"?haaGiB+IJ@jbI#$GUNlA97YMS#K'8B)k#`?+O@59KHHDe5?,k_/';'2ObLVZ]A@D+c=
`r8N_<*./%fEcu[)qSg-gb:`5^<5Q4cIlAX/%f!>(2XS$:RWtf<k,9>I`,D[mE:]AAe3?BQV/
DS37Vk.nq5uKqV]Aslj`W:tfpRSu`Xh:#dk5uVBa,OIDVJa9')1VrO7m1'"PQ>D(jE..O-7j[
<.rN2HJU;JR8"Or/2%s#>lp0qdr1#>q1j,*rtnbsB`"dt.Oq"hio`+Hdq0Q5K?fEYgrrZV8'
Ho#><$Ga#!YU@^;Ts[D.qf<U"1)b!'g-m1ANi!h#757`*HG%?QPPnk0^`Jj]A,#2VSu^7;\VX
NPIdhOf`sd?!Qn22Pjpob@3Z!&Ktp@35=+!p&%(Spc-8uk!i;e5-;dJMK!_6m!tHS9Y-+o<k
=n=7:4Cok)CFMSSeSpk.P;3:[;n-6qgCB6UH&:^G,\or+?/@I?XEV;\j']AtZKDW3(=oX)6f5
jEP0r^ckDhR[Q6\_sl\e!(h]AG%JU`1X'el21uEc4s;D(9MAl&u;pT$O,W=$pcg4$"(!)KF$&
B`S4nq"rWYP$SI]AeC0\[]ARQFChnBQ1`Jp2r&^d08Z[_6ObYVjlq%f?IjnEC@"+%s\`Cngtk$
A#F*p-8kL$%u!7>m9-!<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[144000,1064029,144000,288000,144000,144000,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="3" s="1">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'sepm'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'sepm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="3" r="1" cs="3" s="1">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'d3'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'd3']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="6" r="1" cs="3" s="1">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'rm'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'rm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="9" r="1" cs="3" s="1">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'solar'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'solar']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'sepm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'd3']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'rm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="8" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'solar']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" cs="4" s="4">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" cs="2" s="4">
<O>
<![CDATA[MWH]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="96"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom color="-4144960"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom style="2" color="-3092011"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1513237"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[c$=XYe,0/pVp">O.Ap-?@Hqr3Bq,f&32I6S8BYT,*4\J)HT&3OMO\`;\fl_HNKEPg3bI,47H
Q4WD:Xm9fP8W>2S\uIAF%kCI/BGZkPP4js*MKSHG/1=fAl[O5+^*`CVQCD2HqWF;1?oe74ZW
D*O]A1Zkd0bIM\^g>`TP#U<2`:>U.*u%QleM:o),%5L=cC[cK4uUU4Zf)?+kQlm:"bW7r1uRm
W&,6l-W!Nh[\KL[_?#M$9n)aATcC\UF5(S%(R,p?Md:R_Da)'6((EaBjspl,N#.SDg$54hbR
#g$'5REIT-J[@^NbBA$@EB:6Uk[>"D"f21FdNK:C\I\lP+"2lANf<]A2iJNH<Uf6LnsikV9^Z
dd.t>i:@`h]Aq0kZl?)=**@t^8\RF'6gt<@kW1MF:pA*2pA/ZH=IQ(G4m&*@%X_T==@$.`*eu
n*C2Ph#@<%)`leJFjMVOMW'gaa=Z7nVa>lH1(ecr*1eO13'Ir<f&6/1>/dEi+B><Rgk"eJaJ
AcVKn?4qmX2`/r%dT8JR>*`7OW;ko23UMq4Q&!ME`J_V2Cd$r\8[BZJkTBoJ;rB[J9n?<_A`
eIKkXUo<-c\WF7Hp4FKTpR6Ei5G=QEADp(8\5:1)`6uZ@KV=A*!1bmj$178ahrlNl%a;,@RO
9loPjXnn1\6T=4l!]A^Od2Chlo4G(_j&L/\7hUW^ScVb,n*[[6GR4+>d[J=-hmpi6:+]AHHs?/
:!0EoX5rjHn[H-'io>+1';L9NYVC4A]AgRq,`dO%kGG9fjL?N@r.2?`QkH_4<#$f3XSVp/--;
iU@B>Wa6.<"ruA4BG$_K4K"]A:TRfOo/Z[G.F]AaWD-_-brlo`8*R_&Wg]Aq-MEkk!!ESoNK@US
q2jk@%R7JrjD_-/.Ab`gALuW';B.sY!3tdmib7"$B/[^)LE2f[&*lG#brVj4b&0MHBSr90TD
NHu8EP]AtYH:gnsc#9F^SjF:)@]A4_@)!kqpV9d?TB)ogMGh3:A+i+!/jaVB&b$b)=ldtl1>u*
rX9!GPr4`1Y@R;iacDZoXoOG*(BnTo<SRZe,V2IJQsQs,#cC;JC"9W>SfFSe8$\Qe:k\R9Ru
=Yr$_1LoS/Vulfic&4n%dBF'X<0/gr1KXdLSYh_:(/.HOQss>g,9r/=]A.J7?7Otdt/t0j98J
@(rbT7%]A;O`)542hp:`orAQhABHlnB@3`lT1Wc?'NWan<hFIo0fd=4NlKR2H;]AR`1;CZi<^[
t'"fLI#T(r4'l=8K!qNE@hiF>Mmr"-mRs^nt5+hF->E=#p9ubQlO#:/EfkadOlc4a/'Xk'8,
0aJQJMuct;am3qE\@\E+>D846KYB8<1/5T.]ApNO,YL/"g]Ac4Xc;QA)-]AP$`Mo$LS.WF\F=^9
IWMeW]Aon_:G\SFa.C9cO;$d$4MZ>.l*W#npG/1-8B)A#9opNbCH;8+H1ZHro_oXb`l2#:CGm
U;duc+cVH=OH(U7"QhF'C-7dWAc%N(*RlX^M]AsWRbTEarN^qE+$"hrh"&NfH0:OBH9s8L;NS
u=;H;J$,*]A<6N94YXC)AG4+ne*UNfuD?=i>eu26-qo(&p`WY_;G2p=bSKQkFZDuPZ]AFtkMR^
A>"413^buCAQI$5U,%UaPk?3qO=$SO"&Lrq#4P#8S,5Mg=F^aRRj??T3D6C>$Rm33Si[]A"\!
4(BG)C!4`OXg\sX7g?<h/X)A1(]AJ%*!up_C(1H**::`n66@\7k_,j/5Cn;On+`=119btM$kh
?8-O=G1ca<d`"n`F)crcJc7P"',5/'7#2D*2h%Y(4(PfJV#1t9ALpc(+1b>[ME.O&EI(P\G"
[R!\JbiY_Y@_;.$+DE/ees"WP6Y6Ct'_&?"3H@Ah.4I3)DZqJe9s=Joe\L<+J2`/kbgn)8T.
-<1,<>609:$a=DSneq"K*Q#--2YLFYA8)AP,cech*2q3\o:AJI-\%".QW3)i_?>c.X`8/;1;
7%C!*_7MO"^-AeYJ"G^aUbtZCF'q+?'#?L:(ZQ39HJ"-OeKtC"j+su0rRRHg$\$DSHGmO1W7
Y"CT%g$O+1P[!RD8/B=kUc7W&:-AA[&<iBMJs+e!GVAq4Y_VLH%);u-TjmEo_&D_g?uqMmOV
R<eYihOd<`^KS")bBT@m^q<2VT]A;tZng^sQeDb#MdP't;+":L%;"oemHc</L7C9jGLeT6M3*
*58$DC7h`Znd-8X70&sP*+C\ii'Vke:^mB'?6sCK3#abYR$8r_f0\f8-R9EONneKPk[0+!a$
e\f-\2au`cqM4+IcuEBmIm;!/HA2>Um-O#>>:Ib>TMF7h[G\nTupq0*tLGi/DOoCuEhL'4Ea
tQrQ0tTm&8[]ASk(Mh(kJ-C#kMKTStkm8#-HTRj1'D+/p1aJo7F?I3:1&-(MZA<9`P;bJb_N-
Yh/LE7.i+r\56EHR\pZM-Ul`=',OB*O5D#=n<kqN=b**K9AkmL4iiaAYM?86:j]AfGs9`&2:U
T:,t40__?C88[EF`#5]A!@6>W[9G]Aulgq%5uNH'OFa]A`XDR^CndGWSoJm0G#;#t>8Y*&_*p2`
E*X8pWVrpC-Di:K<_W3h+[SZR@\4*<T!uVdB*S!%`WZqCMP6r7<XAmS!HFWqQh5#3*BfO]Aeu
8RJMHmkkXH4fQXG1J^igX_EpbRHYcX8XUDMHj)bIZ'YFZp[d?&:%+S5pgM`Jm]A]A38=hF6+#H
QY@q=^ngWp)Xl)qs_(1ZsV!/@odjtr3:%s7u8-;`P=P-9\l>;aaM"0F>3#[SU6aFm2*Q3&$f
3pG7R8\+3(tIMc?iUZSmO*`0K:9'uCl9JK,Ac$^VBYc/g<B/E*tpF,<C@5s]AjF^[V,sjPZDQ
Om,q&dhe_!RN(thmkdR=3]AAIQcNYagltp3:W:"W4Y[UVL6W!q/2nXtqjD&f:5XCj4_B+eMbX
W;W0kb:"PfIO*IAg^FdF%0/aMiXf2m4(+!P3[/8(5Y^gMW^XB14[?YqZ+C[1(.WKS1s8Bmi7
,8!$K#^MPrmNT(=-eiN9Vr$bN40HCro=8SVO[T6i$K$N-tIg6cf']A(m@o,Rl1Ot\g'>;h&6B
6?#n(Fr0I0e''0ohp%fRnoYi2U=kMFYPI=k'n+FOZK*MT6L`ui+T:q*F=`.`lHA(_+!?9;]A.
,8SF9H6GU8T[ADKbNi7QJr>=m4eN=*Z&c@Qg`6O'd>]As-Cm2LRl>7\BtJMC&^=[@JK3+R[t(
).HPT+QAL)OTi)FLIL4mM\#Cc7;"Ru.B</>q9AC-#.'QZ#rcR%MsnX]A=!M/1c%Mot\T(FUTs
5#rtp2k8G>692,N@@pDu9@k]AfmtSn6J^rtSYVLg"G:."?CL7$4]AJ$@geW+*R\R`X@afTdXcV
7hVq(,8J+`[J!XN('a'kUn;j9:Ch9U%Fr,84PJ[&g+W+OX;qN$k7blkHm4=Q*%-/K#eDMS,-
OWf0a4o:HJ;R0^FF^&!?i6/ktN0_hT-S0l.9ip5$"(W55#]A3GhbU$N5/Rc\$XN&6D(cEptk7
?.`GaTtgL/`K/#2T6/ue=YLaZ%M#WGMu`]Ao%:dnHXHqV6ZmInfJp(2+0g[k5bT`@Zmgo3^>5
oaqUJkN!B5BNj%%l/NY41EFb[riSBV5CiHi>Z<G6@8EQVVM<)`S-Ek>PD99t5R-diNj+/`qW
3$,+:Nm#`_"Ae73#;tY[WDuTgPnAr/n(DZDce6c,m#LkZg^U%HQ]AO:c_Le5!Pd+9N'MK?#Z*
gJ`mWRmu(G5M0Kn,:YKZ2:f/DA^SV"4C]A`l6hEi95LaoJXRs&f30`.2:*GL<^t\>3IDm"tiF
E'G)Rm.:ZbmS%757@Ip^`4m`D-PWZmZ/YG7?GJ=E%Z>IU'<).%k\jaZ+!hT;l6KHreFpX>,?
l$V;l-[t*HnftgGVTC[Fg_:=jCb)l/IIG,dV$EICt<VD2(F[t:#WH`m%I1"`!aPsP_2/3<54
`YcFKfO3Wt>@P]AMY=mC;tU-]AV'1-"eg-+&`f]A[HhA<kSf6<9u1WriNX(80220%7%T#<0V2>X
hg4U35Wg%$Z['KnolQiPYle%589r0bmr'7NFaP&jL?gRh+AX1ji!d&03/E33N(Hh3^>Jh#rT
4Dg8M;";lJl-#gSD&/>kR#<f;*"<S[Br[CIIe6FHR^tr3\+7WIAZ=g(.O0cufc5=sXi?L9WU
:gZ\R]A[YnB"LNL]AnQ&n[^!iaEW/TN`?]Ag)&1+hmX3XJCRXKaQUrds9?-6!lE'r@7+RYX&@W.
gn%NNYP#3XX]An<_+ggqY,7L8nc1lJmW(C'OCDO]AT0BpYBjno-S&kNe_[f8'fG+[")6,(D6b>
[**EZE0Dk]Af36]A#<*ltIQG\M=W/Ogj'QN;f^(RD<6,k,>[iGC/0"U0.Hojh/eU-q8+WjedaI
7E,66JHBT-FSsmrad%2iHMoq>!W.J4dXNeSp?h3$Z?in5jA"0^?Gk>pIC9[:j!Qqah]AH#<@h
_7a74Cj)=#%EI5IIL8'QRhk4MsglTgb#efsu*\>K+.27`>em#XnHlq?33IRtJ:B\CDWW98U>
^^Y0bc>n,oDL?6WhZbh+_kp<ff@h5'lSK,qCoH<QF\d1gZP:Z&9gPITTg`+j^l<.D%R\4k\^
qR/b^\/+GBB=]A$7AI!d)0"jR]A;2?0&.NcBeN7rf'33JMBC%_0Ge_"sPJ>^5K@g*N4CZ21FXl
kH@A>kMdIm]A>84pq,JC1G^jH+WM5,!_E^Rq:V9>T8:ph?Xe@uWiJnm;09HTu0gmBhq@;g#_X
hk@Pnfcbnj5!qj_*%5:hlXa5YI?Q7@)E9=CHa@$W6)nE@.\)_[p0IsIBig3@:Tp@?.>d&Vi-
moG?<]A_\Kg-fi)!P(ELtOE=T(l,c@^D_%M.<d>/r;RQTga4Oo>bY%/qNiHP"]A/g"(Ol!9U'!
3'?)Z&o05G_Qd3-]A,GdM#h9R4ZU3m9$IgWi*pFMG:p6r`$=]A"0p2@PfSrAWb0:8*X#'GF)Ig
A43-3WsG4/DW,RbJp5DPI.u?-iK9G("BqY=$94Q'apmqXuhE?nq+*8@]Alfd_DY(I#TF9C<Xk
IK+%f)R05c6sbfOuqjPp)l8^$R^BaelrHXKLDqOQD%'704(:XNHCJ3']A#0;8E3HuE$<1O&;e
4ru&(\MO*6r#4Bf'Cni3(@uogY*dXd(oNPQPnoe7<qpH0%R^?EeE2>Wm\%'!NS0IE0\1q0DL
]AaP2f<b1?X!"+,Fl:k3OEAc0CiI/L(sBQ;dP]AH^jObBnXepQ.H!eW!JfX4[T+r"Rcf5sJ9[R
I*D=*@&BQqFA34fh^[P)9-J$N>1RGT`gRlgWk?d*VIs9EinqCPOs3.<FZ11#,V'd9RG*phHL
^Zuc3cf`HifVE@f(GMhgWll^N;/Ck3RmSi*h@dm1W6bfE3"3?DNo2j1[OZDff6oYZ!H^Fp<N
o<[c:3sL[Je5fBpk&.u5PER^UNXN@]A4mKWMj::?4)^:50Zd3WfgmTL3u"6#Er>[l]A_61qV3R
bbiB1`@du,"D7&IL`<d0NI9<[C=&9A>\oj.%:t_?>+mOIm4#+>4j.u\l#;3=IcGhsb&/!G1#
l*LS\'?MD%4cA]A;C-a^[i]AD)*Q'Fk"q$8R\<rC"p%Z67j_VT<gH5b$>QlS>$;VY-(<Gp"<D"
;1IC2)K.d]ARTEaFHBV0qM&qlrPPS#G%!b8/'+SsEUFq#hnj=ZuQ$[dt?m^&`.ms_WP]ALnQn2
?UstgAQ;$"-OH_>cp-!n^1H;?/=nFrSas%@]ArO5bL&:_aR=dOqCf_?+\s\/[2KcZ3C.u1VDH
JUQ_Rp>ki=lr*V]AZ5"i%X,#f7%]AWmd(oIWu$_Lp-5D9i'"khL]AD5E4)SeWC2=-(JdAn7ZR'8
QdI!i2Olh*I`_Qa]Ag)C7E4`QB>kg-co&8b1S)DH,,rW9k4%PjkAl&+ZbO/m%b)Q4436%DI_u
0*r,WA&X#;tBW$*Nf[&=aq7H/m'a2^HC-2*gPaqDnVKkPJa"P`23tWPc3#RaW1aq<91??VZ<
q?`pmt2K5EJeZq\?J@EDqRta:iLgD.hFgU'cjgF%^OuNB/B,0!:9\2&finI*C/o>%5k(YE`R
9WY[S3bgIQjTJCJKdV,=Dm>e*VN##b$PUO+8T-[-lS1N'DX^0#7\6=_O:fK^jr\i6k:B9^YH
ZG)9C?u5oXSmY_&MA;;c`Z^I;@W^]A4"XK^sIdH8O(3g"WV/_l`I:IaoMs5[3KhrlOrh1Vat1
Z`jp!f.c]A9PPg0@d.pVD&9'aRIe>ok+.c]AkkSRXB<r+d>/<Z(iG2VrqZp.'V_;f7WQ4(U<@&
L;b5(B)WrK**4fC&<5Hok63JSLq`A+FNWM#p330-.,`r@I>.FaBZ4lc-\PBN:se(QV$,%$SI
R\t1I,PGWi;Olj`E:KSUB;K-:)?I#.6%ft'XGeDado<<#U4HHE.W]A1i_j#_J=9e9@V-W^(g&
-]Ao4$d^,E4#eB*FP^oHY;D6#^RK,,H"!([ip+DTAN'.(%,r(TEV5ir`)tiD>Cac-m*icQ@Ss
m)JF6b=kCs:,pq[]A!IA!Z%DHr,9k+U>lUaaY51EFC_Oeu_o16TBMm7M<7XHO+sAc1RKZSHU^
?Nlb!FR5%2F\'mnfYU^>l%+mP>bd!O2qo?%VTL@>J`e2YY!ECE,s<#7.Fe9Fe.`cF5?@OoZh
g7%>?2(T)dV^ro)`n@c5#6A(I.G"]ASk6FV#__4C>J"hkGBgR]Aa&Hj<J$W[fnU9>V=-"-<HCM
tZiut3WTD"VJu..L)GenJVY=A'Nm;3M?i?TO&@+V6R\Omfcsj9PrXQ5)_csn-Z.XG&b1iS+o
HYE^mSY#]A0IL8rQjFhUU_^$[VHXtJBPHISUet-ORc:;s(!@TZSI1N5pW62!U\C%FS,6<Ec$a
DWj<5Onb1u.>f5P9Mq!Z$95/#tMnR^O>rsSU6St&(#Gpa9pE`-W4,M.R"l$@&ugBSCAU#jOQ
c12]A[.I:6,@dIU>mLPk:(M.N"[=hj-ruUY/777.6WOtc]A+ud\i$NP,\oM[n!@iW<tR-:H5*%
9*[qgT"4.Nh<t]Ah;aaMGe,:A1f5hiGf'k:LDX9PUE"K!=Z6;CT(`cdP]A'c"TaGh.a3!id"gf
4/_%\c1UTZG3$!'ECoouXV5428N?]A")L%C`KMnJ<ZBpE"IV80'&-MPH^k<t^&pufuDN7$?%r
CZ>DpW5Cg>4Iq^rU1Sii?mb2"5aB&;sh96';h:)?@)f9&,V:PdP+>G$3.jjJN$BPq`srbM!D
j[62RfiA#rWU]AWc"n7q)pBW^=4%.WlBh$]AgK0)05GthIUIUa6ilm&*ZYJC%k>,pLRONLCSIs
Ot]A[id[MJ@P_2;]Ab:9[;+@u"p\Nb3@4"8cIb2X#)>UQ)g>MqK]A:SmK/KWWc&k_9FY[]A$=id*
c:inVXmJNb#GLGbPF=2(pY4?4.7o(r877^H4V%ZW*k>9r:NiccIP?csd&J>N^Xh38-2GM>]A\
,9#AJ,9K/=&q[BjQq"DIfVZ8T>cI<c'RQHR^]AYI/<98_Sta$u]AI]AeYcbCm6P8Y_B]A-_W-af;
F(a?DW-@RLLc-3&9fc'+5Jr?H&]A[5dud8`J7_P;>Wnc,rGg1J]A'oJkmo_!%gjf`-K%iio5GF
X%ki:5DleeNN!(K3D-Gku-c,3F3c\b!q$;GY17Xm9`c)6KUP]AQE$p]AC+F"T7m#d(4XeEI^,;
WO1*gUf(6)Ar9)6*^$XKr"F2_g3b"['E&\u4Og(ng+hit@gC17lVlL4*t_6f58955?"os,i4
6L3h>/%&kbgUDjT>'*ZLS3aZ.*FSCdTaOJ97(X&2a%uPA,?7ZWst]A3W,_p[8r2hA85@@)QNC
GlldbrKKW'TblQ1"S7rP_qGEgZ7iG"$..PKB:0u*icSN?mWk12ll7V)$'j_7*O&TS]A9l<W3<
KS`>030%.Y,R0!08+G]AR+V=c\HrBGW+_c6YsOU1Bq$$:46@Qb?BIEeJ\YkJ,b3-Y97f_jdCK
ACg&QZ/!m:[LTQqRt=l?8@UfI+5)'m\QIm\.'HRICnE^fOQNrGT<'.>X[Bs)ZP.#$N-Y=p\U
b+p1pe,UU^Oc9;ni[81^/*n'lm:A>MC*JuL3,8CYaZo3e)X(H&_%m=%'Hg4-U(KCNMG+-7GL
!+,`/^1qn*fF88M.0gOX]Ac"Q#?M<]A?X5OiR%!0Aj;^SGRrj$,3+4Zf,!YdM`!o]AGQmhdj4$E
6LR%'/qHrouSJ:o2Ffc%D?F\&>7n\NOJ"G,.jokH=,tV+FNZI^d%LpM1KS@N+>U<MoV,L3@:
RC7r1Kh?AN:P%\G<o;\@d75/aB&N]ArKgDa`^%B1!Qa-PGFZ.W/$jdf.^a!e2#I4Qoe"hLp>X
B#QA6BKM0[&l*?[5*m8]AF6PS"[fbq0)l*uBI>GiAp4.`gW_*L1r%/VBmmpVV_-PLe*.2>Ldr
PC9+RKhAe<7Ad`dRS0*AM!Y-Cbjg7QiR4"!n1L4KntajY.sb0LVuZW2)+*X<!_4@q-c9?T@-
/a*UuZ9$Y+Qs]An6D[68u=dV__H#rO\'.KAs=r-N(R_F$"T5u,#+J^;*3&oRZ3*Y+&Y8;24:(
_EUoa9a-3Gke.VX*+:9-b$<jXS#GFZR3&8W]A"f/);mO^2JbUesDR#XpfRHRU.9)>J_,<>sr%
d\WC>/?mN"[+N@,QO:EbJHiB=ppn$Ti:YMW)1'GJVm4P=d`-q!qSP3eK*m8$Q%A,N;p0VlNk
3Fp1'Ol>uP$7h0kJ_Y8`#Emi5Z2q`]AKW+1^V@SpjaG)XjR;9EN64Nm"l94Xn7\7EmpA$]A+?3
>f(BXMjO?T@CDqmf.:/W1TtpSXeBB4#8u`1]A^Ue!PpEIU$8M17r@]As<8hlb)!mm>Es6Y"5!$
S+ljJl`)oBg,IQ"s;I`.cB4$#_'\s6skD)4"j9jAMf6SbVo54!o9dG^"Y(!,kUudbRP40MK/
f#aB]AEGCHQ"qsb$CHZJU2>H:Ls>W4;-bJ)DK04pH*s%n@A&,`CP@fX0Ch4I)[YE9)E@/"Bt/
F<m&Xi9;SkAHcCcf&,K-0H$]A2;;pu>MjYQWA2Jpn,52nO-[MCJ]AIk_?d):'3(Ke0!)DR\I`e
[.RB.9,gn7<K"?+pon$Ue8r^H^9AZH<oFstP/e)@=k2_n*=[-WhP?M,Y6Grkkr5BCB\TGDZU
IR*Y,oP&f*/rrFZinBnGd`V5LCnc^bjaf_WaQ+Q'0gB,q(jj?k_Z']A~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="2" y="48" width="371" height="522"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name=".SF NS Text" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="0.99"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1197032,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4056610,2394065,0,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
<IM>
<![CDATA[FE_56-;:ahElYV*j,S!2gt;>?[^EqhCmuBu[VadoT(>/7WUJH<R[TYFWi)opR\$,=80nF2"B
\o2&.fBUBdkbO&.m4NJ+cadOT3Nl6Op%;+O<X-@_uk$R2;F^*pCL_N.0Y)h;6UUj96,=,LQT
9+jO#:?Xt@Xbe9loClin`/s$s*bbM&O^"CFZ;r!Kiobn^oTBbjn(K8j-dnVRLpV'r#?=u6a(
KVb]Aj^.+MeQ8pYhrA):h%rcRs0I++1F8*6\$$2qriD%/qa*,oiqO=KDp)DXQt-("]A]Aqs!XBZ
VB#PccuJS"'D#95d$r%r5GrX\e&)F1\.*u,U3C#(3gJWp,]AGB)5to_l,:S.0]A5/uK*K^RDq5
rXT_Kh%6tN]Abc"pa@cB6/Gs9G@(dN'o)FU[ra2Q<5r+[ggb3H'=:<3FI(LQG+[\?:nKiY(=:
[N28/.",-N%Z.GJFH?+kZmP*"N?>rC[tu`'>Krm#3lS*9<PUJtM,u]AHkSqmp5uMjK#o2P?rd
C3+g_iklVnM,_4DOO[(W"n=>`fB\R?K0P"r'L:DQ=>I\)>^\jWE0S+3hA(4[b[HI]AP,.2uh'
#YOno0DjkdtBt(:j]ABVp=rTIP$S]Ae;Rt$+g\mPp=)L#t/SW+3FJhm`>+Ee9;Z=otOorS[Md_
DW,?%6&2TpbegPBhmPA"iK.,iL)L/rhen2kTHgfH6):D7f6H*J`._oK;^bC>BEfKB(eMdO&T
s-QW<"#C#I2)U*4$tD7-2o?8*PoYZRndC*q);Gub\q"TRApa`'4@t+KiUsgMep),Rl6W%.o"
Y)0P53^UKE-j\a\ciMD'Oq2&0N-2:LSRB:ED?OOi9m?nUU;a\@ICedmDfj_UJ*rWHBc6LSc9
W+;r$Ob.&*/b[^/YV9T%"Y)>C9Ui)8/oH!O1fRL2RA/,RFaeXlAb\*$67e<)N1;M.e%Y;RiU
9`VH^B[7q5r4d?M2dnIQlTWPeV%We=<L(^YNG_R"oR]AHjo>)]AJf('Hd8Z2E+BLAf@ee9:6`h
qmetUFL/8MYHf`@-l#q2Z)S3nX3rlZiLIg-@sl?)%5i=XMR#\s>=LO*115:WQ>@?iNC*\_!E
lJ#fNqnEh?*\&Y`E+m'96Eh#b)U=tdc<)^Ei6pa>@0m0sPhr8Q,1HP6T@6\_=!Kr"q(n<eNl
+m+$fGM",n\-"bt\^EE'RDYYC.YE1>2[6^F%"K@pWL_p$9--M38'"K4*_HI]Ar#6]AadoFYtb7
D,#\;&Ft2THQ?1U+`BZ7h83]Ahqrt$@jDYEDAqfZoa%-`Y$7`dG8af*j<Kq[((dKR%PWaX*3Z
)$O*ktZaY_/U=5dhSW'?q6`Y,5?uP#EndmHKK:]A/:]A"PeP))Mp!X&^)Dm!!?532pr:a4S0_p
@PNgaWK!cS)AKZ;T.\RC$3KmMt[+_biS%j#aX3Rq7F9jq?#Y:`1&?7j_b?=R&HAeT7+fedk9
4L%n1Fp4Df0^[QN]A(&YtN?'p(^=@K-"&dSQmt_@5LU<llYS2n^Y'Y;GoW6=PnRsBV[iJ]AHDq
hu'2j&Kohh@,@XtD$VTuFrZ`Lk61]A@%mj;9sFZh6+NESh4/\3PDrL$a;n5+ia7f#+GUbH]AGK
RGMq]A\QsoETrT!m';]A-Zg1GRWHVie%2SWn*.4P`!Oo%arRFo"Eh8(m>i4X#bI*)b,^.M/Qc)
_/cUP6LI*eo:]A>1p1SZEBM/g$ajE%e^9XFXk:"<!A!b5s2O8DZ66gI&tR@i\N3?u$+pdW`gU
'JW@qq+p5`#t4E%!O,?ss1b`H-n?BZFSRZhr@=>)"(Oda,-&VGae%IUfibXIoV%EXIBA5aLJ
B63\"i<^TN!tK_3-\gL?H/@9L$\8i?/)mOf^B%;G9Zk=rTjtW!980'T`'_QQ\."?Z*1&h8=U
NWqX4S0Yocfc+V(7O![C6)^?c?*1*_LRDZ2%f[)'pT73^e#Er]A8OpC(>g/iq[9G;7Jc4'.\h
$cN3'tB$5s(r:hm,Sq>uYn-:P(k`3R6&UjT0)"F[12C9-O,Keg;#qg6?K()fTnpT!j!H,Etj
E;/S&HOP7G*)^`ptiVX)lKT?nW&<`_0KYnG;?8-V/gj(5ZggGMX5ATL(!PLBk-2_h(S>h.)T
6-^#jg.J&-oEiVY`-L,"EsF&tXF.Y^GMl+Ess5W<^LMj_[Pob;R")?+8iGi&!(oYVSjpm$j/
bi?:p5p`o%>J3uZA#/1*W7)'B+Q@6*!=CJEA=]A_,$9JeSO,OL8K+F:oQkY7DMf9KV)!05($=
9&.AY,)o.-P\uB;'h1UPqd=9KJK9!1/uO1a=V3%Rd!U)(!o"V2:Lur-P$Nn@sNmF/TA1Tlhb
._UVd-Z[f)G9kEO*dM<jMHu(QgKS/+#ROuGXh'mcm#t<u0$@]AH07V\XB>d"`3Co33:_\=K2p
OQ%&&M*cVBdop0+Sh\0$r&u$[56PF9nX9cX.4E%KHAUkRs/q2(\"e'2Ts0u0AOZZe.Vphnbp
nkn9@?UTVt_jXq3,3O6OWGEa==BN`+>f>Q\M[[LW64NED,Q6#n4ue_T6]A"/%[W2+d+B<\UKL
CuuU_r66**CaXRQm-7@")3F[mTnQZZ"%RGZjY#/Y9rm6,cc2>X[8@#n6@f^d=HP,h-kX3k![
F*/OWVj#8@p(a<X,4&nPR*6;+PSD:rQ7>*<<33r'@[6#39P1EC/h/aJNuZiPP=V`g_MfXe07
!>NN*3`JhW#6Hb'$_A0C9jml]ArKtV[LS/ci<6.Z%&/#Kk:r,L"3m4bO)\qSTd$S\-8Id>`J%
,IU!>F)H+I$;/H5DXb?hd14IpE"J$=\*(&BcDO#^:\qEkK?`pbYbsM\9`(BL8GP\k,X<)(Ck
h77BChc/RkZ_\86UI5Gc4tH>M>2!EFHGd[pu\nBW:cHjoC-%[posN#fO.c1-KOrBegJ&(Q`X
#[25O%,rhB?+rMMUl5r%17:pT2R9*-PN^F:o_g7?TY^3![;1!\27J-pUA-9XJ>s/_pm*'!>[
m.7/ZHP;ope(L<@[#LZ`0AhC$Q]AV]A@h2-SUN^h<,fqlTooMTrhNlZZH-r=?U!kl^RD.lXIFq
5*PMDgStl;`8jrCnrm6PiM',s`&JAG,/&:)4.ftB`D5fU&^lR0i$l%8MRC1CQDKE=QCdA'1[
387X@"G_[,>2\Y'!cRF7m.b;nPZ$7!F:%[%T.nA>Tl&773gRKj8eYkJLK_87;g%2NSk'PT(O
93`ChFf42V,Vmg?F,kXRsIjX%A0^cf!PMrCR[hRa[:V^ABS0QGclcoH*`A[EcFDC<j;NbW=+
l=WTbq#^"&Kd:"EklYT,j\j;p?^@]Ai[jZHRlhClqCetQ.G:,UfTFWEeK6W(Ok\>5>2AZ$)^,
S5qCqhb?UrK2J'O4$[4Bl8q\?,Oo^D#CLYIdUE8Wr\bS4slLG)bJCc$<77*@(QdcC#)"4g'i
[>14!`fku\Q;/$O4YqL(>;*P6]AlbK+ge`::,6a3[Nl+=q]A?brF.*sWu)NR@ppH>m0)k^2eM;
8>LgOrZY?4IQMXQ-lGpA%i&6kOTqa(#'S1XKho:9Kn3Kf:aBk7^$ftlD/1;VMiU']A?6`A&QP
aFn%S+4\Zkmo/9p`*jfHYY?elMKY]AJ/tQj:Ja08d2"m87Q=@JmI8gs5ULYcBmej*ltRR,ljF
h/hL]Ari4!N97&_f)dk]A=S9Z-<Pt]An<`t*rm-l99q,1mk[(&BoO5t,VO_4uj24$df0mZ01iL,
=F5+4tDb_7nIs>]AOY*Ehqhr:P$^HJtflk(Z"TeHIBfc^C"k,3\HTJ_$6Kb)+nY>&"[]Aj<]Ac-
dH-kalJm'*C(F?L'!rWae&3?Abe4>5p5Mc2?=FgV$PPu>,]A-I_$o)4P1nq\D0SP<ShB,.8PF
$Ge^OtP;A+S_LZkse)X&HNSQG?/PXW3>Wn]AeM`17'K560.c-L.^NB*TpopN9EUA"S@:at@ps
7u^_7%l-R`ijJjhI`Ll-6#Ls4[11Ak`MAQcuZIsR0%B?%!(s20CS_b"&T?N)20Ouk#`B0F$B
,!ejaJ*[In/f9A\TL>pCfPVVnO99YJID"+Q%URWU7gATJm>R3(2)t+5f?r8D>7)m9oVKr_NO
k`L4(3hK7c_mklUcVD]Aq#X("BZ/gVta&9(9-&&\`QOhKI:F$d6N5A!LW;!$A3h"8c*mGM>PO
Xd)s*ghY'S3eBonQC2HJl?5?=-m4<sbht3=N4[kj_DQP_[MQTFZUfATVB4\rH3&(+P4kY>]AW
DJ+VXYFqck\t0bH96DqfL"W?@:-J`Pa=!Gi@S!A(9\!9o_t7S#Y=h8HKDH^6HQaXWlkF2EPJ
q[-=&3$1KCcuXBKRG<t<6Trq%?Q+E(+V.:[%3D.Z>Z[P\o!g&UbAAU1UNPl*l=)qhk0hREb8
^>!)JCX8"d&X,!o$LRM;$qqn%/D(lqYkFgtYQK1\6HDpiTjM8kJu;\;4o@$CVbr+!fiR07E:
!d:a:7)V%H/Rq"aVaZW'ZsEDGF$$TCEBCjIV&E9Sp\/AHr_]Amq]A,qS:9FW.8(=f=/u[0c&5O
MMs>#C7@_<AM7F<O-?jl.W;11l?BcCtU)Bq#DO=99X5VoUb:TEpMN;YErV2,,8U7dFQ)RPA7
?>o;E)JA;Y'1dmfk6KW^Qu^"?D`k_d-.V7j\O_OWhi4E!5j90OW_jF/YP6E*U`2Kd?MSMY<c
Z^'ud%>7]A?Tc+jQSV0%im"DJ+T7TkX8EIU/.)_LQ*U4aj`62g72U8cqt@gak`niIT3;TdJ(F
2s)(u=/1fcgR+\3?B<Jb`6lC.G#MWT7)cmM[Z2EI[fI[%)t%(Ha#UBN$8=l;Sjl82_rhB%Eu
@SU]Ar,*Q4IrNEbJr/D'`H<s7eG`Z5]AiF>L<VFrZ\nQsO^Cm2B)YXM@q12#o5ugU2Bcu([(UP
+r1kS/d"]AXBU,-</!cV'Z(CG%.p93B35"E-mGFVa@D%)1S6#N[M<]A72J[6.CD100hTSV!tf&
T2+<+;s\,(OrR#ZD6Vd[YE\&)h9=)N$h=bJ>Y"BTkP34q`H:s?Cm'$/X.eCTSaI`GJcpi?ii
X\V33iL3^RLJ'*[1F#W`td0$^8BQ^8?b;DPW"`Ih7tnP4*E[#q).WPa6h#J$)t;L5([Jf-*<
$J]Agr@lI7?kplPNlK`$h>4PfWf]AcegW^?qA6S7\K0<&7^K:<r+VfhS*\B]AF*Y8la&Q/@tE$"
Rj?"NQ<:I2fVmga09EETW:sdr6WU`;/doDlU%D<76XD(8MGUI+Ye1pbOk/k"`Z`S[-S;mdbM
-T)ks4.TYEO(u+5pTNknETbHbELMI-G;tn>+$$F1da]A_rJ^_*4?Bi/eZbCMX#+a!3]AlrJiRR
b1'LXp`W*\$TuH'rR3A-HK@g=G+-SJ6>Pb0KL=-?X]Ab'5JA2_bH\XZk!Yd:T!8.1X=liI5^g
($#muDnCW;MHJ&R[#f^PO,J5=_%Zam3VdBPl1S(h1q8$cm7*):>9nAdEi--&E/:0juA"^>J/
[4W'B=CY*(P6Tk&8`QZEKJk6fj0*^.!-Skk4'<E;k"72r/5A_7)<W/a:o6X-9[IHt>@t)J.D
9e[Fh3l",78AXE!3;fMCP@S`EW@26%>>,m1QL--FT.p[QJuIW9AIo`r3C%fGt#QSK)*ak<m=
fIRG>69mIsJ0Hq<jrjg>2#Qs^TFO.`.@RIXVPcu#UA`u@W0]A/!^2gAGdgXB%5iH^p#6B),H!
?,>f1\Eb[3fe5H)>\oMMe!ropRec4]A#]A@2U%2#F1Ml\0fa</2rq\WI>DK,.gG?4MOEug&i3t
`LVAI1M.B,/E!b1bd$F]A4EmW6UReIg(5ZL/Ga*ii*!Q[hu#dojElQP)(ldT:o8Uq!9V7'k7W
O&?TmVHj)jJ$3``[P]A$\=Xb[M#Baaj?#'oj4^'oI8ghAg:#rRHpT;;OlSRi[oYb9`l_sN/`^
WS!Q>'d:o9<'.9NhsPri03Vce;90;^McH#Q*2%Bg/\"8ZF/=$O\^C/%91apl-7<f2skVO]Af1
ZmTg;/`YmP>\ao'rjWm\qrR=c4`R*[d<%(d$7C4=;.%YoeP\[(Bp2AK1de,FB>PUjmr-G86b
g;NFm=QGihd4K`S(j82W:P3G9qMo\>drB@Mlup0,4EF"cfWkAX4jAG)I;q\c#\`G%&Zd;XtV
"tPE36Uad>XVA0bi@WrT81etQg2[9@W&WFZeoq"T"?%-':aCINdOccYAk$']As)TGb?i*/%JR
,W9^"n*O9`<Ci9kDodVi`Kt(4j@k\FH[SKgN6i1F*Q0+b0HrFdNo9m>Tfo/!2d+37[LDX,!t
.:*@JThP3o7k7QZ''QHIm/&gZ(j$S"I<nP=S\jW/ba091o[9#a&,:k6-Nh&@K)5L8sN`Z]A./
)p+'Cn1AAWHaPd<c<9"MHNu@si81aK87W-&s*`;QZ>tX4l6)Gji*Y]AC;WiUi!WYHdm.,26t(
A#L8Q9`Ab2?e6'V1"V_@;(RC/W(",pT*R0\dbQN`Co7&QR8u9"B7&:2YGL"Z60!:03`3cY6%
?@.*e.lDK@N+J7!!>kuE"r]A*H<SfI:<=!$]AE$iY_7n=(aF[,s1Gl2Cns0?rR4$I*@ZgeFVFG
Taiu_`sJb-X^)#geq7@Ahk?=^ihQ6k."E;=2Q@9fJJcNh$U<R_:_GVtZmqtF<"a0g;]Ac>\GY
6C1$8`Zmb[f%$61C2*.:1MYQVp(I)/_nX3noIEIlfBceIf>?`sR<=bt,F]A/s/*:\sjn1TB+]A
<>M<IVN)JC.Q=:)m3tFql=G+PKZGY$^HsEt!\N$WrII!W2g`gD+@Dm=12podP@o41$/CTTQI
YaKW>ckkjO/G>7dVu0&>,A+>TVDbFo@Dn3=J:LBBc;T473Aq#/#$Vl(`_grA,aPgIF-5pYWp
H0OLA`qb]A#,7M@c7%"Z/U-7:ZsdfZ"-JrF?Df!>"IU&_eaVFN#VbM),a3EAE7A#m]ApA2[&r,
?3#5`O`G;KOb!H;>ST4i^P&Z(LU7;or$0mYH44r?B<X)h..N/_^h)IGi)5TCOjlBYh2>f&:R
9(accIT^*fX0;XEMJ3&J5ZR8&#K^_Ko/mf!^#C]A#;*"\$ZCOHjI-$,YO1B1lnh"[\$8`6'DO
pj`Z5FC4/K!:J)X6W&LU/#UtVJ\LcWJm$q';@._a6,.Z*VOq?CsUlcR6_V.ru;4m9]Anngl6,
RRkXINHqNH:"W'LOX-1me0?q7DH_b=saEBXBa$4jX$\r,NPc*Ks&(tg,YYi;oZ'(Y@TkB[do
>ng2>0=WMR8=D0=)*&e$I1o&7HO>1P"<]AA-.SKB1%]A\;q*(c?tm;_gRT_YJ#<?gXr0lqKgd(
:Xt;rel$Su%,0D"'\l6LYqdb6F*e$E%44,!2')t-JJdc^mR?G9N@:,7M=&0P^d#T-4`F?[l#
:[BM\DjWD6H,0ioVs[(n.SlIusJ_>#`)9jaqGB1DtKpipeg'a4oR$W'R,X]A<.Dl1#3l9bCGa
`'m&re>-!m`_8_cWP#kabVF$Ra0D%@i`a*@ID3+'('?#:K5]AIVA=_d8511Wd]A`ZD#CmLNu@[
-'/k29C^Rh:Pi@&L\iWcK^f*l/RFh4@pa<MD<._5=CV;-ic`YUrXag$o\X6i3BL!1GadD&'p
C[7/gY/\J41D6Ip!I.Qf;W5!SPT.)#K:KdqJN"ofjUU3XA0h$/J]A28+S<4gK1tU`Ubi^W#K(
`*&rFTl,H/GA"n(%o+Y<Ws\SC2+p^mR62:iT(lN#UecZk8k+c9i<+3FleOOHb\77i+XcDsl+
7gBZlm=b4<&g,`R$_M>a4+*R91fSUt.,,-'0`?M_#Y(`.F%:Zqi)]AeDjdg_MhPf+gIfMd$]A3
"+O%<2&F&7T<lhhIP6j;`,]ARoP[VR#d&iAV1$2?42!L7(ZYS_pGjXM2a]AmQeiF*(a)fO0GWA
.;("&S=uN%=faaUXBT\Q%XMqZ$8E<^S)LFBV>6eo.T_C$4S6P(^1-[4=&daDMuSR]A>ArM']AG
G9NAUZ4ff$*GfBt`RC)rM.['[0/QX(OoT,[^&,$TH*7dfjVRC;SRq!>]ACq)"00jq[Z`+2&\Z
=auDIn7tP4W=;R"%e3VtEk8#P>r3"g/gt%rVEldM]AEkJ]A%"!h,ZN_)`#5Oe&U%LB_rMYVWBG
eqGcEgPIa1al8YocVL.,Ltf>R-J<IXso,ZC\TIU!n;9X:M_PC@RTbr\V:;Wd<P,`:Z^73)ST
[c$02TVLTZ#P*WRUd\modDJGUT$+FWA=gX4>ahZ"N^od(lGGq%6=S`LcJ(fC#F"XC!K_Z2)Q
LM[9i'Kj0N\RD\e*bcJlhCrOT<(R&1f*Uic%gb^''SWlLHm4^("0GBH(X`p,:Co>LrLsgJHf
'E;YtU*=3g/;VPYAS9ulKt<Z1DTdFT%(?r4Z/k<37[T[jeK,Lp??O>2Ra*P$s"CWIDcA_Fk.
kU]A3XgmE+N0t"8-0"q33r*:Rrd`_rq:"P`1OIOrt%R3"Y`%qiIgc&Y$i%#?/9OTk":3tE?4:
hTJ1/TPimXlGkin&F#(47fe.!<7TafSf*bMNTaj_>_jnRR,iE?(>WEHFRQA"@oOkAG)p26_l
)%'pR$]A3)A`D<;aEK*uK-,N>G<%FE(tlg1!Bn\3!!Z6%=dFWU45\p;dK(`9d<:>S_pi:*7e6
snHrS*e6GUh@8!l%RkIb"lm`lD(D1`[DaLAk-E4b=W5*lUMbk707P2eYtm+`HWC2Iti#*R)-
l)E?_V`ckEmG*/":5LRO1JWQJ)7;&F6:BQCV/_6[eq$]A^4i>3e#$&`:tXls8Xr0uBO(pG;ME
LDDeb4$OS>:fLjpf(js:I4E"=E+'LKl%`%-gK\$*Obn5@"Y\t=iIf<.PL8pMk=WE*PP@(Rou
mU-$`YN6X`mcfOsYP*/HIQ5?R>!?iE<5[7!l>B[r4RUT_=SURU=.VQ>s#=>$T+9WP_Y?6D?0
=*)(fq9!/#PpNnX%@SXs/-a."D[_?geho?$k2BQMejaO_0^@R;=a#Ebc^*JkjEed3S^;u]AGL
Sfr\'5et>et7$tmVG(UT$MW4+)h)KO\jA%JqW>L]Atol7*rm\.T-'6F2\A3n\,-p_pi;%>N'$
L/h\U374hYb?-(p<*%0_3Qjll+"+&UI"7n."'4Bm6kBaWgET>R)h0obY+)K#ba=R42Vj/Hb8
%R0LXVj5Z[$fp:XU%KQ,Pc=9KhPW0AJqUkG)P>t7VQYT:DU`EFa(1Xk67'k;,t:0V4E>?6:Y
84C8L/2&Xk=-.a_Nd0crKCU.6a6,4N##*@GfQd/.^UHe9W4#>\s0Yo/9rKidc&QTL5;ca(3=
_aX@pG<aOqpdM4\;"M_R8q3F_f-4mD+hS!kq8M(7'L75N]AkakqIKhKEY&Rn@\M@'_]AQDU/#k
b?^!\n6q"o4(7n<q%,"5@J[h$t!jp)but:r:hWo80>/to.J,ls+[,=T8l1W.!H`U$oF]A']AXD
O\T<"-VXN=&(i[\j=MWLoWcVkAR.X>rrC_PfR3#G)2q[P/n:fLK,M:rS)Hre]An@6?T9;3-ok
a@KIqS"J1]A6t7fWlGZ*-9&?!R>b0K:o^2?TeWI`c,hO40M8^>#g0[:;Kg]Ad#g+GDpQ'qtS8P
M)<mP:`IGUBtGg"!afppiZ9lc0a9[iR2N*H-NeH?DeZC(NU>d;:j+e\C\)YK5gHK"q*jVtMV
iB*Pup(mD_s$U^STBBY1%&7H107!]ArChOnIXflW=;WPCIDU-(fDcC\-&0/]A7r2CY>`M_N<UM
TcO:Y">,DKT-^rPa*fi"l`IB"T3Ip8-1jl3&_[V_X]AHZBA7d)72tDqJSoqH5MCb_H!&[/k,i
`T)tnsqe7YX9=c'H@J4D[-<uIBcktA0u.T.VccImTO4XI?.!RXd42G>t7/!K_@#?V4c90Vr@
g<&]Ah]A1cL&/Hu61FqjKI=BUdbk1.KC[uEanWa5&XKUO4Y7rCCV*81GL+/.rS'-`@^-bN<;;F
Vg[-#Rq?KiH.X#`Ckn6uG/9't@G/c@[u6#<kU=bYm(LUZT<1c+Sp3HW;nR,a4\iLfIl`gJ$[
CRndRL.<?Xk=/foNp(VBh^S5k;m+Z9cK/b=O-iROA2XkW_Ws-u!.mY2Y;TmuBRn641Rk7E9-
UCH,,--s-jnkjG:oGiqZ/In2o"Pjn*%jKA,KNN(BJJL?q/lCs*=f!ujFDgAp_Lumk#s#Mal'
fmr<B<&gQMi@`WDR.8bCbT5B^l)E>?&,1=GGCATcm_?f@`f/F%@1R.(q(N5f<VnN2f8N6*^E
(JVu<&*LVQgk8Q[5SSS5a<U/G@Bb9"1\[5=2]AA)2(c>MH;<8"]Ahi@j0JKa!Mj7E6QFF*`cD-
VIZCq5*YZO2S*X;N(H,7#l6DOi=9&WMA^*5[Wt1YTCPc[Q*^]AU#)3g6"$)f]Atib=aZKB"+Bs
_=)._HX(eBd)Ik"`\8I#W09L;)e*4)*$@,b^_TGj(ZX`??nN/CkiB!ktbc^SJA_Zl(,&^sBf
*EFFC6gGCmjHK)#+-d>o"*1LJqOBF\"tC517X4GE@om4/hm>qD^U=kQYEp`ENAkl6nHPt.'n
npjk;dWIK^DPi\>%g`fJ?rHF1U#Q[hrhR]A%Os>LA13Q&YI@-Ere8Mp#f`MLck5!1S8;[_)h#
`"\S@&kjbg*sM2+l"Do4DM,*)fPR:NNX`IXq!Z+W=ZZeB@c!iP1+p-tI(SotQRrboOsMA<_D
H7*:OsLq'1?D,J:\S]A8(<C'&cJ8_&7B8Ilf?6d2M6Fh&r:XGb7X#O"+6MCCcI,J_Z=N.]A^Ao
oc$$3oZ7ITuVKFp^^+f9b15+P8+k=Ei%Nq[(%WbcB=tO&_p3Q_#H,7H+>6lP3\<0jr3Oq'A6
slK,*K$ck+k*2bfE&fb$<"pc+LIN#aA5`9ZLY_U)B)JFJcoMNl]ArSddQqR_q"C3,43s\uE_,
MUcr?,O>)k.8>Fkp+cL`XN[KbZFI-i,E0%X0<VFAh,3JkT%p#kQu<tU8Ka/FX8]A:4N3X/Q.(
dfk/:Ub).W\$LB/(tk%*"'["6fO:E/9R6FuqV<oq&E#TYMU.%*X&Qk3Bkg-ghX=eh>X9ga7"
4O//+A&I(tdf&P>o3V^B_Rs0M70QFblG\-jZ@q"/U&-@k/dh7rS_X6,A/'V(I9#PEu;>1j2-
UAp+Id[_\(P"QoPG0EINg@&G=jiseR(_ms2"UV:]AAIFVg\.D*crRuf#@he*4``YNR/$'`nlW
YHYm3/G'O>m!L"R(-Di_F0#92qhSa\]AadLcFcX$Y9qagb1Z!)pM,Bhcg>LWbT,Dr<,?n!.He
;Z4#$):EMah'Xc?K-&`oV!8sEUK*ehc4V?V9MQXU/qAC'>s*7;NLMoL&E,=#=r@Y]A0i3RA&l
,"pgQLkjusJs(m0FuFg(E;<l29]A^@'-SD`<(-Q/%Ta56$`/gfrkEhK(J<@HK`/rK.grpMt[R
q-Y?,#k/q!3Wu`j@mr16+a9jVR_gEDg0d/(D]Alff)S@MV`rdaWtidr&KMOF!S?EHCKpX89]Ab
`VhXVOc,Sp)OG*\G(i;"poIqI0e`!0SmL<e`^"F4$g+pS(O)DZ++Ai\nCUm.G+aDNU^e/a?f
\\:hs1lNccnS\p^%"0oTIW+50g3g47-7?ooWQ7V9o>ZN@LR-#]AZo"TkXjQ2Zs!`E3]AHDArj&
(S9tdi\qXi&#bc-61)#XtGT+qaWfa5;AKXKT'DlD7\AoTXQ#?3$.q\;qQgp_mHG!S3o;?pQC
^lDS)=k58>6\^tKUK9KR8Uc-N3B3DK:O_cq/'2d)Js-s7a"j^r844*21<%GC4ji<Er-OJbDP
"CW^Dk5jh;^T?S`0A8?/-jL3:n&*D\OXEYlFlJ?n@Q.%ujNTWGCmq3Ae%\KRsliOu@pF>X)u
G(d4;B#'aK.H"':\8/')`eOG245=A6A/tot`Y4jSlGT+9bE1,Xc**W0`OE*(N_K8-MQJ6';l
SIXoaEm8Ni3+FgCPREu9n)h9GS"_4LMSY#j8cJZc8nIen8eGna5_6a<Nah/1?;_LD@`@WpeV
3?0$apJWU.'$3"*V%LY7iS/5?79\,>&,jNum:jd"OIMbHF'N:_Pl\R`:qbIX9a4WB:!RW=PS
^sDEK;*,s[-`$\&#Dr,MKe5^k644pfa#M))A?oT<]AGLHkI\&+_GBUSL<%E/Jf.2`T\&lK]Ac/
5K+B9-?9hu+<,*uecLXZg*J;`S-GFD6F*A"d#W)u_sfk7.1DGt,Wg4q5M&$<\D/c)sT>9[(4
VdSJ.+?2eQ_mT/(coo"&9YBp[K*5CmQ4>\=2dj=BX`SP3(-?5`Lq->M3V1n^79B*FuF51Icc
X1>@TTU$.&)[*,:8HW@Ut1$YUQ6rjOrE=U#cl,(f#Ct#A0']A<pd2WfA#(lo`B?W0*MZ,jcM6
0LnSDcDYe)R)ZK48QT&@d#5EZSg"9uccb)WAF44E=K9kUTK-dEIc!IU)TQUsN5[@qM.-'X/S
_3;^mMN\D1]AAV:?OEWIUPJZ=fUi2j$-.XrD>V?K2&UR#YE9&Mk?sZ988sq88YJJEHf'6^L^0
h@"GXcKl3B0Vt)0:;+L9ZQ/AD:Y`Cu!@?\6AKn?[q"Z[j^sX\qpK\ecW0=>HoTSc6H+j]A_Cl
GA_9#TYqRj?\"4XSEjngBb>jtGbtV$$9I]A;H_2`bUPHXI&k3L=f\sq"?S&K;1,a7h2;0t8RZ
!m)`G#5;K\Y5i1V=:(VT4(Di/T52'8ibNAW[3It"QqHjVTofs"$7^m"k1M&2_qD;m'8J4"1U
pfcA::.HGoWt"k#,W<<b$gEGfR6Wj&5X`JIj6H`?3uYbJp5pqlPoC9:i@lO93;J+.RB_i2qI
-V6\g*?A3rm>6eD]A_\,aa`2T2"&1,=6<kl`dfp(R1)#7De);0QS@GC>-7+V!..^#UPtdSO8e
c>C:_HZa2V$6dm;Tuo^_2k,,9.V("GIH,X*c\4UX3e]AE-[=fZDR>Vd,enaYYE63,o(Yg_t(i
#@MEHjSinDUs.V,I$P3jCV.Tohd"gGoY:S5f`n)P>%La/KaGu(5M8>@<2U%JV!H?9Q\V%iQl
t9^&8GJ=pIOcc1&rJbS\MAG"`/P&!^$)(>hn.NY3@;Ok1H;VE5N5)+s$jm7UC^*;)&TfI5g5
>#`"YKHZneS7I+:rM9>Sp)TL8Pm&"nB`>^,BEh;7FPL6jS0g5^8ta@V=&aiP=+qNgF3G";,W
N\2=&,,[c_M>J6*_TY%4:Zj?YU"->Mkee3t5Q5oQ$1p5$GE'0B+(Dl/O$"g:S#+29!qtddN'
Y_j-$()AAmH:D#o$M$G_)AIbo+WT:#_U=)j82C&Wn-DHO+G8l4poo%sR$g)N<u9e#?It?@=W
K<]Am$<1unc.q7.Z:W8&[9ZHnA8N.I]A3c?iKrQ7'1^3D]ALjgX`h=au$mYR9s[+SheGC_:&5)I
%f*&E)@&ae^Ve>L\Jee[^^0mWZW^@Ip"dQ/&eB*n4YeTMAm`DLVs_F_)RJ'[G'EN[oBd1*3a
NEV#t!U*Pl*4%]A1FHh99NL'gf#l`1P!XUj#8CSjH^uGWM.bM">"!Q)k9VGS5nKC):df/R6m0
Ra,:]Ajc_AHDOpr7\(M<[m/@E^(j8DY$^r;l&i::_?EF"B4hhanamNj4"phKRn8@N0;W^ShH!
%OOiG5F^+RNDZC<kFpJ.E+9+_\8D1,RZlXpR8#7\7X8LA4?2ZXa+anQU8fPaG=%IhG>&/tup
NHBE67@B$2O&cZunGCJkRf")8r@-ii"Hn'U-Y;<kWn`,s7KV\m0L,g(38.-iSG</lL!sF%N8
9Y/tEAHQK_QV%,3.n]AWB=RgOP8:AdhdaXc5>V\[d%gf"OtI8AR,*JaMZl:JNNi_EA(<@BJV"
.CNe`BN0mNUaKMs;_n=_1Q""=<s#]Ao6AOO)N!6Is2o&),[6EmU1P]A)A_O3jA73F]Aq7dq/>L7
k]AX!;A6lbUGW+BY_2gL1aR^@6lb3TU:J"51iZdj7otKmmhL`5c93#3DlkN=9$T$SrCL8/I#[
*t2rnet&qSODoL:2<Y[<@T_7AU6H+M*J@kQ2l:A*':s`Ok0!.He'1[a`/NA%-36i9jJ9]A5,g
g>i+AV$Mp6cAAcT;$]A<u)5+B`!moGP4O;rn<:Y"^QF#\-.kD"I\(b2RdTkpALQMcEerKi9<p
b29II(s&jI!$Yg++O/U^bj`+[7%=gm6e'&7FW'cp!E2[4P#"tXRO"X;1`E$>.ism'?Ef;+P1
XhGkJ<Cd9H5H,`8B`n-h]AbZ7A/of0[H10b`+WGH%;ZH#nI^;`.aQa.l3eaFK7Bck+QOCW$t9
G@R#28n;u@9Hftbnn:bMI4a+mm5L'j.nMXrb+g(m0Nl/JJB&0.\Oem`Gp?qs,t(4o7?4TF6L
u<2SDR&e;X4\h2Ol:Em#!I[QNTchia8Ia7OmV^/\_$L*f)usSfb&UkMp>?e"m<;e#>*,Bgdm
&D:[V/a7H3oU;):'dK5r:0pY42/-GKe5^t&a3MoSN2)Viu7OU0e+7o--%Ka'sPu1n>IK[njk
;?UbS[d)<1k*Q,FLG#6*n24R)13,=7>7'kOouG$@>[,p%L[_hK>_em*du2uF!_o7>g<EXJ&O
VX8ZRH6@`+DkBo)GGVb%7D38ic\Er"d,&L)D)%iI;L[\-isU6A;4\K4%J^tPai'?[cPhSK:S
QfrT3s8<PYXp0U12hJMmE6]Aoq-K8+.fga`['E<$Z?--oRDlRN)1,c$j&%>o2kCt7V)D*Q.c-
;S+]Ag4/L[_,844H5M6`8KCEi;Qo;A?5V^f!(c;jU2WE3o'")&-1\t$RIaM=5qs;]A,^WjX&E)
u;G4Hrpi,%u3i^b?fd[.&@$Z:%\KNRJ8!@WGG;IedJQH3B*ufEdf#&dFMR@4e?3h9[faGgj!
&kn;,h6E_8Pb8tSQ1;N1NXUp&G^`\#8UqRj!U\=F*pP?h8lQN8;#ldNc?\.lNcrbW$uP<Qm2
nfa6G+[7H&9o]A(F.+52MUk!`^>Z4tuI'hn$2i2?WcKOt;"]A04`66O\K)mdD)l/?T-ZG(gBuL
ZX)RX53k`7HK0ql/S16;HqB_X<,"!55(9d42]As-,7ZQ<*Q:d[#"FR:G+#aIQ*RC*IJe,iWEI
D%obM;9K>il_kLfr<g9"^%6<>@Ad7g!-$@0e$^S'9q+r]At&>M2VhOVhjPrM46]A4K=5jd#*!d
c'$UQ0)@jFdINZ[Gk__;]AYY*&!hR5UKXHBgEEg@d%DU_p(Y$(`F3d\t\o:Hpb4ZhG0-QqmAi
O+5oQ<XJ7bU1NNUM4NeOJiA/-'"]A)SdOpI<qQ@eDBb8<<+d;YDW0<DN8MEBYJ]ArF_LBrYGa8
aoT.nW%?fLY,C%\=`#0>hV&tcnr0G%GCI4>5N>!&[?S.K+q&[1d)gS8DST%'hI[o07j@kH?@
erT[p3BMhVrj$Q!,L$LRUM0[!?!1;k:_m]A4(8GXoYAbh?e9EnV+r1&U8PL^U:P9l`=u6+hR[
f+MalN8S[FCiN9M^eQV<i3V%T=(r2MHI;TNG,FXYOi.H5lqF%oZ,b%Ohd.$I8rWA!CeWHEYa
"Hg#%#T:,d,qcn<]A/'_C;cuX9HTqAk..P'9(QNufT7C5<^J]Ak`n!U3Xo<5dEhTaA0@>T(VuD
Jc]AJh,JaTfsYq]ADmS?h^X1Hlmh<Q%Y_;8EKS=$O,geq]ANR%Nln)iZT-:`o^JH@tckJ&-4[?P
tOlU:nn/:G'e]AcF#)f,8K/2pCC!-0^i\'S>s5k7*(;bTfb`mGkN*75Df+ClpB'o0['>N#=R"
s2d0!!q@n.X]An\md'f7&'KA-XPtJO7:dT/R^E$WYXht/q>\-i$4a&GAKG+0%+e:7DM3g9B)r
cs:5LeiRf?6b;Hs^XY30kf^dtE=bI$*jmcDa#$gjbuc!:&]AW(<qOkM+2Wud`=7s^'[eJq!49
.-!VppFuTV0=5LE9Y2pr[b892uUJ0'`Z-ctXVH1#.!Tmq?ou(UhDU)4kaefUcpBq9j4eDONf
>/nU;d3-RK!+.g`G's*LF#\F]AhW7gplaV'>a&4UNAijXHr.0V?X4kdZPH:sLE$,QW`Z=dY.O
#M,5PtqStur*VmZCU2PE*o6%*8GCNCg@/*0Pp%@CQ=Z3tdaj+62[8IoFpB+kM_fRf6-0l+06
EN>g?94.gr$B9]AH:X\:kpbBdHnK,KuCYNfA_-oa$YGj&dXc-Z/I&hmfKZSo^G9M9.q5JI[5$
&bC:s:Y0MFDM1G?9n+Am`:"DCm/b!@RRGcgF>B]A8t:#?4F,'c'dJB"a]A(8Ig$&f:"?,_kJtc
pV.;Wf2`lpiR&VC:-o&0ijl5`&@t?f.*NP)_IIG_'TB((l4tg5<<8i_dk=%21d[[n5A@X$,&
@1$:O67-=otRmi%.u)%K1_Gf8F[h)NEM\p!SHap"<AVBYdQdA_XaTM#op-uP.6#+ABDc[Nk"
/h(pgS[MKJfE`&u"C24Z#di'J_?ZFP+jR+S#0ntJ3MbQV]A3`X5*.'8mJ$Cq,p0:cR<<k;00s
>i0udH.VlO2:aPPcq2-&-S-Xbl/t]AHC:#dM]Ah[*l53'RS;Ch%HdIn;eJS<k^*D6]AfjR(RQ]AC
'_P;,k'.lr]A)f1Ai1/J)':b+'JBe>Nh_"JT)'r_?=\`R>YtDKZJQ8qnW$*O,GP^`nHDqMS=A
SZ:RaejSmV#V1adVS;S+H4^=7*A;W&TT+t)lcrj:@hfg1`c"o;9,5:B?rTOPsLGd]AVWqFuR8
c'Hm&?ETX6O9nKp#9Doqc8AmZKY$^BZHsd)r!/@VRX7.8%0s7s+aNj\;PhS-?Dgo7U>@`>7O
stegMB9\',m3,0hj?Y&(=\_7$Cr0?iCAo8TccGNr@&d!/dN#@EAk+4b";FmbUYD19TTa`VN[
*`%tV\]AEsIdnP[85%')72KBA@;Tl_QZ8!f,#)^V(873pj.jWgMmc7NuBm2o:#N%<qes&G)*U
"n%,M(AGL!R5AG*ogI^&@$@N@"/Zjk%)]AOpgF%MI068%pZ,AE)O,qo&#mdN.Ej2^kS4V26=3
lJ=17c.!eBq5o$3IRKG^*aR83$LXuWa?T&E=SZujFZ^n2"rCPLLS6K9]A^7B+p!?U^__S?k';
sjP_g.UAH)CD+;p:F9\pBeA%Ob3eMo#6:HX+[i5:`VSi,*:)Nb_5il;n/P7\[CY'T6h17ESa
2G6`<UaL)7W+B]A;opLjg$G2?e2]AE&bj7L1+@UrjGDCT9+p<g4ZfR*np#b^d,//.A_2?eHcF,
3e;qCM5S=m3o-@jd8ZM:F_K/YFgK]AT<<L]Al)e=Vn3g3,1]A<Jp+'72eS1:a&<X#p/]AVp,SpY<
69u40[\f0.A#ZF5["aE!1,Dk9^_TIjVJ(KWC16F:PM!giCd3O!kS`'(h@]A/HD)u7W5+N,YnR
t6spC4&&i;h,oIB[GLHt$BSq.ab!Z?RdZX;q/Yj-8_._UeESg@2`(^_)Zu_"KI@k_KGbGuin
gkN?+)]AJl7u67brmp%P"Vu7qB')%P6lj>sC&J=dFSuJ+VL:FP`lKDZL;r(?-<SD6S[.ap:Q9
3fRsB]ALeY.[lGYSA^:*tl4s25(8BE-JXH0h@J;9SmUPs7B=*qs@:U+R`N^S:e'!^te#;+/#,
<6<QWc)4Ii;kdY(H!L>,V]A4f=.cRfrT7Z)%IF$G*[qrFhL]AeC869RMo7@q2Q4X;]AG=G\Hc'"
eo(@Vhe'X3?B=.QG/E2ffU.Y3_e'>D1c,F;d&Q[)s*U8rOVh\#i37TGi7Zf<!ZhS]A#UL]A@#^
E`G*(Q;Z$U`He2Qe:";Ugfb5K8Keg`%Rsi:gr1"dD\]Ap7o09!X05e?2T)Mh=YWNeJ,D%:g?K
a"m)"9u(2(App&\C%4C=<[eu<4dVa[9,*aj5=-e_X9DQpjG+Q9HhgGKbKLWF7WLFcoddQrrT
16ms`/hQ]AY.S`J'1MJ^B_hNKg:Lm@t'@oTI,7BIunA]AFR0691>A*$!llS30",,l,bhKreA-l
6))9nP51WLa.LoIoF^.*L>qcM+e?blPBa]A.08\R-\0Ypi2*%!-*+C^qNWsj3f>g9of^6Z1.;
a.<`fJtY,mVn-&LAr062UFteUFr5;V!O.Uc_"Hf\"4^XaGLkG?ep1$1M.bs#:B0DDbk`hV`8
LhEb"#;#@r@Pg"a,aY8CFJ`H^QI^Mc)pGa4Oc"YH$-k+s1:jV0.dA7jn!F[n5A[$Zr:RWQGk
G'>(fngc"Q$.4'^)u3VrFPT/"\/i(cU$`6#C3Ao?acN?]A?#W"ab4r7<c4'8kGm1mppS')C:d
1ojb=\!Gsj4I%P'f[S-:>@M[hp.PRr)#K(8pEP_<o/i/tPqeMma3;):-fJ`*Ua8Bir)YBI#$
KTOfTYOf@O<;VA.nA;51,\[6T2kt*0qK(`uF"0`kTf%`kF%iLX8!^`I)C%HYc8OG1d>O8G/\
IWk10a<uHm77Vd_9U6I6RW+0(@6,<4=NrhmN4WI!*W7R.GFBNlg$L0O3**6Sdt'2L6sbWcsi
XA'9-0NBAWo9b7CqXgFACrKs7m#E!5dIL$ADrRaHuJ]A>(gh410YOj<$4p*.!q:VBOr)tmK!B
-DUrJ?"<u`J5nVN)Zt^PC]AjR$F]A[HcOP'fT1?q&$%DemD'GpBDdRO'l_VEH,aadtRS]A_3D7&
^!Ha69$CXL;6@mT&C-PGoas%dr1H2uOe[*eV!&^Y=ZfJ<=*M%dZ]AbXet%.AglsV3'6$6o>@k
?Ei;,:P%kucaShHO"e5aEPc,n!m?$hWl8S+?IT:lIn`FlEnH$16JcBt8[;/[T^\%sT<=([\o
(CTh_?Iu1sHq4EGUDXrd5&K3bQk/6^n^E^Zgp'jV8=+cEYns:&]A5:h[__I4OQtPiZjg,d>3K
dkUmYE+I)0lq3e"FkcPb&H&$d/(75XUV]AY[a"UNQTiM/.O3"H7jUgkjN0VfEU,r--q?Up<M(
@e/(6#OY`8C22!gA^+>dHSY#N>B8riIP@DeRj(WpSY[o.-%Dj)E$Spr"cSr.=;K%#TN7;77!
!>as&Y\4hta/kB,XU:Q!Y3nSfJ++pc;*YX8O*]AKJIQY9^eh2]A+6NbTLXoNf;%E<E`G1$s^0d
o'J&/nt8mG)AYnrC`.PNN.Yr8!Yo%(:.T9hT6`P^AZWa+rFO#fo++3fhT*hG"2+A(JjX+ZGp
EiRn_tZac]Am3Q`HH&-90uH\I-q8=\IVp4RNjWt0AJ'^,LkM?CPu\?=P*D;'q24S>.@'sLI)\
TKrYY2X&1RoGF2."YelLX9EssO.iF&NfF2c;_`KsFR[LdZ^m*l6T_RiUFVr5>%En(p@YP1%g
TmX'@cS*))9Y$><%GdO<H&_>rK*:sF0C`=TWf?X!GfDf$Z>4qG%eC&&kT*Z"/SJg,PJAl.Ac
9>P`geBST63Q0KCZa5Qh&&:&a$qP=<+";!V!"?bJ=PA[%Gl1,?4s?Pa-9g:)$Ng+ACV/4]At[
3:#R8>Q(!U<4fL]AQqHRt=^[Sd=i8A(<#m%*fb(]Ao[M1)a=C%[q;IW=MT+r1rDrZHP4+7JcSm
EgKRO>o%n)YKYBe_YNg,-e[(d*ct;Z=1XpUG[!A(tt@+5u&D*6XtqhtXFOg!7<jIMLko+4J[
;6-t@"&c@^-,J0tbB5VkVf(mi$IDn(O.XiA!mSW5sC0H4>&T#4bf7oT>F\iluaQt>D:DN\rh
#4OEZtX]A*F9)/\5IGlm;-e%k.GlMf^V3+^;Hcm:[^#I30)m_b^dV=U8tbpJ7OGm]Ad/3dE(2G
%c5cu./coS!#:Ld2A^rN5:?$oH'qtDHuDEAOhALUe9L;Dq/EBS&JNk#5EOtLAMPl,HgJt&;_
)hI?A^l;#[(fVVq;]AHG#LXuu.h)uS+dSk_+gqYCCr+fr_:(fj5<\OY%KVCX:CDA3qP4]Al)=>
9m1li7,qP"*Pc9PADh(um/X^+QCL8]A5+?@D#\NKTG<a@Ue''7QKEmZ40<TSfM4FC`Dr=#5%f
BnC+PXc[Hmgnjd"8*4,hB:8YmHGU:uBM;_qt,cRcE152n5%,I&;7-/qZAER:c.(8[bTg$$)&
,n*tH5Tul$ch.HChtGf>-<lu-!D9@M^NKA0VQ?:h[KR$_?Y#PeUhOk=o%mH!6NXe%.&;t+fg
"FnYNEg#MU&>_nP"q%7k6uaP@`FkJ_%QkM)1_.^7?Prdj@H]AC_F@e"fpA-(=%6^q7Bgc?g_c
2YIU8hELIMVT8d:5II!9U)3D5I;1BD>8LpO8=;"Ng,eVIq)caBXY0a,6<2H]AJ,M'kB!"E9A]A
HDq`*m:G>GKf&TL@`Dj\/lPI_Kfm;N8P(?mp6LHjS9iaKFk02WO4,f!<Ul!;G8dn8Z=:8r.p
Tg02\@&PY)Q%fM;I1":"['R.<^ZfQ,h4%7P-M-`[gR"1'-XAfC@.eJ[amj-=\oJ;l"Yb&W'e
2/Z=PeLEi`hN)B,k):R+m]AHTICg+HOg,(MU9akHlfk5"r^q2#!]ANDa3,YaHguMlK35^#IN>#
&!FKYsR?B&'f4gRj:83*tbXJo3Jr@:CuLdU2O"Irh&>O^RXiNne=Cis_=;*)P&MeN0`;oHP!
B1Ubk@pEudlW^[V;(WAUg+lLm1JpGj>'_mOL#*=^%P)d<(gCX@]A<r?OdSD7D.#$-QdFOrA4O
ScuEDR/7^U2U.(M+OI#QjV5bZ4THODBc5p<qKjR366X:#Kj6)^VR"o!k:"2D&<;=AIVI/J#d
ASS>:-HQCqfK^;`9&2Jl$D?KEZVX>`O;gfV[W$?R2`f"=0V+N0!#D;N1qP=WZb9R=icbl1)G
VJ4II?QK)O4N;91fdl7Jr:m>F)4Zir',$e-Ca+uXaXhQCD:d`?LZa"YWnXr@'@"P"1oQj09L
F(L>Fb9^#E%hhOl4YYpX4^)qEU*:=%^eH4_"'c5YZiGTunZPI8o:+8%e\l=\.V&#+bb]A+A2l
&]A\LtJohQ6)Z6Q#SM(<BGUNaVpi7K#i.:&apClkf[(;c3H$C\+Zc@m/F%#k@]AY2UsFSP*!VR
Hr^h[U.86TsSQ"NghVLHSlac6NJarNfKDp/48\Qa=UFhP@<]AF?/H>^&K/S+@+i!RYB1!/[)`
c<rcT'=c:j*]A'q18k*VngEq+f&[[8D:7X8,c#Bs3<?UQe/GMWjLXr#+4[!hO^9V8U&b80N_M
C%#^Ep4+QZo@O>-7bC"+k_U8bB@==WZQ6W`-",,Q8<K4;9T,jp8j4'HP#Ik'TR\R4gAeW<HO
,uK\uBU[0I#j*[B%0-[d%m((IS^(HDIE?%u0@1^'eK7O"nV<;<oda&D#7RL=K4l=@U7[[p9g
@0,]Aa,M*JJ9ME0L!8=kP`0TkQ:dDfo\\bN"Q1FPi0t$!)j'mre3YfmX;'9$i&;0gR_m:`PFT
#e!**_A8MMir<A(i+6<;UV]ASWh?r[Z!UUP3fPaaA*gJ+?Gb\O$RgG@+mO@)(C45&Bg$9=&Qh
RPLsOSB<9=3f<*`%Qu$Z.#VXi!</>1pG39s=TIkeb&-6N8:=7b2q)ASL9MO)TX=0dHKg>%VA
Z0e@^s<n_prUPm5Iu-u5^b""F(p0"FU63+e\_Ol0Eu?+5Bat:!k4pHf>fPODa1M9I0=B`5,a
G_hlDV$n(5@p%mJ"%pHQHFR^FiC7P-/`,_oT'"?gI1\[E-[$_LnSQ/h'hBfMQ*#smT>J%.sn
_1<Gm6\6+h8%"(=>T;1NBF_M-QH0u-NE>4;Tf(3iR`)5hek\m:2hWh7Am'ZXqt7n[l4@HH?r
_(.L^kG!;><DP-OiC7i[79ja?7"3?Z\m'8We<pS3D(X8,-i]A%/"'pB?HIL#RX*lA8"/-/`4j
ScBogs5'T!@lGjLh,`kr1JAq,'A&7L`R/Z2n9Ui[$F/SE`Buh%4Fs&#H0Lb$<E2_A0ZY-G&<
ZKKWe1h1d;ERubd%Ggh`f+.hOW:F+Wurdb5nQPOPK'a;l'hIRn7e@X/<;tJ:f0W\`g[c6S3?
fdF_c]AJW?*Q6M8b<]A\'1&Q/PCbrGeo0Z(0RG;:*cu<T?.5G&TDk&_h_a&kX(_[9]A42p_+J)[
-h!]A.2Kh2HERlD$8E,iZl2/48\3rS&LrQT;jL@R&`6>8<-"+'Tc^!fKb0Lrh;NVcenhD@I53
h+T)*>="L0<Vt!r,3A7fp,MZf"Y)*:ELJ0OaT'<0g)jH<Mn52LJ8mjO!W5Y^&.OL?$=2B]A5O
UO`kBED]A=ITShXp53Yl%=47fE^m96C)ZXjJ(i^<j<BK/lYZ#%N_!`Kc9[T'5/!,9772oW:T]A
)W?`'HoBo;u1q]A7D+cD.#+Lu(o1M+a:Uk8&[@Zsld+MJ?%WuL,8S@X*DRW)J-lA;Lle4(X$I
RWA3-?1DiuHLMpc?c0jLJ1`ZZ<0HgTL3SrOls&#XYY-GTDHXU8I"(M>YsN!*Y\o#,G^TUe2k
%rGOJ&g2i@_p$0%Q_cfC;>A^uUIQ@J/@6?L2/gl!(d!6BQ22-7c5=[DKNY<i`/n[In.gOTJ8
7"l$.qXsa.WF\p_]A`\9*/9TkmXaR=TlH1BM'EDh)FL/):B8e>B_E;p'$Hs^-fYD743\<SNgD
1c\=)Bf8S%;Pr]AbS%[qp"B<P-4<mK$b<K!h-$m8:b]A8P$thP>3IgkH_--]AjmpdsWNuii8<,n
7gJl*SPY1D&9dD:@N.b"E3SgSBQPoala6S`C+HU<!I/qZ(DS;AFmsT@`HnLFT9b$Y\MM0e$s
Ln!<*\NZ;b?2QJDhB:Z91$k7f1+iT"%,:)0ORO*R78Z9Uc2=VDlij-^g#X1PiIPHE/c]A<`UZ
cJVL4`/B3S\pr]A]AY:B;S,;5Y'_:pneH-2P7EKuiG$H^5rDUd!`B[nqo=$;k9C%sLgZ$]Ah;#C
eWJn'90jHi\ghpKqoK$U*:[o1CQ-E;(Y"d/S<-]AHDKV]A=4EkrnXJ#G[,j\L[Uu2#JM1F)nEn
VJP?8Jnj?&EP()[B?rK1@q9K&1H,WuGk=Yk7[R.]A*Ia/U@>%QYCik'+7e?7`KWo^bEX#GKBh
?ld/h/Ulb$0US8i3K[F/eCrC:B5RC#&QSF_"emD"E9=-e]A/7+DBoHNXG[2Lf>18Oe\Z3e/K`
KXqY*58^c&`(I4U7g^dbDU=<[j6EjD.CA40X_rIQb^Ag"Tf17WtZiL8[6VcZ_S`3t7b9FEgM
2h?<D,E/!J!,jA0O^\W)j,s<//KU&*E&1$81GN9Y?r:2-,S"]AC8p5=_k#%kb<6Eq10aJg0-p
i,mLV5qO.\:@n/'#S5PAe4l8rS\QY6d_ngsLB?[$2NYYX,TTfJI_F_:hnE$",U"IB<eHAo8s
9\e:L`SOVRR/HM(SF(]Ao^7dcDo&PSh.>`=7''gYOSp^@ikNIi[c0kU(B8`R'lnQu(:"tX)fP
lPkQZ;\f]AZ"=[TdT2>h;^ArDcEj*+gIbkb*>?J1ih5Gnd"sQe'?>!Zk<Esa#fbpoC6u=9Nu6
!KSe[J6OT=7k0bfU0U9S+_pH02/k9KN\>HB0WBD5gkpP>fcfN97>J5%7O+^/Cf[Vn1C,<f.#
+!/p3!0C5b8k`*1CAePkf`@!p]APs_JF[$:"K/uS;k*C_Se$n;`_]Ah3N#'uoDlp(dPn2Xk7JJ
ft2?.Jg+"<J';(t<1VY$ZX7qtH_?$:/CN4lKe)Z0aT1[`u,:<]A:3,h/b9ChfMP]AqCSRAZoV^
N)Z"pmAkq5KIJ#`lYT%jUcH>leM*3IqncLm#Onr_7SiK.Q?gYaa2q6_>&cG;)=K-T\7E`TYU
Ip@,:[Q/"5*>VKdg<Tl'aHeNhlJ[5`6ehfH_H"9]ATeugRmpt79"%tODHR1dP0%+8K+pkdP:j
2A3]A=0Ver8]A'YSj,;2W91^!Xo:YeCR2$h'C?UQ*I$=M9P"$\/9!@HMAiX]A1k[\[npQ*^?CtL
N/s++^A2[6IY7jd^p0Iag9umYoWM<Tm`h*2fKii_K/9rb1WV;VoP?"^cm>&?q0UWg3._uPB5
IS83W[i[$L1)jdG,b\*:HaTFr0>fhB<YWLR6M/=au<i=0GiA)lHG;6#fI"!F(CO=Yi.9IX"J
DV/NOjLhTfG;'ujFc+5)OC_4I8nu+^X.9OZbTJW"lkOA:U@0'ZmkFFnU'ue4C^"UD'+Eh(mg
1(i74"i"\N0!C&rBm714:@eRScLd:+9_LQj3i32DtFA6Hr>22[r.@']A)%!`=+%kE8OX3p^&s
]A7Yk`@[As0G'bcY&5na^rck0-ptf9&K#`tqlm"*&;[=['$ni,L3<fKNs!$F7\e3-!pd"]AAfp
+1<4=Rif.Zr\s')h3in"C?L.-nC'*H-:```S;7R]Ak),)?3B.efAJLB0$;s7,83ZiD3AK:r4q
[hf$P`gp#*ELS>)$^NrH]AE*5P?=KO.lQ2ZN2t"`b#E5S**9?YuINE$$NSL"]A%j]Aj>D;:qL97
0^r8"AGR@]AhN(8dA@=LTV%^krGBr?]Aqiol=?N_[)^[k;RLF2H2UcF?ou)4,(NaOP5Tk2qJ@2
&pS(j>[GJ[mS*d%_Z3g#N)SA^$jRi[LX3jq[a-lX\Ge^J44IKM11]A[jX^h?8cj`>W5s"NQPS
QJRhqI&Ad+q#da9ns(G:iAE+*Q7b(Ef$"8HN<a.0ON:oM)sp[X(,:BaUdLu6`84N/M(RBbA`
mscZl$R4]As6jB7f5Hc-@S=,@b70`HS6r7gu^DeVO=+g^Pim>M?S2IOKHgCH[<oDt+M?\\^3h
ta1q4uuhF]A#D#r6kggW#<FHn82CTE.rc7</V`RAm)Lu49$fcrIDVoC;jM:ioAG=/XD?B\M+(
_6M?+j&gK/q8!$)JN//IU7g_\QRIKe6!["UV@LXc"k+70ZX;p-&1J\I%BUaYbSr)[XVDBmED
V$qAfL0A0X?.)*M^2]ABTpXJJ1+sLl&,$@N"rojN's1ZY_jM711lK>H?S779/'lb(6$g86_k&
)degQj0/HOUjAWl'fb;8[?%YIk-M)ib)ZSqC?A7KFC#>UW*(a&jK/Ru+LQ:EV@!Gnj#Ma`Wn
ofEiY9.)&C(h6%]A`MaA)n/4[+UP@+SeW6J[I>s@V^ZL_V=VY.NV_!K+p;,tOF"mQ.Ok+)bPN
:7UR*#7s;0SKV)//)uJS#?HY[cuZ'Tp5HH!,mR0?_K$g&J-5VZO&n=7F',2b.>bocgVfa`^W
aM?URAM4s/.e)7Vr#^\q!5;&s#:L?##9gi`_Tq$hT7JGgWEpbQRfY7#<7FFWShr3WU]AC>9\3
V`qS*Pt1TdJa[Y2DN2u3tlna:WjE_/ImHINZYl&d5uoJ@iQCG#Uc9J.eSkHg'm,SCa,DqX\#
O&:@&Ho1oA!0%7NZe/tX]AoXIp2uO'`//(LME6G<oipV`=8575<r*0o5XObI8]AU0S:29Ztg>8
\MI<MA(QMk2EHhtS,q@q%W#IRZZ,d%6Td"uTuQsMi'C%cgSX;(1MmNJ3fcP0DGrN1l^^6]ArH
h6_R>N%G;pct2#4aOi;W'I"!3CuP@4<i_'*Uag3kkI5dRBX]AATr_nh$@cU)#F4GD#O>92Lg4
<m.(^)pL2+N?hi-C/[THfL0q2rr[tQnOTJSkDS95Oi5"3MI*@gN257O):;E&1bGH3iMf4l=O
[Bltl\jrCJF2]Ak]A:?.2'QqSgflXq9[/VGT>^VRTkF^e]A:Cki%H8pJ#7h2Q#dZYEZY]AWlIT74
7m#D2kOd)8'aiPF2,r6'AMQ0>aFr35Dk]AZIUq4l[.$YnPgI@D9MW@s`%.!B+MC/MB']AX&TGh
ON@UMm*%X-lojG\i)H^L\R.@?oIQ:Z>0#B1)$S+)(2q17A_XG2nHLOO\rkif-32jqkPGuq00
R1Q(M2_hPK/a>KL;l%e9;>R+plm[s47=A*3h401\'`8Z&XdZ,V?7$(ZDMl>lmq.0t$>6E.@:
\*)'&FSu1mpg8-eN1h_nR[2a1uXs7hHgo]AUg>6JWkCV&NBa0%C/b6d?I':YccS>kb+'*N?rL
rg\:TFMIHcbN8N,e&8*':V2`#g8(,I9"<"$Y)714(RNVJ;HP9.$^3%OC_M?[GH?-%%@e*Lu@
V&3!;'l@jFWf"#rg#61;q;=L3?($<:0k?=&cRQCFZ8ho0&M]A,8ab1Mtij!"S]A#;4jTCArY4m
D9<X\gj59Fl4g[F4@e/4fY-Z7G5Q<2YGoOmLL\?-VJBfP"1(A#0rMCC:Z,')V.1]AhqU@[".N
(9\+Z[/ZP%\l:Vtn'D2^W'6"R>7hL<*b"VTb9Iq;NL<GpN!,9JaCd`tb-_-gS[-&d'mf7`(F
Ld_dN%V^1((BKR\@p1P#[NR,MA$_"Y;UPVW)0/dLn+:q6d#*9K+jQ3nsp#G;h`(8"s)E/)FM
<!2=$`of8K#UL[G_nP(P^3@H$g+W?:^_fCCH*6B##R4Tk=eX$@O:J-.q!FUZN`=_8LcmT9*H
J.^7abaIT$QKA%@e8+:"ZNQ$\_7@Kb&GfcK%s+(ZWsYIK#Z2;M1B3L=^1C)XWOUNr&B2"h2E
Zc:tB9\Efu"IaUhUK'*).*a:Y=n.<'Eu\@BMa9aU(Gf:VV=H[L<'52U,4.3nZ.Ib_'*n6d'R
djL"ON(*<K:Nk^bU5g>WQI*>j=_>UY*[eFW*0[S<*J[q'nU4$5V9g]A.jnG#h7L3WX*.2N8d]A
Z@b^rm.?#!q?n47?41>QBlE?lpYu-Q73-F4%O7kpBZfiI).;50q_,pmb\`1g7CbcqCh`6&W-
9AO"6B"*_Q_[EJZ:"_0nlVbd=s6A(6R>I^5B_jZ,+3>'UNMJ3A>HJATIqEEI/m_c\msU0/]A=
;'o3r\b)(HEk]Acb,J[Gs*`NgbUITO`/f)8n%n%K''a-4Xj.*ZG2>TD$rcDAUK<I.32_e9<V]A
9O,T!!OL_C6Fp5_KQ!FHpl_CaX.'[tFCIZU.;7BoJUfN`>;u$6.H%L0'i0+Ub-]Ag3r>,eZo#
VYViTq+Oc8Z`+`inRiqskA6EF6;;nkp^)o>f:LV1g8O\m!=9]A3'2alR#3uFoPamf[ugfc_E&
SPNl:Se$F<(p?]A;LA7A$2A1JVMrBea!!<RZ?d+F&fZ!J4l`K-aDFrYP/7[#Eb5[()3-l@k2X
Uj/pp@Pa:91"1RHh%5bZ"<pi?+p'$--L2=IT[hGGQXF=ZA?h.CZ6+`p9!@onbdfA+j25!ZRS
PTapk\b`t+*5mb=?_;"%/nU-10OB)s?KK#;Da:#bm@ksPQ!"p00MdEsJ$ZTPu4M>oeYD]A'Qs
Z?1s&I;@\emku'%9P.lL>I#h:6^sL3R@2aamC'X]Alo*&2bfjlr[[<o.r?<F]A<_73'SaYFG1K
s+GP,_,SkN'aD*BQ#c#MkG#e>h4BF_e?RZc7F@rQ!<A5CCj\/&8"Q%oDiolG@9<BjMJW[\BH
dq;&3)c"W+9gVDqO26QpjDbK/7'Ys8-*/:i,X2NQaR7XWtG_j:\CN6M&)k8Hb*LH^TiLVEJR
S+cp]AD1E_HQ\oGoTeIa%mG5?+oliO\64uFN<&FY!1Q&&(FRd7N.C:W(S(HT"fDXaikI"(5JJ
k+mGEDO9uQ62&3-h2ef)2p@*Qk;:QQnF2aT@a8SW9hINGe.nUJhZ_h+L^UIL_,GXhJE]A9,2?
Fq;F[h'9/ka:+m-h')Y^[,.)pf4DGiMi>pMqGhA;"'[lM>\h42/IE4b[DDD.LZB>P,")nAEc
ljA9mSEmA<2T-e0=h6?F\Z4_R5f"q,k)t=.-FDH;294gE1G'oFm\/;^J;J3j:'1:"kCj#B"&
?c>.)*2\KHXfiP6$)8#mXLr0I8&:7N=dK(rY<AG<lHHj@F]A5NZl%LXjF1HMuc7uOH'JQQENL
tse%n9bW_0S>D=(t<aA@`([NVdq:\HZ^IK'namYk$Z8\$,e*daTce+p=&!f&LZP)i.+W*[X1
L7Lt^LhE'9EdUaj?T[2s2KdWksXh!;eG1Sa16oY_MV&2"^UI5[Pr2DuTb0UtB_GNQo[!#ojf
Rj8p_kh(&8!IeMsLN'=s[TtUGWtJ^Hg/U^uAs"&gQ_%_G"`2V^N6[n5MZ/#OciS#1+l%t:)P
Kj(:m<OP:;@VgC*r;LQL^(`J;Y1N.j*7FJSsi\0]AM<nl_A@"7e5C%m7Q3-+hl"=,F(m1V_R9
r[Z9GImNAaG:58U#NZPn\O7A!Cd650/n%D9sBJSD5=9>$QCfl,,OM+PK/mOL009&2u8572ro
>\\dQnnh_f5_kPaX6'&Qc=V5*lEh'>f<,`fokRW<O.b:?!Y2:9T4FQ\fE*PbeV4)0B1d/Atj
$u,f""D"DkAn$B\i!?6p*\m]Agkp+u"B?)WUf2"ZAmF!C4dfNZGi/XD'=[q6^jc)%P,BGuU^-
^P("0k$Z4$T<Re1gGj3F.BZs&,DG\i00dDNF8+ng-'$B!g:$)OVG:Ab%bo<%PLQ<`5R#dE/=
*%1\huP/al?og#(6H3Z3[.NGA,ks/7.g-Z.`XMfOd6L2'#G"dSK"#LXm-dU@BKX*;;!%-?FM
3\fCjN>^4T:'pgT/+XT3GKF+"HnofXead2/>FZBs#]A0kb/PO@O4S2u*$a,aQ)hldVJ]A87c>:
:G/PJm+GNUU5Li<%cW0-Or@@`S\<laGqNpbX8/hJRm87U2'La`5WEDI)nEj+R@D.>DClk&lG
Q1&%YgoC!8TSdY6gt#Los5M6=6LC/sLHM.97iHfMq*[FTKb$(L.(F-iUkf:b0On,h8aZN*jG
Q5OUJAYD]AF0QG=h@I;j!']A-Mp2cB\IOe%\.kF"d)3CaFjP<Tdip%$q58]Afu5I'5PgP(2W=>"
<Y83j";o3ksh@g2Sr1G8M[<V]AFJ"V9^3@p8pg4rF&-cH<<:ZZdRd-o=KD/.9sTf6dA,1&Nk"
ZO6FgZU;6K1L8=h^Y\>t0Y"pS+oM20CR.]A_q/8LJGL59nQhnDAHc9H8%158&r$LS*t^]AU47G
iBKj(TtT!;)44SKCG[i^H1TQLTUZf?,@C:?+k3pQ,'Mt(Ts(nOQ04FhJ71tj7INuCd/J@.om
)5IeX\nI-6>4Y'sKnaWjr&"DXH,QQn@T((6&+k(rA#Si%%hp,jV_-Xl#'aXH&X1eP6"`Ma6J
YkuR"Cu%;[)>Q5UVL=\t-lo>bf78j?AtG,+c+nL]AfNJ`HTdh#0*#C7jGI6,OU:kB]A@Fo@5N-
&gci$MjTbu71ZDeX5t^[`F)Y.[;.$3]ADk]A\%He't&ZL_$s8<68S2:g<`53n'NFb%""g+bttA
Z4dL"U9T-Pt@U?.I0QlAa6bLs(eB`F(ghsd#(,JdI)nh2hH6,8"im$Kl,U_Y_b1J;a7%,@QZ
TY=SCF^QqUr5)8]AMHSGO.!Lt4VbrNX%u26)Bm%4/mZ%5P>2iZRmi'gV0P$DKJUd'\7MJj:n9
khRok=kJO!aVB>]Af\0kiH"2dpNG:A6t'^_YkY'^eD?c1hdje?c2,6!@@W>)a)4iI.QU1H$)c
"p$V_2n.KK*5KReCR2>U<KN_DNY-%I11PV*+os3\rJH`Tk@#\TlcG>+@Hs(gQoo@K-BDMf.H
<?rd[7G\)HIHN>)L^[f:ZaO?3kLg.L#Jr#pu?:PO<^nC'Qa5=dafbf-O1&asrZl8\i]ACQpG5
I3)YSH%9fNQjYd_a/f2r&&j:VJRptd-I0)a@7qFDcL9/N(8l*W#>g-%8oUAG.@Ja(=aTquC@
f+5qN1X_sZ26'4D<D2gqm\ORY[8A)[cc^R!>2#2M%rJnYg#OaY3mO5e#?&1J^';k"?_)(N91
u#>r<872KRTP^BHNR+b\'BVfcd^6D[TIKK8n>2j8975lZ/9B=E'/n#0Hg4^t/_,<DnZ!R3=O
ULI`h32S&Xe)"X5qhp9uaJ&3en2<Z+-WSk\UlKEX^r>:AeZ@I:(XG<9_M82$Ch83f@,IR1Gk
jH*(XBb5q9s8%jl-Ne2LP?\%?H<B`UA:J!7?uMMC<IZ:7o*B9UV(m12*25&"8)8hqH#mS"Of
T:2h`/.P`$#.CDV;$EZ`KW-7j2_Y._DU%ade,R1t\RATV&7iLP[-l:52jb$dseBoXAB[<ACZ
S8fh!nj9Qa&]A$a45@OB%Vo,5JZ!9(1lUWc%`)Z)X[^SCXiYTL>qfmC#0`UKKcGt%QoFUqEY`
h-e["#@I.8psF#pSMI%r-l8K=E7*tn,Ako1Nc'fk7B/j%jhQgGq3fE.msBs%8%P7r%=6J6+E
.Ao<^5D/<:]A(G+EH,t>Gc^uIUnqWC.;c/B31Y*2kf9'U>I_DU%i>pP<V+<P.2gi8/_sM52;H
N'_X;489>64m?EV]AMg!k.qLG/0g\$uB)e5m*Tt45iC0D!]AC-Eh(gWUeO6cJTG@iH[kmJbTd@
4Z9p"0/lr-6]Ah@C>=!1gp"QH890A_rcVo'#u9+Z.hJ:$8gJ4HcVGj%VPM`5McY[&WrG,(ipX
qc/uj^PC&8<;q`+NF,'8XuO8=E,/D.o?B&$.u\6kC]ATW"0f$6)3G?85A"A5:BJ%R;`=1RZ3\
scO_rE0RQ1]A-pk7*lpLD:E%VRr1.TRVVJN_W*i:fS`OATsa(`R,W=f&q+lg"IqJ&g4Je+aq5
SQU[&J3SLD-SMNlA@.U.MBaJ>bXhUh)>)VCbj$^S"CRNr0Q\(UAngf+i;Qq3Rf<U./_G_l='
eJ`0@pYQN8<*V_'Bqab;VredS1&'g="@L<Qaj+M*ltPZ*]AU&aiHsbCMQAS(.j7*Sp3^_!k._
81Oe[E#p.&paTH@:=jo8I`n9G;$nuVn+7Li<KFCZre?#AE-niX-W53cYZiJ(d_t*D:KMk+p"
Q4K_8Z3A'<3%$G$k-/f5lC->7g/XA9B&K5:^gC.fkCGJb+-Z$cVij+G"A,ffIp:<D[s%sS[l
l;Hl0st<XBH0(2m6>*<Z2a&Vf?-)MX+/QQ'EAURb/2iIIkR^jC-J1iFZZ<Pg:ZBgZfLB;BQ@
NuToeH.!=]A<T>m`ElemR+Y>\rWCcpF*2FtFin8qm["o_KRArGg@3TWecdT.B(t]A='8&\ACiV
n6mnk.$&HcI8E^B+8R;#7E'R9p'kGd3&WYq5>tHC`]Ad>9#a3XOaR8+9oeaT]ART1*)TEn\Lo?
R9k&j>0ka/MU)>\o$,hdR\Al5(Bo.r$rk5or$a9eZa!b?eD2ND4T91jR6U9@+6Ed-jaLR+6c
#";tn:kVc<i.fB\bpO?ecSl&+!n<k>W4Wlc3EC3M9j1_>%^:pI*RjNoY!=>`LHV"3ToSV8rS
#&MJY%je.Q4lT<N_-cZ"*/"^g_;!ouoBgc>$kL`ErJh\_3%E(L1*DRF<7$d"5cW\osm,]Ad&S
Yq6Srj(J`h/`tC9%bDeYD>Uf\hAu@4^o(]A463;em^YtMRnPW`6NY.&a\,Um`V.n2#\qVCe\g
K[k2G7*YG"d/LZX(c2!a:f-X[T"`+Xm$nX[`H$5d/b;5Yc.KO@YThePJ)3/!Op>^W4E*fq;G
H+>Di``f.,a3@uV8Go"J-YtZ4pKF]ACdBrF@\22Qb;]A)IFdlkR,3od$kbj-m<mf_Q/`2+*Y7h
6DCo2.B;cZ"2fgCg=SZQrh0%9[TkG[q6!XmQW-/9//?T[n[ZjgI4Yc_)gP'%b``]A8^:?]Afq5
EJYrP^F9WIHs%c`&K_/'lA[r`3h;!j*u/e$E&$S.DJGKuer>9s_lhUTTDiU[MV<B19]A((N\Z
]AX-#aW(#;MMS]A8R8oHWe\TmNS>edI<+A;<nf(#'NgC<?'m\i9kMBMpHJW3DYQSm6N@VcF-F3
)hl>[6T[9=R-*%$"AhM[(EUnBAin+'lSMJO&NaZ*<sT54j1%JQi+\'$*54f,qR"i%_qEKUCJ
!2_SWW]A[,`#)['hUMn@t(rI0:tmMpf4l0hns]AU0':'JG$.5CA5,oGPhWr33/3)Z_jt/XtZE#
J%9:Bm,q^8Kgo'6G!*t4qp,qS".[3RrK9pgn'P&V`J>ZeSa#_TdP")+0L.=p5+`8Y(X[YIoE
#B!D!<_o?^2A%HW_Sa5B7Id>*7SCf#3DTUm$\2AJ<8RQ7K0@WO#0g[(q_$o8<()EW-_6\Vh*
a`p3]A_n&!u3b]AUL=7%>W:;OY=d&kJ*nrU9k@')ldm^(9Rb=i<bYRE=cr.5g8f&Of2j(X(bcm
4N;M^F'qE8P@2(Y-DRN@&Saemh-1d*K*'VG>bdHTPKM@Q07pgf[kCF^Na$W)^6`R\ZI(P-=S
0?G+?La^Xr%iPl%pOeQcn6rm#O9+-PR"o"JF4ilD0$^NC".]AgX^N-EaJKCJ#?Q>2r4%3p^LF
6aMpW14U5ru=B')[W`oP_c,Nh<86j<f9R5\(FZi0f.:5feYS)]Am,21>LtK;jLk`0cc%6^7Z8
6X+^F\4ZUgHP=<^nMf<=(p@=<c`j@n@>q%h9uVrQ0W:O)Gd]A\Fk@GkUc^*7(7*Ph%9Z*mif*
52cC/,^fT!7^JJujGc)F@#6"6l_r+XU@'Nf2[1Q4[Rt(H4c@@:6:c?Rrb1&0,[.SsJ/0a6e)
MRXC,H.=Rghg0(*cYNC0)"(p*@FY]Aje/^=4P#UJWF8,$uG"h$a@#MUY(SE)gu)"-G:_taGb!
)c:`EP4C(oY\2LLSIk)N6o-Qp8=[\8S!@]Ab6;8[#c20Z(D`Rf[cjoDhGB<InD.A^4b`O:[@r
9VKV1I`Bg+-i#tGaoj?I#$jD#GP)J-kY*D?u$V,S"-tkBf`eEj*$*2G=$!,O,+53M28aV7F4
$0UCkcH3(/H16:?62D,EICVrr#HGag*c&*uDukU`>iK<lc45b%)llIP0VW!3>L'9imAp[<E[
Unhfp7?@URV@i+EC54$hYK1s:qNQmm,F=3bb"&Z''-)(L_iW)?7LY\On!T#VDmIcZ!5Xl=gS
9!L1l<-.i<,DZMd/X[_IAHAYnZ4f/B=.:bNS[H(e_USlEc;^Y6/''1Lb;T$.p:i_O/;M[>?`
$)Fk=%P)RNu>2f2"=#b[$2VgS%jlVph@m<:q&!Yed8nC'DO"D0dg#]Ae/D?9D">o"JGpdiW;4
^D8T$l^tT8=m+*&WQo_hn>PM/@eR3AUtLt4H"uY"5FIJ7PBpQ=4KRe,l;Z/T>&:d':87Y_/k
aJ&jg*V]Aa]A*08hmd-doV`s'2@f#/rdgiA%c')/eTMaqbKriMLSQq^,&a^3t##L$l@4EQVn"D
Zdr9A;C3Y]A:g1X+rrB8<nB!E]A8i'3WcEUu2#$sM__MXU<d3&ctK.>iB>7_G&"-HR2'8a]A`O[
tNT8pK>9!SeW'Dm,#.]AdW-'k6,sU]AQ!DX4^r5Ol$[bKGi3abGMFb3VS\GuEYj4%W[&qti!pP
RM1*@#@uls0(7/td`n$C0ooB5JW<@$OaL$C_(9t&Ro*]Aq&h8@.Sdl@A>)\1_3Lcl9G@GSn?=
F7S=[bPPI4ZBu]Aa2u0=0\q8IJ^(&/)ubSs'kV37)'&!HbsH"ArO2A)!?6=BSrG"cFQ&aQe1.
I3W>kIIh0GhoX&TLG/]AME$Wg-fIj&$W/JISi4h(IKoq$'!nb`[B/rp9;n%cPrr4C#Sl)Z=tX
6`]A?:#lN96_eTol4Nk[+7GCWs\=$mI9qAdpRV`i$B+$"W:<Z0$c;R.=b)7$IkLS+%pZ<jY^&
<hIbR62q#oGOA%=.Lr,kOsA6>&(El*u6?%2o-]AG]A<C/NlF;8)h#/UB+si8)iO9Cc)S)cFU)>
Uqp1R7GDYBT2NI2Km*X"_!QIo;+oU*b$S9;lb8(2V;Z8ZjGoidaQ"[?&[LEGN.UZ2[GP-CN%
<CSKCCURE`"3<5;lr`6eNR6s]Aeq)<A2_"#==(U=J*mXPl9ADa;#9pVMnsh-?r6=2A;oa9]A7>
oe(u0V$*(.ik*8G`R#5"L?<D.g1AhpWdW'N78NMNej@AIoF/4P[S*XaE(fQVrb>9!@I1e*R.
9?`m3%nD]A;_pRMrkdZ3XVm#'tWTuNer!q`Hn"SQtZXaTqV-"/WY1cOg<FnUVco?6t0X=A.M-
W$!)2\E'CV3a"OarGcfUBePPB$[6>OUEgO[(3aUl%,oc.S:"efI;W$F0*nimp260m3%raaR1
-\LNNV!Gi6_5-(\VUn=FP(D%Q_?P4-eM.LQ'H&n^ActRmoZM1FE)HLR,qWG#>=LmWLap3&'L
>=PhVj)_90YtGLc`hWN.I>i<!kWWG_<-_)7?<V.]A;eltJ3>usA&f[(M1H_gM;tLi8L2cpA>r
BaherS)_>P0@%9nP7D(oP<B$?mTQ^j)5Zt>auW0,bSf1r)S:=YXAIJ['_,Wg,Bp<s/5SOA.A
Ce-CC*5#`+s&c*s,qn#3F/LYL`cY:;hC,6?]AK@C7G&Zg;9mCn1'i,pJLd'qL8#bSEUsgRgre
[/=1c!ji&72uPA<BnDh&OJqn#132iM7`JA7-?+Heu01FhiuPYHVZk3V[oRUJ,&Gba>mV@<EF
>@L:]A@iUhu)(d)2tZ4VQEGkrP@ec7^_!Hk1oaQ!"[(Rg++6UK'LaWS,Sq,6L_FMTjI>3?@sm
E)WEHMOg*RO4fo17'm=5'R[1g'u#cM9@/k=,!Y_aBY-tcDo9tC[TESiZrNsc,cT9Yt<h5MZP
;5[\#b9;=`Jq"Cg=,2IMA4GtBFTidJ=a?^(IrPskTIb75bt=K]AMSe83+UJIVVtYS@@$"u]AKg
Z5T5,Al`&1H&&2DgMs!0B:KD`Nu((snCBGsa_h,M/aeUoia)uE#e]A$*GiF]A5!Ln`hrU?h?04
'q9+U7+^LCA(m^3^!5G6nZqghtL-bh=Z]AaDlsqBpRKLTd5X4GJQ2HP$%)I"+KXY_"Jb?e*l>
EL\&%Kp*=O*3/Ymtp>FT0NVNJ7%'1`D=r-!:X3Yq,ZEpf<Im"-CDDfAXRr,G/<.C^5Y/=^E&
JYZml]AM,Z8M0m>Us6NUNI9r+Z0g;+P/gX*'KsU*C*A;$=oj8hGYR_q7^@m=T$;juS3S8emPN
QIEto<!K@7Rjf_3??R:NB*k<kj\jO45n[p>0`[uVX%dD#!U!l0,<CYViTKl#s5HrVMl.0=p,
Bu9foCb%_';^j,j>A,aoJD9hW+rFO`<!W'lEB4tkknl6b+pJRJNJMoZa\XJ7>V9%u21-hjpr
OB*B-IQPSUb$0B>DtZ>`qTL"i_+X4Z)0hOOc*dMsA>oi\hXl":st95j)$P_FV(L[`1N-41E!
PP!W%r@a1+UU@^:Q@I"('$i.@GCN52Sm'55ST2Ne@ED`Ys7r.-Qr%.uY\d79n7b8Q'o.illA
W'_/J@"2YK*'p@h4-=)ECXJnouJqL7@A\'..,?-%P8:Pe!rTTNfGFlnV`[a9DQT#>Tg^50FY
(Pp;6"e5]AZuBmujqR6Pg]Aph8(X"^uo7_V.BuM?O(g6V=/)UKDQ`6,L_YmcCE(ea]AS%pSP.;j
!b4^'PKZrY]A)Hhfp<-bFb8i%?W?g8DN3gt(7AW/_UT"='f&O\^[>5bI8N4<^\sr$<?DPET[>
'A08d@8lmorP\?_7YgdWm5FoU1G$#>Ro-SB>6hTh);_rmu:3ps;GbWjTnZKqVDtBUh;2e(?<
s[M2Tq]AP?Q'']A9@\SS>pZ1G;V!<*K[\2eptM+$O4+PTlT':X@1\n_g-K$f8TGJEurPV-pcUo
o;pHSjgkql`)qhghb9/1!'tsLC<*_ZYUI>DukMlX@*rOSUQJUccoA.(?3pS#PL?CF5Oaq!eC
IT;os"+,NVV\DOnd?nM(iL%i[VET+eQq4%s`lo#*h&E6Cl"-?c<L9\\.Z3-]AGVC(,E4Ru`4!
XqE8"6@a:qnV=7lrnn63jPMWMfF\2Ghp.o"3Ja2A;lNH3S2tiNYtrO$\qCSh@,o\+CR8ClF1
N)=5L^fVeO_%6=@UWgXV!%KBn^>(?=VNCh#p@CV=i(/(!"_&lZDA=f=pocM*._Q;QGH]AeUF]A
bO3>X#j6"n$B\.9hqL?96=@8**miuiS&P$$Sr]A',sDoeBL;SF%%SDsg3K$mB$Wj,E06AXR+T
19_Y,@MEDGeP?9Vb0'2*6F<a#.>WQWu?tG,WUkm*5HaZdK>a3Xu\:YcHpHZ/XprEV"g=^.9?
3i@k6>$mGCV3k<1`0iJlMa\Zf^r!o?,VX\#:,Y"gQ2#VLa2*r\_($c_?BhFRU]A#K\TI89"1:
3tEFGG5'!l!k*=Fgq+2JGZ3B>D[>-c]AfdW!pS``]A*Z"LgK48/s6\'E>T"@nK_Z2T=S0?J'iQ
,NJ?1GPIG?Er*&$0JN&'s_4`1`*)Yi4MN/D`Mk9+MHKP!]A>Ui(+C&Nc0\U7pBHjM-);h(Q7A
k_m&*GI;HS;JaGC"@f)Po82oEOY:5GHL<8rK9n,5/%.JRO9?&'g%\jlkG^eCc8)RRFRV^K?$
Yb>gkFTga0Gj"hbq)..WMhj"Mp`iW'hES$?_'!"K@HQZ$Z8S#l^EJ47LYh8P:"5W0fH-s,RZ
a[eLmDCKDb"*Q<J='<Sk?5dg91$_1%BK@.l7j)KN.4?m6!#Z0na/`051T,+msEq\G^E*f2Yg
%4!YSfXEjqMbY\^dtM+HJl4m3lEqaPF&N_q+U!\@!5,+$+I%ED^.`k'psEJJ/>8<Sb2oV@&4
_o"+XZMT+(N>B`$]A#US</tRFC&#<He!^;(u(bUZ9Q91@[u4-HhmraX+170BpW6`_LB;R;g6.
fB-hS9e@:,N$lqZ5HA*g_a^J'&;-\X2cFHZM*ouG6P.^na:$([VAK:>(J[]Aq6PQ#5Z0(ip@l
B)+I5otJj]AR66+eo=&gs-#g4%E#dn!B)Q*IJ,W4^MZ))j5!<ip+lWLUh:Sn/NeBC64B>)T-[
&bf4Rn.ahuFK-XnfY?6"ApF3L*H.kuU9db6#u/'$;O;`/q0fEM\eESn(qXi:XN2/b5eSn'qb
]Ac1J5p<.^[1mJo$7095FnFm7,Kl`=Ek"R=3^.cJ'V^Y/3b'#V$e57-^oU)dSF#I\p84MCBGR
[4YLhkL?1*/ki7+R6egNK?OO^5<t3L%MSK:?IR2Uka$,C2mX0.0KUk3!nc+:BMne-FjF[\1P
t[7.O)IdPE1*%R!(/F6^>ndtu/Z.:;G600f)/X1:CqK764QMO`(JoCX$'a_Dl5&aTS?>>Wtl
Ie-"=,*64l3''t64cKP@2Z7YnQ4d6F)nT5qc)^Sj:i;!+q4LYB\!PtmMtMQ,6l^bg*APSdn4
Ao)UrJZ#.6P>d8&CjL"9t!"uUlep(l[b[<ub[3e#[W*`51r6BOWK*]A67&Z7VoD&3Hu-T(N[5
g'`]A14d$E^0%d@,Y,N,$T/lQEQ-)%J'_tpt\rs1/7SL35DHqT5HWN>tl@'ZGJcSV\IhN)_&M
7#n,DXZ/^3AaoCdhHb*!u^)1A^`_^SCC;.1T%8fPZ`BB!l7X):67[r%iEJ&t3_JLrIr0A0dY
QGo#Fik\Wlt_"[k/=ZS&Aln_^c9;aXlrlda>HrjP+eo398"u`lLq##8VbPh[Lg&Letc"n*OZ
H!BB9Z[!bXOI&d^2lqPY>QF6.TX>(%hH<sF[ldi='@>.,S>*E8&4i<dg*)3I>Q5EiaW:E3Sk
P_DueXVP2:FWa.m+8"E*)7g:VBW(u464DA%sDRB7Q9E1@DMD81CGMg6BD"4JIsan$L,H,''g
`*_8/if4M9Ye(>kmr+2B#F]A&KiJ*_F3Yo'JL1ANnH<>SQ*'`8XO5K@n@-=XMfR@uddKnJV8/
GZ4WVbh]A?GC7&?njbXXa"`'(]Ag\kSfhF!LF3s??_Z!abHqt+Imr0&&S*+kUH_Bu&oSt8G?T'
ZCacUkaf#f0,uhd1V/BRg-)%:%;c^]Ag[B?lVl.Th[2ZIk!^MMUOq`7tp`gbM:kAS>C5K@7^d
<n]Ae%O>tZ6YrAYAr%]ADB7BDs4FN`M,muY)aC*N%7@5cT"icO,JoO\A]AE6=rNKu8/J4D]ASZ^<
Fi29(ZDO"nQ8@f2V((clIk7ZL`4@D`jideIBuqW*:(CG-V;e`m5nEUDDlr?s8s-jfLpYMBsA
:L');A00?3nNIc&;'hYF8D&S[k6Ne#:)NJED[)83&XY:aNPX87WMj>J7g:'KT>brrLFA6rFU
&s<dBVa'O_1#l_Q<S)2(MPL#q,Z;UMF%dYp5TDo['G_2ME(lE\3]A<M**Def9]AmnR,o/\O/$F
EQH]A@8mp>(KEFa!e"lm<s/D6gd5eKUln'@br3,X<2k&Kp*J7kt513ICp&Yj(<7LYcEd<)Q^d
FaHtZ&"uU.dT-hINJ]A;[34Ma%*]A`N^p$,2`,JtmE*[U.2H83Ef]A!eZE%n_D/]ANt:%G?6i4Z3
enmJ-'(hRq!!`<r<%n56#[,@%kW9\;3=Ie,`.-XUheJEg9M2Wh`Mcs^s:P30"-K"5*A*Rknu
q*d+M.[&ai*-(<I8tE"4d$HF9!<snYPUf2cld:N=XVVU6Ar?-hc\8Iu9QG@bAFK0hCGQj?H3
=M5V)XmX\%o'b)YlMC[O_u_j#OnKUj'9c!c1_B4igJkOm'cns&G)LYpa'[GN<]A1[<DQ!$Ncg
cOqGcl5Fd_rm2AU_C,Fe]A:,0>#k8HrG"_(`E-D^dPrp]AGo7ZLFeW?L>g;AIB/TgBXb,o@q",
S`ql8H1[KSUiTDUEr7>>DiKunKYLX88DU+E$gX1$#GVkdCg+T?Q3QCU1c\B`U0-$&u,$g@.E
/E\9[*`ZH0;A216^Sc:/*0BdVN!Z`!aIl9hYiU?1C!XIP`Cq71YM^=OQ1a%g#fqQ/3tG";[o
g,Cg@Y`3g2M=8\+ginV)<4\EtN3lQl5#%>:!B-(s1+A?<ji]AQF"&Tm&-*!\L]A><.+.inrh*Q
+LrNa_s[-a@mi$2h+!TQC3Y04#I4#;%,(D\[V@na&&rr2-W;Z@,mNH^dm<@!-S;<fsQb1pC*
l<=Y.)Vj[)>-#UtsN:W%Hn=jN+Hn#qkUgRYADQZNMo0mCcIj?_8\J)1Z>C5PmK9$.[T1T5/J
_8[<H<l:M3JiE?m;Xj&4SZ`kPXqqmF-dI!Gn*2jmt-an)+feSi4$\0amC%koD1+6Bc)A3X#a
_f:G"88HW(@0eIY+A7:YtP=H#BYNJY\#0`?)=Am>b`X>>"(l:M1;>n>!,>7Ik)ApaH)H4Ws]A
#h\L37TQ9Q!9S25BM9aUr5r6P)50GgKMl[j/!7.SbM@_"Q>/!$$T:@^:jAEEE3[;7:b":K/P
2c+ac=uVP0gS`+BkH)9t$<t"ZAPK2]AncN(bIK4OFU/l%cY@a0Od>U7F[P@5F)an/;i<chQ`5
=c&uCUWjO5:G[Cf/o5jMVnSjkLHRNmR+*V8:c8:ZM=+IrR!\#VtBgY!f^Q0LFBhj3+>/!3OX
T7V-r&QuQdZICWUm(omY[r)-Mb,4f8AYLV\E*ZPH2%EBah.6?XA,>9;#81O;/m'rBRgMUKG4
f)+&4+.W@YnNpRXf&s#<S[pF%*AaGMejOQ#9634%nTVAo^XhRuKH\'>Z*HY)+W3cMY9gF?([
>hR$Tcj;(ZW.f,1(h0WYj2QsZF?Sk;"chIrdod;3?[g<n=%@GF#oUi3H-Amei6tmLRRHf`Kb
/-S&ei[;Z+%Na[W_=U":%mrWPEHR2Vp+X-Xbuo?tRJGIe?/&S?iB%'qN7M>Qc*=n+Cm?.ICD
5qm@Um<1c;DqH,FiPp',-%aKrJ)DaqXfR1fqDqB@\1,<\0dV1ZYU3]A_q0%+.2ZERfWcWIhn,
9=OV<1)r+Ta[=ABKN%V;pB/2J8B>#i:!IgoB=SKo('E>]AShO1%lNRW;l$t*MKi5C`^Zq"fGt
HVB(?ba5*=&S('\I-Yb(n7$Vff(]A.6X<iPZZNg4#=kpE(<h]A0o#KraJ\Z98b@56m-`t=Glt.
3?j+RnQdJ%(4B`=p['u)=D5DoL4&`VdO5bKKDg/bW,+Y,#uBueU.b@i_K*1+I=QE\Db(AV>\
T/=L;'=r.P+K/:6X^BOI%3PTgFmZi8Mgi2U0XDnMnab]Ab-/<XJTJ:(=(YW*=*G*B=YDBo_2.
K3andsKlYqB8nD2b7/VI)9X.]A"pcdX]A3CjSa8a*j88/hX$%O`>1MZ/%$j7]AT6\:3hELn/n)L
D-Fu:6*G;BdNHOD)V7bRSN#eMb9gM@I8q:-0pu>6dAp0AZ_!5ViO'8II#jtQW9Iko<88=E94
qu,UHXXa@F[V>QXV03gA4U]Apjj\1j^m,B.LRERb4ur[n'tJ#ll?-nU9Sh9kK.s0AJlf<(H_/
etDhF+4[AZTP!jfe>O.Cl;cA3V.-rfYhb1<a,g=C"P>[@F7SN^\GZsc!#ji58[`N?gi(^D70
/mbiV?7O>Cf3h7u5ALa2$Oq`dqG:E2?u+,hB#RU^Fq/#kC8n80F(PV'Qdo]Alt\do2OY6i9$*
H/qHP;VNsL*p9(3`m'jZMn\QLP2@2eb;nMq?#B"qPL5Q1F>bK=baHPMI^sR(Y$X<N"s8*SH\
/3%Fmr'nnE<t^1BSFj')e8+"(_#%5JUrTn0^M=i7\'h*KN$isFK,?g?`8mn"E#_CKk&$N0`6
++&[pT`K\t&`7B6/A%9^,m1K5bVs/Wr4&cp3e1c"Ruq(pg?EuT>lhSl%t&*WNiDV]AVlqfcD2
&_Td?1L*%-mOuPZ!Olu3`SGkOjh:EW4f.0nrQfo_]A'`04Y-c\Pame=ZS!fOs;l?d^Vq4UAae
KgI+`Ksad!/8+B]A#DFab0%XN2jY"eqe+o7l&>X6k>GI9:",eO@IdkS`i2)9.a+BK3l':q71#
mWjXTbKgUP[=ZM"bW]AF,%5OjMIT_Q!="<8qXBg[h1=UYV/#9,/LC66+P=e'XR2l4(+5f/8<)
h>YKqO&,sC'=Fa6A:M7N$9U5T$1>XAdLKZ=`OqiH31F#ZZu+Yi4(`#Rap-qS@K,jg!I$Y^F:
MJ<0'1g;kC7fX8mn]AEAssZJC=Ek`#EOAU;)Mno(d7"6I*1'E$V>DX6`R2_-FBX;5"]A\#>iX^
C)D<:11]AjpWbMN.H"MG!8B6W9M0SV9"h2"48EJDPHd@WEfQnCn)S6"3M;srLY&thnC,Qp2j2
RigdtqbgGQM'fNMLpR:GPsT2AqO@EC9!$TkG?+J:8SnR[#qOQ]A.f69*^,N++tCa,Nul9,)3g
9(;-je)RiC\&t6cLObTF@0$VbWq%W(*5&BG)na7:I3jtGI/GU(,T>,qM([p;[\HfWbq#MAV8
%<j9#sI.`Q)du"DPnG6Qe`6sQa)X(p07p[neh>qa$Bk(F).XD1oSqn6jKNZWCR82B8\*.Sh^
;1ci)"?B9G!n22WB2j=oem-]Adfed3Cc$nd>+5]Ate-(4FZ@OOqi&s:h1A)\GlU(+$?AWo)b!@
^HpkkI'mn:23TkHmbN.5H_F]A6a_C`jpcj8R`qSAT7^.@V!S]AamfGV2Hi;qN2fIk%ZXIN0PYV
Ra3FdB6flT?6`o,R2RH7nTLnp-;+^aNDA5a6b#'dV/8/P:C0K4u!Jj!H#3"QbaZPV9hn7F7I
paINE8FSu.*<.rjE5`SGE<%HQddf$$&]ANNcoIf,:#lZSpH93!Ij5mm7>%@N";=5V*o?,(A$T
lmr@`:pZ.5l09(qbl"]A^s/QYScdc^L*Hp"p7B4/B.o@1Rr1W[e:&*i(%:qX#_?BnllDE'C5j
N\pL3C6Vhmtc_V/#EZ#%N8Qp548VG13Ld3GP$d*Er+1(n0s3H>dnL^%^l_`RU.1Pls'?-3LV
WJ$f`NZb`Gg)&#'oL@<L5LSSQLhkKHc/X8;^$M'0HI*Z#7I-`c(=1k^h%c<^rN\/LmW4<e>G
+b/fq6a!NPT[tf<5NMI_!Mm*rn4e3G(2ARV[7@^uL@*h5257\#=n>;*daP6XWs2'-GDB&\rZ
:_:onN]AElkHJdB^in@:q9Um)-N9(?:7QLMeI'&HLjn@H+gSeh&D@.V2TQI]ANAs)2.]AkoVN;9
u!;Ck/LlOVnO[<'AjKkr."YIS,C%?`)?UG`q0PVN(n:/[^@95mqm`,q]AdiR:]AuNn7q(3#85(
;[2W[mhZ*f=RG<Qec/k9F-eL4mCZ.O-(.s@L&L.hV+,C+t6(!W$t#1"bRAEE(1nG-!$Ak\hP
T%sXH:Tn3jgM7f*oUI$5pA/m'MM>PfaVZt&cqoNo;m^C*')d,O8+.L_k]A%O;Fe=Zp^$)`a=S
1l:%&6<dPPQ=,#N[I5e+n'76@a!-)"muY-6r%j[MT5:#(?=<%@fJ!JIL[$3_n_r!#Rua^WEf
AEU5gI%p^?eG[-L4="cR'`cEV(PW2MR(d<2Qkcup!PKY5g$[3RZ6;GZB<bhGQARdd>0*\b[r
^%"V%IW%E`.L..U/At*^Q7e/M289:_N-0)cTdI4^;B4SCJgj!6^00&QTWU!G^07Z(cGE!@9l
[nXB]A.T[O0@GqiZKh``$m^iX(tV'/PW27%'KDgPGucKM#?h,<*s4$YG_)kO`:+[l_'*TiO$+
R,/9cnM_V7GXte*EcY7JTF+2h`hO`cATNI6ZQ$)_c=jUub6GNB.%M`%P.b7@ca!;Dh%K"C3H
^m;p`]AWF,3QplH\2PsQKqVS:@(mJI[2c2O'TWePF$9HNmjoipJVmh3-F3f:*./Fa(5=EF#\X
81qf6>)(*K14,;cANEn2o#cCF&+p[.n0K'tbDP=uH[@0#m/6s*[$$$gg#+A9PpQ/H]AQ&JQs.
[OjBJ3"0g]A?`dpNoMCDh6$9NFRM=5I="XXa*'hs[I\?B3.&u-4?0_m*F?M&-;9m&XJUs6+Q9
'#_9l0)c=<Td>tV@I?Ok1C2*akN`,i91!rW&`)3bWhnq^,\7WlSGKNoGAAYM*/F-VZe3GlK;
cT-)QOg<#1\P-cIm^nQeT9#,PAmiQ]Aa]AQ=G=(-"e7:@Qs[fLm3CD)HRa3G_&UkIdkNI0STo9
e:Zm+ZXb$g+T.eVqkdXl8SK*E=UJ_:XlCBfsBAb6[[BK,.1.d[D5:h)gZidp&EM.ST$\:[6;
=Yd@MPrOr;E:AIHu*Wp5m0KbWQ,b_u#<pRiIKekAn>Ch-\<A*0^me70$ANP$!h\4c*-k2),=
09s\gW4YJk;b%Sa.XSZX(j.o6abu;QS&1O7h8tHm@2Fu1%CAnkL%"\DtnTZ+@,0B=fs2FR7?
b'b&1eKSMOchS3rqs0uKXoL^>(Q2Ckj=/"!]A/NnI<_=.7d*?PTk6eKhsVaK$15]AG;.R]AQ!#9
,6Xu0hh%@<Q'qL=_e5ChCnFIo30,;>:XYa[)g1-SrCr?ncQ`A0BcN&GJ9.XWi;&R9gpm8'D-
IF8n)8,:HGii+4F$)BmVsSPf^NI0^XJ&92h?qtT\3jT/*8+nG4QR144_I<[agHNjbra8IRpG
-J6%\\Xcs>[q@[amH;!Q'B,:WY'#@*k5lb"B#bQptI3?Q'cGcE+bnj/Kp^47]A-=FIU]Ac4*eO
BiuJ4'ToBVs(Z)hn'/@48F;E*;fG6X:P46VH<X1dmd<SPb6tio_4(W]AXo=A2?pU/!k&An58J
sp7iPpka[QDL;-7d$#"pU.`4B^rq!DZ<m(M6f4&-8/@(QRmM]Ad*(?tKPmU0`E=[]AC7*<E_18
MJ\A=s7-F%We/[8[GgLM$"\]AK4NLs--n0?#%(RML(^Vp^#nE6]A%UO+U[2@n)(Sub!d8:?a6E
8F-5#2R(-MqJ(s13CnM#a1En9,<U,;9"YE\4:cHEPBRojnfe"jUXg_njFuZY-AWTY@`eV!g(
gXOp6NC&!#e;dK*db"Rt/$e=@lU#,bPYj(N"8,#4\Eu6$.:\PJZ;5\^Z!q,:i3aaQXF-bFH/
WYP\c+p@@^X9pr/E<Uk5;mESPnn>K>j&WEZcM`c,2PN,'+)Q+-u^GiLu'@^a01tUTi[;KB\\
^D%-u=@`X;#K1LdmOD.GnB#D4u*q:bX*UaF,o(WMd33>Y$fbpJ/^8k,j6)8Ndn8<kRE7RqUq
c8X82$VNp:$#CrV&+&XB`0)GFfg>&f5+9E55`McuW)A134!^>TBe<dIT`f2^ETH%H7qdsCRN
tYhg/Z:?Y!kZtU6K(`@*\M0gVr[RS4tJ9Bf$>IN*]A)k(+SS:lW<PA@b<fRI[/j-j1o0GSY+q
Oq?ccO:hQ9["/V4RPm^A-@;@c3*%!6X(bJm?rnb%n0(Q_mTF[)`20uDD-;@;cg1m3-]Aha+<H
,ns0PAQF?,]A/t\':!dmrk!IS\\Z^2Kn.G3%WAg;Z=NRtZGd,1FPmQ^a>(W73IA.l0q[<CO.s
Kq8V>5B5n.?u9*[o.rf=OhdO+W<al!j^iV*[jl_.9K("BD:5gG_BO'DJ)R'qt99+C,bn:Vd3
X]AotAI[qg+NL\44na$X:enYVBT?;6d]A?pJCNMVP^($CO^s!CNDMOn*DTj2=.r1Ftlg8.#sP#
>k.$KErUC)!l]APW`$U@WaDRnp4HN-F9.F3kLVDFNI*g=M8a]AJ9J/(1c^Ke6qd'i[AU>'^jC;
7DBD&Q8qs8\c(g`X>2[PgHcVm8bK/[@#WlA*pdFGBLYOCEYNi&f3tBN)G/:*h;oN?fZ3ZM.s
1Vu>[PY,<>1!K>0BHG[o+^6D[5W6V;ORhf"N^7H^K4tidQF2q`aNk9NV<W[%(Sa;?5Pk:)@#
o+M0@,jTklu8Z#>-iG1a;oX-&WU&Z;+$)eZ6EiXL;PcY8ddB!o?A@ZKV10el`*haX4oFj`nS
m5]Am_@KWo9Fes1jf!M'2QC`!H"tc^SP$7kF^h2_&-)E6sA:6rHadkEK,o#h&PfMr(0;O;I+J
lM*&dd>+bP<;9^lO#*!7!A#TAA`S&5+3496Lc[-at4GE!aH%QXIHU=UNK4q;Y=,?X[d&IW31
NUNZ%3M\f-RnA#nC2HCt]Aog:GRqr)n'#l9$*0@C:;B1HA%cS69L/K+_77A0[Q@1nG;&Kd#>8
#%blN`jDZD4IYb"W,%\lr!u;?W2;fHZ-:1NYDARA\LprH'0EukS.Sk:k_9!m.IR`:.rhse%!
uupFQb[mkWtS<2P@IM>jX`+3t9l6c(lt/1naDf#P*HJcfc7ql5P[Bb5PT4s&hLI:X!):]A^!e
rn-f-:,0KYGmp4BLlQ?VDpKo?^nQ\ZIhY^O9?RlcAPg`[0V=uo&)"AN0R8!"WO@@O:4E<JDR
`iM>#STm%n&9>2_Rge@i/%<1UN:mXT2(2.9]A[hH);J6Im8YpA^in?J572MnrH))^rCIQ'I-a
-W1a2MG:C%GpUQ4nT-OC.lIct;FH+1n:<(c'n&/Gk8^@c13=./A5_3,?NGAm+dh1Xl<.^H,B
lY&*_S`K2Z&)m5!\LNk$<3/pn&G`U/'+$<Vm%k5!k2s3?HB\RHe1\[jH%_4R@e+:,P>E0!f(
rqcJI%'XY:5bY@TIM#j>eBaMQc=GrIkA8s:W,>s*Sm/GF7g.c8pj73?6M,'sf_UnX"leDEmK
79!rZXoktRC]A#c>7EKN=m?oqW0nE5>\qd\uG1AK*#.bjI1#4r0MsO,HCeabh,8EL6ZN8de*'
e#%/$_blL<_%uW)'$a#9G1kdCIi'\Q@$0N]A$%*[YR-EH<$iI/raI_*?G$s.MSij\]ABCpG@__
Z0AT%S&hYIF]At9>hlV10uQ>:TN]AJ1?,"?$K%nG5`QS;'?.-PFdZMpO$pZDj$'9?MJ--65so!
fK]AA#U:c;*(bopKaQ0d0dBpYEd?J?-r8IQ)l*mdXqE1T12.dR_qL9;pK?#1(GAr]A7_XV-iV:
ennDS4*C=eD6V[e-r3$5rj="/Cc.TtCfLC=h%>TV[INA73*,<W=^)FcS1_"fBJ>(O/'$MgTJ
S%d=De[8M%9UiDXmY=O!T`@VYY)FO1[V&C.,IDn.Xj(PD0iohI*;t1ZTQQhY@E<hbPFOK'l;
]A$s2!P+NP1<C*;A?9?]A.8Du9jV[S*d8\bA(p"/A4NYV/b/E]A-dHj66rSs9n/P4ucGtiU+#.3
ZC]A`^I\97+tXE0SidhKn$?+j]A'R`':o]A?gV!%Ju#*ELR^GM6W(+hd5?>bJTKs>O_NU6b%=4*
fW_q?9QWQ:[:c57OgJgUP;Q3C2034kph<(?RsG'hR?S`WCEo&T&68CV</%Jp[\,-Zu+?Kep0
DuqKZBO#Ll&G-9^kbEO+40%;[Lc:D[aFVh**ip)#WjAKUmX=1d!M6G(Z:Mt9DY=@jdipV>rQ
r^a-OO3aYSOPoGW6n]AW-H2&W'SNtHE&"gt*-b9K@SQddS]A9L0j&uG)bJF1/`5.G0[+L@Thfb
3^49ukrHmK@:-3*3a<i_09$rGLM$?MXVPq/$3gIsET"r'DrO7hc0o+^j'VJ:K3c_iHXi"9Q&
H7jB_bGVj$'YDrc&6OdEJ(3DVVJ)4juh5C,ngO)A=NT91_Ml8>6WU)7<ln@kQA)mL-n%1teF
RGYFQp,X9k0I=e=jn0Y#MHYo=-CV/#'4F[Vs!8`p+":U_oGBnRCNY4k,uM4furUR7@5fX4rn
\N'HRWi0dGXX&2RoL`.7jIY[m8W&o&&VPER5TPg;WO%@^3na?N0)T>IhKPGH37(pOk%DO`k"
4au;"Ntt0mW'BdFPU"\,WPrU=Od'b>Vi8e\aI%DRO=KoTb8,#Y%a1B]A`5f*5oBC5q*=FTts(
mW33CbnA-)>3O,.VL@DT&UoMfJLb;e\jkP*..C6Y1jQ*$GO6ZD4[#cUabKZlAW"/YOn%5i26
%bacBUB@#@rbWT[-BJi@@S:Q[GOlb&Z)9<kmS[83pOs&5eM^j2^%]AE*<EK5]AeEcWd$GfX^fb
up!o3P4>*'sQqN2Dm,`4;le=EF$7u(NX1?Q^Sp)8+IMCT"^dYs.=;rpbc7-.\VP(@9H2p!7G
P6.3>W:;q#>(^R-#$@?[LY>^=Z3I:k6Tg1lbM\o@)7b!n3*#r)"^]A]AYKFT7s?t<m6qhm[Y`"
9Dc!d5:a]A=asP]AZRA+b7Y,6KSRN?/qdQ,XFU#t=(R;:p>kKj-]Ak4)'fT",i12Z@=<.HruRMi
ijn\g2cMT7i$)VSjsa81<r^l2/=CFZ<"$Hr><Uc:4R@,7L(qC&R']AcU3U;"4=^5&58Lr!k3)
3&RE<Qqi6K[?*X#\/=cGjQ7r5)qM-f#>-[-I$,*HCp+rtG?YE`H`i><ik]A)=(a%qE.cCMM#?
/(E3Tf07CZY.QndDAmc^LfR1?@IRgcZrX#i[61\:/8qe^tS.b-]A2100:or!JUJoMBu:^T\#D
uM3a[Ra<JDPKDTke]AD)mF)E_d!cE[8V=F#l+G_7k<m&d&@I`K-PpTkgQg(c?+n:7\mAhkblU
2a861WEK#lVnE^c=[p]ASlSfo]A71j0(kN45dNnZL"OKDY;p1E0Ojd8&<!KG!CYn-3rn9sK[c0
Icf3IMKXhnD"%+O#S_NYN)n5KDX:a0B./@2qIM!QX6(io7NG1-V3QnGZ-/1=K3H!X:)fS4fN
#m-n"CKm"X_D209e`Zd/-P;nH4/fE<cB#WJ8s#n]Af(fMkD0WXjl):(bWOOl-MA*Dj-pp&:E#
n;q43eQSU8fU!7;&g%1J7`i_2lI;Ws++!WJP@EsaL>c27+S&S\CRE5P.QrEAfG*Q7_9d#g_4
Dp!g-I4%k6TAnN"r8T=qoaR3\&">:Qm8#.=Z$!5']A1p6liQZf6PG=2GJl9).<KZ*Wa!Cn)(d
WZsR\^K=&I/QiKD4heb9!T.=36nun+;?9]AS7&/Yj#kZdfJUr<*A&+`00^*I=%#_<EnOGr$28
0(l>9j5R<@kd&L1M1=Z15C,[_:9siS_ZuaKaNn;+ZA1_[*oiAh,uGHD/2A\YW`4aXZ-X:FHN
8aJ5cei<bg:6dO0Oh"b,<a+f0<&m75I$^T'5Wm8P!;?g4S-1RdUq^)=s?@5.QVUa=#dU$k+i
O.F"ncQ3!Cj)VOADl:u:Qca>)K9V%V+Z&"eF5%Z(Lp[`;0;+t$n/-S@Wemi2P(*#l\\nbYc_
439u^_VHBBJnl^'&Fq`7`KHhfd$!8l`@=L]A;oW_.:[YWHB8fJ%(F,\anP44.r3r@a"JB,=,+
'-Fm=_c_imqGe]AOg0`9k:TPCCZRJ%0hT4j?QE->nUKa&s#]AJ'&X]Aot8(*+ra,bCg^i_]A>%>b
e.G8aLUFF4C7OcB_J(>BLs&#l1ed>fcZ'mkp/IDN7_SkkTA#q]ArB\2&11uN4Uht<ehHgI#fN
EBm,0B<NV9j8,V%#fk."4!fhWKo0BeQi'!Xc2]Aq)*br8N9o(_0JflrU2=Sa+?E9HhX4YgN=b
!!#.oB5aar`b*2ljaf32*W,UMOQo'^Q)o#gE@cJ2'u+$,VlX!")+tWpJX_''oI1e<2g&!bB$
5Fg6G/fIJb-]AT=?Cu`uJ8oViBT+9@mo7cHDGjGDn9VcL[FL;)PFT9gro"?)OOKA<_X(N-r?K
N'*`Bc^Y=C_m)te>d-44#24Um"=WpaMka<N-"'gakD.(:g^UiT>6GAdna+AEAUKK?&cAEcl1
isR4aKH]Ak<<cgI7A#6ZV&$=g)]A-Ha^'E(p$uAIF4?51`@,<Eb_NAtfpkD'd/X]A6LffmOQCXT
,=RSB8Fb^.7AcYm6FSPIWk;nfSpii8k-2!WPme`B/6i53hi;QXXR[9,-T'd0cen%VmMfOVb$
k(:6KB.skB[m_ZfU99sk6Z$4HURK");2-&@@l2ElD!jdhsnIuWdb]A7PR9:(2C%B016/HQbs&
Ose?'-W>'hHgR5`QhI?@R&fNAZ5,S=fb/k)GqkCk1*04JaH_Uq&_pu-k++5RUV]Aqi]Ah`OTU*
)qSACN.,U2Wc\cU[EBjZE3=jEienVjG0b*3[a]AM'=gKAcp+D'PZg(rZ02^r<4WHV.L(^_E$E
st"Uk!=+Z20i0ZiOb[&'(bmeZegh30mkV_kq5.fQK=lH`sisM<eZ6CLtHf#.?W]A_4\#c:shW
H3bh]An]AeUU3igVFdZ`(uTCf`V`SC6^tUh.cMn!;W<q6]AD"4GsPjR$>+ae@A[5Kc#Qt!D<2K*
A15@UM..FN`n#mUHht;f<hg^;CYA3Z^Vs>8bUCg%%+(N,'DO3Iui+]A#=(:9I)_m\$cR".\ge
"RL&0^E+(a@^L2hFggGg/ZS(/'QFm]AM"CDWY-p@&5TlP[%)BQL]Ac.iI^0FUYm**("sTSh*oV
O(4]A<Q8EXaS#H[tBi!>0`MF?;1(FZ(m7-Ie)^;n"3?\5E##b(\eKOmkCaQ&7ZP3U%V&QH'Wt
)nK6W'ecY6%+e#F3f,)/7Ht`_,XCl4*eLIiLcTHCih!6_PBneM->*,?1K%YK\fJGjb,%8XPW
(n':<U`2ntj;T4W2%qY3bkGtV41Qk8pL$l"c-VMi8JQ^5B;nehbc3,_aOC3.R?b7O4@<4Dq(
1YWM<FrN<[YcPt2XFWB="!S&]AgH'bY8e8bFLIasGNSACpXjAJnu-WZo373:?3_[d<M1u"Ah,
PT8%U_nlMkudf"#ZL7\Z.`q:4*#kEDnle=*F!C8C9sSeHGL.Hrn*_tfV>76uJ:H-d%beWK7#
C,g'jl]AD.Okm3Aj]AbXnrA2X(h/<WhA2EAfafCM&jS+@[]Ak8Xib2dJL[F#XNl]ACZroSR^og>:
OZdhX@P,r/UoKR5:?YUQ-iE'9INR"`=gONJ-^Cpsdk.l#$?[hT-e<@DPL;)h_#;I?@LV)lXu
E8Fe'Go-F%lmYd.EhY;?]AmYr$c*dCZ$"]AsMBES8SE='SiPdLB98]AAb"8gGq2'*-$,;2XfX-?
c`HZUOBA>93FrZ<?#FLL8!LC;<Y<<J8J(!#4-2W62TqVki)@TI^D:.+0Uaq-gG.*WDLf&>FU
-p&kgOaA%NY1D7:Enc]AsO#oPb9@p3e\'aT?;6_7=M*Nh4o"ju@7k,8Jqp!'4>X'PY8>WSa`l
KO-(L;m]A[bn6!Y[MSY&TH0S5$/3jmtjnjXG_oUu@F#4S,jR[2f-&^HHk?(!\jb):aYSB/GV3
bk9!:H3'?;2]Aq5`i>3pp5&u:joIk_KBFW1n2o_6!p7QQi-gX'(49mm&9*RfaEA>]Au[]AtYV$@
LqG@uD(;50/R?H-kQ*9nW9TUs,nkbU<cJGg@10Rd4W\CXpJ0L"=^6(ra+<:Nj@FL8E,cm$Fm
C`H+KR*K3Keu(')s"kp9m:p1$bu0NdKSjg]A9i+H%(tDX$KHFVRphuVG/H:CSR\UXU`+T<+Tn
'D>bB\Xe?s*)LPBqRenRaB0j(H\j<@qgT$3(4F&e$$k,l<NY\AaW'J[u/?3rVRkI;._f(2bp
>OAesGu^6ZU<*70c@ile+k2Zbc>cgUX8;VEMQ@'MYj*=t=F<+F$en#23`?!QcCH0jC-8Uf;7
ZageX=Z0$:H6>?&!uE0L=g%R2o&gQe/%bVZm8eIeqI6/</f+2R?<:YrTis3T(+Gao$@7PIf@
XLNBKHXN>EReGj3d._I_-baNa9Ts!u=4DmpK@5HK;a`0NQ1HBkJMN79m#IOL_?t0X5hTW@5f
:AOij9&%oB4r;2p'sD]Af)VUj#XEDMZ*^H;HjU<L@U0&DC-G1l5gKW2i3SI\5'hJ4*?FT3I.>
q.#ERZqEQ>IHc?X`oN0b>UHar#K*QL=!V0RDq?[sL^#J+;SAN)/R&rc('X'jMcE"$)@TXH!X
h>`9rk8g8[[5T*(pGB\D"8*!%><Roi@%2P4MmM_W&HUXLo:Z;'OT]ALFYig%.gj-F?B);rS\M
Q@WaGX?._N`XYCt`94%o[uZ<o\p=N#VYj>(^lo483PbJiQke#K7?MKaQAi2*;\=1'1^1jYX3
e_jQCa4Q=4o8/W%eOn7-;7m1d5#WM(k<lBf/!&k=Y:3%bqT[[MY3R1&J#9DrKZ5K^/@<6\*J
+`0YjL$te[I?N6?F:h9=b,KL4+WI9(Xs;_Mih)79"Q>9T:N+XXctkqY0f8a>R8tuIfVIP&E2
h=<]AG0M?ua3Pl?f)'=r0"Gen8uIlo%?naBfS5Cash-frrl7C#f,FJ^k0(au33HE&Pf64^Stt
X)PJ1M<TAaR]APYN>!=/nX09PmdVY=6'FlAQ4XiQ%$<0?J`EH(`6uFqK<OWnZ_esZf-J1Tt+U
"iSLlL8E>-*6=:Q8_4_l;#UEI'aT@Z4>GdGh[[$M?N%c;cI#@!7K[N4dj10_j?6ctpR5fI_g
>U!m^uhM]A8.a8]AX)+p`.h!RW7%kdBYccHZP>S+48=H0'!oD;'9A(NS^H"._6:UsH#Z'Lrt'C
Sn#]AE']A%9+5L[)n#,Glcqt3_S'91AKjbp;f"X\#^'&inF@@58_LSVRH=8N.]A48"D&@_pj9;1
tT%fr0[UlA1dXB^qg$#,0\io0C\ptR5..6Rb%\UtEUgBJcT/c_MQLrD4oTW@I@PY)'tV7l@I
fF&f!]A^a.f")n,8n<b'J%<m#$nfUuql\Rtp4uc+%fbs.2XWak"<8J:(CBe0\<,'Qo?P/KWeA
Bkk&K&&@(0rjV5h@S"pi/eL*T?4i.hmX1LL\]AI:^fL]AJ8OWZ@Vc0b;pL&)`p#NdGVL2]A083i
Pj`'RtgCAQ`pVZm8K.u!8d'[H3NR'Nl>@DNrU19j6J7;X+)DH6+&>?Em5_ns<(8Q2p!a\=/6
kem(E\BD![MVdl6)5;.\/r_o&gSIU34iA`7@9%-F/^O<As;MU%2O_n$]AUG''nG#2'."Wl%]Ae
FTq?dWB[6cfEeaMI9M[J:mN(rmFLKCY(_9),8hOA+9Kc.!N6r*5j(h&oQZ(NoRlHl4'%NQnU
k;fAG-"NA`i<p-\Z#SnJ<U=EXR"S43[i9Z=(?g0:VdV+@Z"pTB]A#/"4F/)0deY\:qg*808&3
*f5Zu]Ad/#1bC7heL^5&TXKHHt86U8eP1"OPIA7)VEP`=<*/HAts@HbQYT_6u<2]A`nXFO'8N0
)%*VahplmM!rbki<,=t;jRp(dSQ;"52U<2A>44Xk"r>dI9B2`kI3D5+PVn$IA\%44R=hntp%
'W[j@4h]A,?OE*'*G\aZS,J75YeLnGg:fNdn(2^_7GhJIFaXbR+`[S;?X*ICFel`p/llJRIgK
;%8#ZEj_S9G>oOg0)b^Y(iqYP,`rm+d?H,o_B,6n/f1VWc<lPH0jG\db[;k]AADIfZ2@D.&Q]A
BIm8tKflMi7&1o2KZBj&+_<nmdX)3C[2T-LQU&3%jbo0oJrgPCR+nMWr^a!IO1,i*n<fTt?%
5)o%10l$i*aM#HfI@?Ir$b+N=?UbZ+dM&QIkcF]AQuc/)'+C@*NN]ADTMS=N'TGD"UX3e%6hFO
=)""bbU!rImkdiPWh028[c`V3qr%eBV#hT>'WfI_pCu^R6^nbK50^WC!At5iYV8UlL?DrVg=
!Fm9>!!_<4r.l.=/:2OeX@rF@:eo]AEDuiDCru`.&7@.kFj5(^VS`4:RR--KO>7TopuqPb'h0
E8Cs*AtZWcr@hS%a$1UH(nc1%Mda>eXX>7L$oeMZUB3JBUD%?u%:DIHCM1cjaqWP'UUpZ<"s
('CLu3n,3JJJ^"7\^s*G_d1uCe\JAk=bi%h`p6(2$p:CJr1lL7_LMjScVu$^A,;'+S&EtFcV
jh?^/rV1WjBJl%YMu61VRM58ZlmPg[orR`PIYc@J%XI.J46B=P3%PdV?P:!kgfCXdip,o-A$
<mr-kGROL>9[a#!s]AoT!T8,'JjF%l%pg!mDJ%;kq;o`i)f"OcSUVOS(V0^)?.p3rQZ)-Z#lT
9IK9UB.FlX9)hDHCjG?!a9k>mQ\<fq>#cZVg:#rXr)mGUJNL0m_-l50V\cg9ud+8'a^)gd%+
Yg9CJ^G:!Ra"e/@D,e+Y.b^^-JGT$'mHM(ah`f8T]Aq7f-u:VV=m,PCMZh_SGkFT_TM1's=%V
_"P`m_d\#]AIi$bO4Q!?Up30p:jl[G&)#eqk1OT:A?d!"/%&3c'JB_\Z-OaB=,p;mE69H5l',
e\SOODSoR07C6S\=Nt@fV'a0L!LAa8;ejGZc[*cg-n5K/s`eV+Q$'X'>tOkh'1;!]AF!a_<Q@
.0JBjcAi)-")(j$A8r(P+e\*Ge&#tQ(A&9p=<[76>g'!sI1dp(U;<YA1#46jI8#L3dke91e]A
ns/ifboPDHc$i=2O[b&`;'1l'fh298']A]A%P04<=oR&f<\f-4Y/p5%qHOEYXImumUR2/Vb$Kl
B^YjJVQV(f#aA*Ghoq$pG82%6>P2GMK$N^\S'Jb$><cHU/_VSq'$'%^mE6\QHFKtLcn@5uf2
%>b9cjUnOK!-uet).>L1"/:r=30^65/9D79RpCeN1b`,ZlV']AA3N9eb[#g589<M^1Q+W1s$Y
MFfeX^Ac@i.`Cd1npu]ABB]A7`@d[#G4e'<OED##Am`h;T+:8R1!gh`.K`>q]ApPLO3E9[Vc-^K
-2bDLB%_Eqo$KudRc#bf#aa"cG%$L-oKQSi+%<fE$@M**c"4mrm)>fUiLJf^-M^*dB0c?/eP
-RZ"KP".4EQ6uDFXdX:R9@Vg-RBimB/5*OgNl(US0^NhN3?AfXk;1D]A\^`]AV%u,`:5t7%Itb
4?25"[WV]A)qBqk`WOFB]A[^j()FV]A?`K-e6HqoS*DM:G9g\^&<n[5cs_AgB*%=[R7baRlIe6>
P<ttY_P$R%KD[Tmnoqn=2.4mf)MOR/Qb`;RT3LBi)A)7b"_>[:rlr",rpDn`"uLf3>^le1If
br9947Y>;4-0g3C^G1`qKERYh:%OeOg2RjocqO?\AXtCEdmh#ZCO2>O)lW%pb$_or3bF*R!D
-lcQ`h]AJAon<QG'h;0_S?CY\4'$.le5a8'%)Z+G@09Pn#:j#bi0TO'K1TMH"*)H[gS7Q!H?M
.,U1.gg.V7&'A6L1mhA#'"FRd<oF<>6!)K!S\\.kd`8`IC;Y?0/9oL`7P88#fi#oTbqj<=Pf
0:9I!r7F"CRZ7i%Y6JCU!\Z/J#*m(G:[O$7B4g&?^A;47ciMR!T4-N+CXWV-XQiNVVG)RXfi
B3D:1_m)hHaAj]A--AuA`7uX,"R;*a/8J/Dl.ENa>g"86&m\@#VQL;'p<U[oK%iXf)l.C/AIe
4!;LX4u8\]A[Ir08u2?C;X5OA/eodW8&1'QlLXO&"Bi?XULlUk^19#6F\.!;\CoT?HT@-Um9O
_=cE0FeYmP#6dC$^\s'N#%[C:.AD=C8<e8ppm'%H+2X:>;3gj]A]A<,skA:'C\<*^>+2UIS,<g
!a"lRQUuq:UBXS-(R'2;#7IRqbja/>u7P\^/g?Y&14<6>BEXiZT<1U"0D^CkJl,DDb<BJ3E+
JpR:$_0)pL;.1abtb.c]A#pE[6k<kH!#A]A<Qj^'NXeqEf:R68XR%hDW(@8*ciAAot#;`XE'j?
C81)D6I?"tV#SW_<UGZ4KuKi)IVt`,Z`k:@c&Qb<8MNf-#b]AkX(+R\oX<c2`dRP2aFb[%?)l
jZ3.q_8rBg'Hsb>c_b(!TS8Cbn[l/<9>M@:Hh\T)B:toZplpm0g/Fd=n=7[P5Mq*EX!W[P%Y
YCTr8!/*![\n_XDV^B<>BG(*eMQK=$?Zkn&ENhR]AD^\d@aci6)Bp6Ul:j_qm%?O*t</RYoA(
WgC+`7W:jpiLg*mS9mDKM`o6*F/b=r@?kZ*DcRa`:[HEEM7:rXq#-&-^4Ddj,+^Fh>.d?p?Y
-2rW>\OGnao"Y=7Vl@;%A@*&1sg,Bd;o1n>><``#5:1H,qDMk\R3AKs$8'oU`;Z"UGJ+e&BM
NE3e^UYXKTFP7Xn*ks5Feo,c."5&>L0Rt`=be_roSuIJkkG#3SHjd#;d/dmP/4$lC)?Etb/N
flr/"=t5;ub$V[i+j7%`>JJ]AK(tA<=)clp"nM;Gl-V:1,Es1%KOXMk/-'C9LB4geDa2s%$?^
90(2_.b_"p%)58UQQC=RZVoZYn%27>`YnB8?O8Snq8'$IlckOAooi%ptd5\!*H?AU/[7bnC-
Kg4j&IYmVd(-/C9"inrO_`m,@MWfl_,``q-"a11MaaF\p`-UqF-)iZJ^fp#q.un"Vc?kn;S^
G_H@5^nY:"&B"Z^%^q=T]A*/EGmQ8S/tb>b@=ET'(?/]Ats?b>j0Jar4UeU>0?"ZUaP=sh%CZ=
-'W52DUQ;tngg0J[DmgobE.mWj/Cd3oe\!C@%.n@E%s/04l6pd3/-m)<=K\XQB@alpOfZ-^Q
5RhNAuDPhf#Z#H?fH9&jE28hu$V>Aph<$(sF6\ZVk?UUa5'$@UT<eFpaV]A0p=D]A\VgOH(R*X
De<F56Nq>1)r\Tho'5ksl6@_Zk?-*Z>Lt3b#U.\c14dXE7-AAWR>6'`#8XQ1t?d@p-Vc6Lti
?E\i7P(S>ST;<co)-Q&l$.19'lMlQLc;LNjF0Y)Dn\X?W:2jpo7H.=-?hgJbAllYWqg$9Q(7
2W,mKm%Y1+lPg#>Lc(EOM-c_Yp3F,H0.;H'lsdf_2NAC;\=_eY#oUt"t;7S=K(7Q&XIb"2ND
7_b%ir<oiXNR<+_/A;<rJ%&5HGD=lK`Uj+g:&QS3s,.HJ?`rp7TO[lYJ,]Afts'#J&#cRb@HR
o$.^]A"/8TDQA,Cf7deHN_!tCa*7K]A,5a)f#+Bl'p1Va-9_pCM[+n"i8'!fGe\\A?>lBgKH3]A
_E+TXMn1sM0$28$3P*99L:Vs*3#8'!>&sYtBUYN4Q<1+JP3\r!XHO`1kM+/KeZj(:a,ALLo`
,'1A=CQ$)2b0UqYL.$u,n(fN[<:4>Kq>n#d<eZB!8Cl_[c%FpNB\>98]AM`WqPabE595d'-f_
H-A7tg`IO(L1m7.1`OT@udV0I/"=ij!\%:9>up9.Sq8(VCY!FgejBYc`g*]AX<)qMiJ4nT-F'
mP4jTBB!3/P(D8imWZmIZOTVED8q`m5@MC@26+@/_A1_sqelC8*'JZM$g4_2P!p>Oo9M#c5_
#uRRT3R2l,%k2[h:hdMohYqWP`[k9Q"+IO17Ybi9+AL_hN+8ALhY'I>en62e2!W2>$j:nE6B
A@XnhF*+ULnhmXZB_RZ/?Geq^HIeW:p(W.k[b+b>ZVPiP9eB(@*?CNWqk"66Qj[)jW?.h6kN
f[IS6CP:K=L)Tl/ml2(lt`#G=Zs[njf8Z;QH3j"(TaNE!u<QFJGF9<LmeBPGC9=&V='LN5\'
R%9,H$$bl%ihB<7HNnSDn71M%Ymm`:FUIj-/J,3ma>_;U%06p&2#eClX`d/0Q3gIK7<rl?P4
R^!Q&*kcWn+UIt?\K-1\/7%.&XBW"7042@N^r.]A,p=7=hr3UG_<it#5EFWV.(f.$T=cNZ-mO
ZVIr&NZ]A`[_UdHg/rnqQ0?l[<sL]A^J.SL2a<9AW@[kZm&W;hqu>Dt&$W"8m;;e$rL`!GIQ,A
CYnoehM?jQHN?Ze>m(N."@U_!IM8nCHls18<HgeXWmi<o.JeX=W_p&"[[J$!hNCf'f\&986f
#'JbbacAm3W%Y$hJ9gnXqR0^DSCqt:7j9`ZY%L\rg6=lPbhKoH5@Vm-R]A-1(<Rrs&f^EDj2Z
Tr8g<HDglcj#`?pK]Aa1'N!cuh4<hR>jND,B6?$m\b!Itq`:BB..rRj(#7'+OAnUneedIe9//
if"d9%7:>KKDth`^m?8n@bfUMfY23`P*3sC=RLaQHNCX&,t_+NQt2VT0nX'24DWNWQo&deAk
cK)m9;.)H.nJdQnk)5JJiPlF(>o.qrU8W&&&^"&:TYCSQR`a8[+Nt:Gah/0h,,"e<4Bl?o,J
3f^cAKf<Kp7?kU5a'_se_Goa6g-%L=E@!ejnq$20S"D$lt2)+hPL7%k,GdGoqf)sk_J^3]Abg
K+CL(]A3FR"Dm",#?`]AV=cj#GB&N74>'Ta@FZ^[B$Sc!I6K40SJB6ifXZaIpF26g/5iQ("h6t
cF@8'H_%^D%YN9=;=^fJ!QD3Y")%d_1=_.>q]A]AZ,`CCJlR\c)?80"DU-ll6)H<HuV+iQA)$X
MI=q>'o\F]AC98o<&[6C#[ap/oZo/-Idk-+f5eo:&-\:%/=r=j.+!V:$@ESRg9\n55M\#O%M>
Jgn/E[)?9i#J2:=C[^H/6dpNjcr/Ae(,I#I[[\MFSQ>NZ:)UCnV;#h1J*kZ%=KQ%0`M!jT$8
bG"-*=M)<+fgn9Shhc6fr!Dg1D<:LA/JQ:$R53UI2YhYm=#>Lr=#SHT.02Lj8cTo"*o1&C&i
M*n)H2OD@*D$ktR5Dk_[IfYT/7e+7W@6rr#OcC:#afL&U<&LO)c3YW"?]Ar,;9?Km=uZJ?#2(
7r=[4Q9ZMd0^5\mlr$Pa$[:\QPZfm#bof1Hi4<si[%@a\ffp2CBQ+1T<"HJm2'kGkIYCi@a5
g$6lMa/J4i/'#AOklr"B\U1f&h$m_`>4buunRV3l&4E-*.d_@3a2WrniTBE`Z/__'!6/EP@G
PgG<N$"\EY56T^)hjt.`n@,AFWZp3Yud3;rQmQ%_L.(d(RUF!aCJ,JQhp#UkC!,2+N[\jj3:
1h/VYo=g_=COjO4>ki:p;r"3&3+jQ^n8`-;g1Uh)j=4?)3UCQs8>rl#9<-2&UW9b*'^D[P8G
4[o^gGkRYb3.#TL'm&@l*X!jE:tn`->EmnEfpT:?R4fB_DdCKrLWGnoN=%Kg!^K"jaBO!R>k
_Robg>bK+""2mEY*sE,i#]Af<RRa*m<`6]AsTsQd/2XtTBP!Deu1N6,c]As'm`4LI)5uW4T3E>*
2XZ`LcAE.6i3?\H:P]A;B5hBL/3<sH`r2<p#+u!99>SW2;nVt!4BYG#$$s,%TD;DKn`--"!b@
gt&C<<"]AghTm`6b0Loo[sg#A6d6IYH8@8E:]Ap)7`SG[m[nP[Eps]AI\(0\kW%L8>@aliT)i4"
1<he8lrp4d<*gNLOb0GE\YfjF*!NLLsS9^QQq<aM6i-!5-Y60macPs7[bP2".!T7ksgFKIq5
mqrU_!:q[H,,aC3aafun)[Kpq-Cf/lLO3j^monrn>/:_?eY\[/XH<=J,^igYC@+faXg.!eTb
STle#[/G\@kqNt4\'QThq8[lX5jnjMd>$$6F?-!#2WJF#!aktb^0G_Y"47$W9f"*6L43/Ma@
s*/Dd>l05knXKBZRLfP@a^O\/;?pOW_GPR_!<<3@Z*f+-[1Thi%,oAIfRa[K.L<.)>5o:qG,
n!WIU/$8>L/90keB-.(n3_omL$bfI0=KoLq+N9`mh[Y0^e=YNTV\J;:\<LhuRjl#r$DR44hm
@W^V2cVC[lXX-KlK:KrQa#*\o#+G65%W<t'>jGP/\<p84Z'O!E\9fHT=gqJ2tB)G+\H'F9WO
LDAG?57#lfT)X/CAKc?:Q9<3OM`bon2E*no]AbnR#h:u#p85ZVR&Y'L)FPh6ZYL,6pkcCQ8kO
iH_64IgEb*iT(U6crdC+0.38.D#h:eE2nE3sOiWYf>KXm%IW7Z`%Y#&1ViV3K9)))0<O[Bq!
E"*GbA:*WGU9)'%Vqi+7'jaMo4Gng%>kIGJ9#R:DfE]A:)KGR[kgn?tg94^d8EX]AGsoiQm?9,
;Rp@,46;5\7XrfY/.F_0$%=63JFd>QR:nf=H3Lq"ll_h8(S+68=m?mgPMp`&2,c,.KZ</)-5
M!U/-V$rW70A^KSQ:gS2&T6@@6U/VGC"P%61%L6T++K8p..b,&$Q)AeQ0k)=6IVb(Y]A2)V[7
9%DmLp;=Z(*/t]A!ba:$/bUa[`+\>Yq*>3q(-VB^W/Z,^S^G.B#QtC>KQgFmS&geVh)gZ)#k7
@[ShqCHG1?mQJoTr6/X8>29G;C*ISEBl@`4@2YUN^\"K&jpK+SaGOKOGO..:%A:3O@U0C:(P
.4Hu?cKG/<cVUEF=d1CB!@sIRQ".OWonfX>44(NZ[L7\2Q"E!q,g)i%aK#ZnNg4!fm4KU9]AW
BB$iTJMA7S$npfTl#^A*EsrengAt/c*og3"\k'G(?3'3$sTR6.]A@R^/TM_p6k_hqpkkR.T$u
#MqZ:K6-2@mV]AsG11aE,[I;9M#2\qH1gCij(&5<%&#6FgHC%BUN-]A_UM/#$L,>[_R2-.dJqh
^5:!V&lX;MP,#oJbm"l?2J!frk0./h\hhb0M>->N)]ADap2aWbbFg[FFhKnF=pfjg]A+=X/CrQ
&;?uLAQ4o$27[,:RM"8AkRR=DE`R$TZ#'!UJ5$XVXNHdf[<f=c'Lq7C!C<Nl>VYGU?p.Bju!
r@diI!O#icrI]A[GS>iBcfQm>7;UUVg]AOr;RNbaUnrG,hgO<)&X/;R;7!D(nM&Z43-!.e9Rp2
acmN&cUE##C1<4.Z]A#`8#I9\@`&i"2\LFFa]ALE'F``1Tl?PtZaq"tnG5$[e`HuJ@ge%kJkuS
&%7S@D&Cao"MC(t`d-rE4Zs"K-%P)=ibGnD2>SD]Aqlhk=DXm[T$%,+o)"8:6\Y[)B*MIPlEN
`^X?!q*^W7&hsO=mX>N)r3.^)Wl=0=\bJA:GtgUIC(io8("SNU?>oY/?M6UCu98$4Om3!\qD
:uNoKkmB<nEJqt)m`#Bp_dZUXV6A+tusfX(GdG4"(?4aZn_gt@T@8:9-<1]A^&WauKW6ij_E6
805[05O=Vce"L;(GS9>RG:SLS348e)ZWB_)TL&M"ah+M1eGuGJWaO%Po3g'uD:tX(-tgklpW
X$"R_Z`d#W&B[<H:Pc_p1q3@,otYW)0q:\-T_!259dI@,q(cC,me;'Bu@.O1La4b3k6WdGM-
2)f_fohWRm@7ce2:1[*`,rCBoJXc$8u_V)Q>8qcq9mb`@bD*N\:]A@`&+#Wd)F#!6T=ODXo8@
.-,BfQmfb[i`D^Mq;P/m`qp;Zt_W=cDBjDf;f^qJHeKVp&m@!A;O-Ko?reT;/TKW&?\deidS
Obr^PSi;VkR!7RZO=9M3BKjR@'o*%K<T6u%@C8RlVQ_#C)8N-kn=)rU(^7rlmb*iGZNrLPk@
qkADuL6sc4Xa!BB\o8Vcp)_8=8b34<C/Fqb@FWAt84pr<ID`#tQOn-5$!TE:nr=,N=eZq9$H
6@7#DNbZ/QOW<m6`UXp."E$G)3rn+NAlDJ,l.b12EVM:J2;mA]A'2u&)pI!E(-0?X]AVl5P5fE
)M50eM;a8eGs$&I*L);pqTr]A%!U`q62K-j(e@]A-PMboQnX-depWh<c.Yk\%BmV@>`,md3M`p
@KZd]ACu<':=Asj^0ch?fap&3'5?S0"^6X/s(nFq`2Zp.PUPfDR]A'iC_>(Msm&'BeB@d`s?F:
S5?L:S#BJ?^<[c0<f?<h:jR?Wej"8bhjHRb^W&Qb+ZihcUulh=i9fHkJe_q/E%4N]AUYj#KON
RjDBt19m$::mSu?Zt(`fp@;=7:c&)%Ia:DhO8mLM/*2mu9r2)%[*p*@A,d1sqPkhO1i^K>LV
Mf;:]A:Sd$[dc<?/$S&+O0&@go%bE)-Q4GW`YQ#&nnMkUk(PJR#\!ZGJ\6**EWoXQ'`1.^udB
s'^dbEi;$XiWm1ta@&p[X(r;+t&^%nt49S@rfN-Nj94!ANYr4ZA'S^L@#i%>bXF=)Bfjbu64
,cEW(rNi7`OL=JnAC)9E?Tc=&oe_eL1eTQc$1ZHfmMcY%+n7Xe-;>I#C1ga`jNFsWZ$ab'E]A
-jMJG8M9%hpc,p#S`cVh\BKmfl1Fo"^A,4j#O9,UeLF$-C]AKp,4Rgr_BCSeTbp!jhk&Hp__H
-AiV@Lhdg!Li6?i[Sls6nDRrf=jpFbF0%^0,++b=3>aUo^@.EWQ3"IRD):rdks_rM+>g(t.G
/3;&k"_<ABKsP[L#<\9'tSEXZIM:T\Zj7O@>s&M_jP[]AB4ON!C[Aq7S'YA(cH=Caue3@q(a,
arJJ!3'aM1ki+'#FjbrrlDAQ\ji"I4kX!&?`)1<DX4'o4oXe'",hW-5%(OtTH4_IX>[4Y&co
Yl#Qp52]AopW`UrCLqdM1[Nc-QhQU`5@is9T&SMDXQ*H"8j:Y\CeH>spZE@1kFcdF$IhkLo1=
8-<;XM(O+XdP5I%,@3--QQ?=V<_8i1N:lW=O#3t=^7;mTY^Or1fQ+c7+^7lkk1B\'[TSj#^^
;.2X9Cf01h5(Z$T8kk6Q.KuFl-E/Xl(cc-0Yj!od_74mO^;XCSdDH[jm.--0FDOTM'.]A3P<"
g<:80S&4K[M/]A@/8fQEm3,g`t0b67U$*TX7d8%iJ<TPZK06MT,=1q9\s!hGMVQ?iX6QF1QEe
K9aRn:_QS9,m+cVYjBiALYc-;,s#R`Wkuq^e=J[\REVD0Q:MsFHO-k7tROFD_V+jN@dV@i"N
<$m\c:3US9an,gU1qM/WY@^FNN[?Y5;$9`K32eU`)>L_IDOP([>U*b!7fpULaEBn1hi>0Vb^
6Q=7FO$bP,\]AV<m<QJLuqFkeQn0``r;EWUt4pJOYI&BOpO8J^aS_@Bo]A"QsT"V_otpU(ZRaV
#c!sWnRI>t8D:`^\^:q$HCBLlbsO"6#,5'8C_Gua>^Bs?S45>gp%ZNT3B[eZ1Vut3<[c+?)i
BNkf"C.#^m?6Y5mY=CKqJp\[Y@FAd$um:J#J&:56R\9l>X*VJEs^'"C2>d52-^'JQi10Ed&N
4fhr&bG.,9)aSn0nGUo@'D^$2.X=/m@XgX1P&=A4jTe:_KCeXOqeD:UW3B7H53$%hK'fIUZ.
Q:Z[[sE;s+9Mpi1k91*ZKkIJ+_Q+t+Y:-_3%MIR3>fkp-9R@8Pe@UQ=QGE%ror<a1n8E8M%S
:Xc>@3)E+bhSlON6TePMu:79hrr?WMd'$KPB-0^@2&O-7IEd'.sX)Uu)FN,@[^mBQjt`jQ1W
1me7ZLPG;=Dh8[4$S2qg+s@>B]A@6BF&a7qd*837h6f1lO)qRJ]AKN1$ZO2%GU6oS3_W?L]AQ-O
rA62E)4D2J.l[,V$ne1hgB`IpUF-Z`8lXhsD\T@^^''fZBMfN7+CeVSLd:)eGQAjRZNfh.V?
$MuYDt[t0(PNrZjCG^`U>\<f2@G3edSAD*s\(7"NSo%\mOL<_)a$)5O2'*<]A/c&0H8'k&VB3
Hk?=3cm7eJ)Z=0)idQL@1$Z*;/eGWkP`C6K;pBDH"Tl9Q?09Idh-"Gm(##iqD)oE0<Z?>2'l
K#rch<R>cSV-hG,=CCr5fn/)]AD(8AJ72k>!P"3aR\#(gfg.=uuW,W8WYB=#*T7Y-)$@",kbI
iPqkWG>UH#1EDMu!G<cpF"X1/UsaB^("U?OZ#&AO\SeQUGpk5tVJ'go1L_R`qe!dJ)roS5MZ
Olgo]A'=X6\'%PRf,##3OJ6)S\N1MHoZTD/0lUI^pQH`/=CX#Rkf5</ia(qiZ+Qk9.d&-a^=S
ak)BUS<SX,l$;RlSWiT]A0&\f4]A+5K^_YV-$[FTXIZkb0=XRX.)gmo(TO&[6PS=@%/L`FLJaV
;k+ElZ:PO,;bgFT^s4^>/'BDrE9WRmK'?GT<G@2r-Xq&bs4l+[<F:\:>Og'S6g7s.l&[\krV
u)VqN2ZC@sfYqSE3JS.FMtN;#NQjPn/K7>XoEgSQ35/6N$:NWtIc0W(br`L_qYlu]Am*#$,!b
%JuiA;1*IKPaWR!3s%>W#.Et+f]AEC5b5>*2bR[#o"5DgC6nAco@&',E0fDf$Dp?'eT[n:/&3
=Y67CVqUkeAhd"4m]Abkka$.H?1U<4S'"W5$NquX?/s-`Zim!.Nl`X1aXi.7NSe5XH=J+DJ!;
*[-C%`d%jVWGX-Ti*KRW\q\*K2';dJWX(=+)DoKEEcXfAcenU[6[5fe:PrKK`qR+5"a_NSYd
eB+eBr-&LSN1gmDY?B7(@4WtTOPHdfXNh;5jeF0V_W%1+SOi3j,Jt0mg@u,@%*pqpntc_01o
GK`Q7!oOHlZLpNY%e[Wo-G8@mG4_6D77UsEo^=2tSO]AC\LAn&kIH#Rfi?0$W]A_SO2Ktj'Yk8
&0"]AC;V!s6nSV6P2Cc4k&t:*M4Er1cSu/2bV&"#mWf<.YAeHM&>O%7:gkmD$l3l>Z!LPfE%D
EVV5ZV/LW<$r40OekL4t&cl8-V0##)uQsdo(]A>T2-b0X+nuOcJWQd%W+\PWH8tl#BiOP9U]Au
@(O'Vh%,fS^XV)3>Y1c^2,FOZ4F%uH;OH%[I_hQE*YsR!f]AB;+p%_`aoY?B>gQcB[]A]Ajs@+W
^d_*MW?s)rPL7&O,kR2E3b,4@M*(Ve6\\*H:.Ce.THbpalBj@<FYgc'k33fmSY"ecU;LEH)e
ZN'g?m2DUbo0FO#MM.J!&K.(Rs*@%Yp+du<MAnOmj[p@iHa\C`?A@2[!kX.rXVRMK;CIeBB[
o2l_7_Q"pFnC=c)-s=&0(=)qOqW.lT!dG6:pX1t$4X=lJ[:14`#PG#[6g=+^\^o17jNjC2JW
&^[;;6"41@bLl?at^_KLAH6\9O!EB3Tn'a4@$(+Pfo%OGf@".'Wb0q%H11C8JRC5[;^b-Ai%
pi".0D]A5+Y/&-s30XW^5S#`UnK\)?\6999>rGAl8gCZE_$r+G0KH(Y&>*bs6*>ueM:f(Zjo\
*LFDF4^`g1%cNSYSmF#mtKmikN=#fA0sYpqIhGbe'T$r<`Lk\/BDG_FIjC`>O%#8aO]A-#e).
oO]A,",)nopoKJS-Jk08D6AIKOhIAgTJ"<,u"==UUVmPu<P[7hAkfCY08"!"_0K%5n",(me=p
*]A6N@,=j'/O\662TQrW$!o%e2R%$^&"`^UV6S`m=G50;__6g)Pc$05CcsAe\&jmUCcoCn!JH
>8s'0:qVO">lk1jI0`Rp#q2jSkY\PU%mnRQ("tMn,pE'AQS,472NSHS>c`RJd\@)_\SgK[+V
ABOi^*:LF!f.4^)kC"X?;3DHS<]AotI/DPHDHne/,&e[]Af30ZfG?;^2]AP#49m+EU7cgZOF%uN
3j[5<.TV*2WnO7mII4e`e;B\UP4p`\sS+0XFfQQ6^%U.==Uu0Y2`dE(Hc6['Hhm6UPIhV+fD
>rI`dBX!P0ZrC5^=AT4ZqLKm[Jk[j.$=(=7<8`BV'8Z&0<e^-h-V8RLo9B>gXZaFGL"YCtHP
2NKZJIDV:!09D!G'I]A'BX>MjH,9YU[-/'=3-1*[+[lDCN]A^bA.Dj0\J,8)M[O&2[p8E$c*^e
grq=,nSP>O@#V/XmW6+h:aJV!bkcFgKK$>*-t1;tC@;)[$Eu5E*Gg^+^dm+N8=IWa&N,)cdu
'Iq\k(CFtU</H\KX`^4A.5-(5qN)obs_1G5!ieU#_LF)*fc#<mo$<cROje-.W/s>e?^Gu6k+
ff@40[CpkcTb!S1c'U=QM#B1NmWKLj%[sgk?If.h5CRmbb^9"Xe9suUoBB6TPqjBBcn(@gP"
%:7TdBXGRZ>ADK_BJ#\<rE4H1R)UXtU&VZ9FDQ^L9\lELK*EY'dBCeW0S&EmEu[CtHCjl(qo
Y.q_5B>=aTklVqJ$H-R\>+EOpi,7VRj#^X%gH3dMj"R/BcdV'c'6fd<EaCV1#EpVNIm&Y#Q,
Cb^&'/++a\D5AYBgl>k8'Oo!*sDR\(qtiQ`7t\4_,=D?C^abkh43kB,rS#i5[WjSl./%!/)8
MH'O`!]AU<eSr(VEs%IZDlE/up6H-k"[A83M?=Pk:77Z)Kh")D#,&?QS'W=`E!/%MJ)a1Ytn-
Ir&e/JkDtOri>6J&Z`7/kJ^-7t6AG?KQH,k?d63ddBT;QnM#E"l;QIjjj[cESeQoOYP(82^E
`>ma02_hB(P=2L!Bo09".T5TU"Ti%H0m\DW_%3-ko!6Is9/W?4;p)QgpGpM>CO(K$).hh+nU
jP&tkS[0$H"24aoR8#t5>cFc3A>hX=QF&V<;]A';s['^pEa9un06m]A^72g[cWa)i;GMLV/N6W
G0M/r8JS'Yb:g_jaN>j=;nAQon(cO5<Si`W3Ag_Z;f'Z5m@UgKCLinW.l._%eu1<k0G4a]A.7
Wnq[i[_lb)mN^\RH1dg*\.);F(X<"LI"cc80)"j6/l1"EEZKC%5T!EMfs!R""1L%h+j`r/R9
`R1O/UG-;QWG?H<dcbU-Pl;9*\r@<ETPEA-E/b_A"H++M>ANWST/&1.R1q8!q=I,il-*cED5
6CLbfW6J(6<&ZEDD=5rp:>r#0.[?j:J\D&bV\(#$d+0DJjh<j.P`G7d\2o!D>HDNFP/5bFlf
GF"24EihnV6k6Co-lG1_7hF8]A%>rhNST!@QA='l%-Ll]Al&/j_YM>CfjUPpL]AI,>U!Y+u,IVp
3rJ(V&%Z+GK&:qT+"L2__=(LHeW.7Ch[W=J,QSO->Q[qjb\B,'u!BSs8G`5('3d@ClhMX6J9
=5+=l3=QWkKW>=7.(LS&VWfSCCnb]A#Ad<\(E#eMkpcSpm2'P1&LK4eF5BP8CO\>FS%)Fg0Ho
+e+36;U$^$h19hhq)UtbAd_L\IKk&J.rm:&?Sl!_i>$W):l/?)%g3=Tm*"]ADgjIrU_L%%1&P
GFW`r2Ij$6O.AQdq+=97D@MC4?0"EDbnm[pF*iL9h]AH"Q@?'KZZl#Rp_X\a\BfFSh9oi&AHf
r.V3oaq1>OoJ0rGT^)Fkbho9e-)i*#[X8uZMN"G1U]A+$2>PJ$:]A"cB&B_M8M18k3:GSMP-@a
RK*P@0D8_(7,Lc)<bSWA$P/QTmki?Qur\*#341k)b.]A\WP26nE"G4U)mP2Uc??C^Ei(tl$'(
mCDd\CY:'hIi/kG6W.!m,_:Q%T72R]A2c`Ne0feJA!;5W-cLuP5*r2kgJct\.,8Gn@6'MS]Ao$
1J<O4q@pFGhYHtJ*fVM]ADMt"p*T7fB.u_c6GOAX^!!tr8Y>_An4(@/qlW2h>2k&8kj(+fDrs
m5[:mW]A!XjetSBV7R*3N+Rjl-MV@KN]Aan<C^Vm;/_GXJesdpD1-NNplpD709D3-nAl+?c&?g
=/IB):8oEdLf:8jDJ48oe.^'=ii52<@OdXH9PU6]A1)//tY7,!RI4<98HI?6ZhJ_,hA!aA1-[
0WGG+G)c/]AJ?Tl#36JY*]ATV?^!"#F@C[ZAP<'pftJX8%hor=QjR2&n,)eS<!%>>"A?J`\8\H
gd.Ckn:!`&>rakR^FiY!H'V*_<d?Nm/n.1r2h:qqA=-K30EQ0EhH>Pm-$L?Mql_aYpSRg0tK
$`Q6!TNN._hk<lV&4@g2$al@8PJSE#.`F=H5((Hj]AU'i%&9Zt(qt:P3te!9lhU-d&F@,el0K
k:5I%?Y<t`h"I9%.apiFCE3(AP^4*OpGZcn9T\ioZk#(i(tF6fjgG>9J9E5h$:(2%.14B>_-
PUu!Vr=%Xe)+^J3P"1e7LRuN<U[q#A@IK@$Fd]A1pLV]AnLS3,>biHe:J0))rtJMV=pS%@-E+Q
hqV\]A!sfW[8^A?;2ZEW,r1l/5bn)Oc0pE#QWSl!`\TLcSlJW[:^9(%AP15cE@P&gaOpt7i^o
J1s*/E1,jRI;@"@NlE`c.k]A@pP\W`R\lc-4KX9Mk;\a"Z@0_gG#E1GIFD=M3Z%k4As6Nc8V3
H*k*001L>?/D38/LaD>^Q=G^'iVurSdVd%K$`cKV/$lknAO\T-&F9&=\_K@r#<YMS=j'tl2L
*6BHA/.ED@2@)147>5.UL[e"W:)Ueqn*fa#P6<9W`=SN:>+i\H)WTM@WAhG1Qu@`(k`@EGk2
oHCA#^N8"^h1Pmu*OaoCGJIj%L!S;H\H)c^P#_!S=[H;W7<'\a2Qk'mV8mCNV;sQF89MY,n`
*&fp[7dL>GI97IuPp#nbX=cfs]A7^PQk8P,SED8O/aK)S#6(f4+j%j;:4ib"INnGqA^V!m_>>
_#?Kch#QurrYi>=tH#fjV_-M'uB$rj4YZ'G#ZR&2"JV*=8E,@'Ka@u=9i]Aj(?kI/26bWo2a2
4W5kf<9On3aWc>U:a".4+[YJW^Err%Q<?[_!G\BYP8]A[*cKY/`^>[=[1Sit`8-U.-A?2"&p.
"Kqi!"Z5rj2dVZq$#)huRBE>/)chuH>SM>5pF<Tn,W41qA]A'MANpm<Brihn!W"lI'I\L1+m;
e:Mrj'g/pe['^;+J*0bYrC>P^(Vdp%S8T)V>ArudPR;\"If,.m&Z9`*Qe8[lZG3?2`eOnAWF
P*jk'%BR($&cX)OQk0FZG/Z0oDh'S6V:No;%ED`MLj'U3XDPpD<aD6td;\d!sq!kqs4U6ZQ[
gF\0,f*DClBL_'l]Ab.bdq2r7qY/GuX,PSG^GM>lcKg9[Mt2f!4F4TV7p3UI4j)"7=OhSr<N1
CAeYm4+J@O=sMkJ[Rmq?P@NuDbZt.T=Z_UB<Y/@YiMM`?6Vb+$[8iE_Kc$V=pdrMH#MTrjc4
j3^@kH1Ffgq5^T_*Ba`rJE$O8=[p$A?F5(?_n<j4b$gWW?cGl0j]Apuad^*n(>i^UHcD$IBiM
^3^sg^hSS#,M*NaAi%$WOHVf)bA+(,("9$o@0U+ZckqdqGpaCYOQF0nac;U?3"^57``;;mUQ
X]A^4EsGu0Ofru`hak*gS\S"524nT9"oi(oX*:Ue#K/p_OVZoj%#gfU;J&/3beo8-9_8tV6o,
WD7Mr*#)aY$#"D6$UYiUO\qNq0,#LbgF3E0CFSt3$8n(DmVG1/RRa&Q&$HCVtCnO-2Db^*;h
G[BV,$$%&1&^/&J/@tamRGV&)<;\Fgj9dnVb`Epl=Q[0ojLr*3gLj&=SLqa#M`KqSqQ#Le]A(
MOS.KNe.?EXdqEub#RtL&Ln<+Y^%X$e!#]A')fXlm<2L?i(C=RBcIZQ1JIk5M'L<Q+KcX8dfR
BDo=QraX.\^@UiNAub3qY2a%bX[2tU7NEZ8!A4(I%'N!VQ;s9lF2t"`MQ7lEP2K+t&iG_^b!
<NM"(YseI6Tk*0oPUL$c0(9f8L1R)-m9n!**=M6AG[H,XANs`4L'uf[ICMesel6l^QVMBn->
r^,mI7s%OACL<%<86e6dZ!_uKAY%(lb=:+jB<JU%4s)1pcP7^9ss%3PhaaK46akUs"6Q#sTs
+pLo5[rjkUgYL%HGk[9R2;R)R6Z-a4DuICSYWrXF:UVT6".+7rAa,H^qK_%N(BAGc-e_^.X!
M290]A6PcofufVa4DZNXTo4Q`c:,T+;%[Y.GRn64<b>g;%dc=0l5YhKl!V3dUgBqBR1$e$_:F
7on@5+4nL7+ZC]AH[8!07EJYIp!L=g6HD-D)Bj-Ogq[@dV(Y!)<o\1;9]AQi35"sk)Sj#*1QnV
PDhjFE]Ak*O\5c5QS.kSQ*rt2p,pqZ)&RECj/OBrVN^u#dL"to:9FM&hd6"nnu;Y<$D,B>;ZE
4k=!1:F&/eOg%6bqE/$Yk:p9:W1tS'Ac(@5u4sEFD"EEX9Vc.XD/gM4YB$RUHXCln5/S:@&R
\:KeH!>*USGoHr=L(JTd<(W@)07k6Ka):C8a/%.M"RJS)h.Ik]A[t`G!RQf8YI!HKVRKH`2&F
4jp'62]A]Am>^#B&5BpL+-tW?Mhg-UElQX<0@q_EYC!kRJ)MN0]AAK3R2#,m4+/L"naitsr.Hf(
KJZS&._OmJ1PWb"8NYoTUI2(W*8\16X<Q',_25EHk&G:ieS.+4f+,'8>'Aun!R#t:?,b*4m<
=#S!&Sgk\]A;&g&iF@7P.#5X?<b*LRi*]AUic`0(b%82k@He9g#[pL$k?e$,n"U/lPHC./0siQ
gk+gIb0FO9+q]A>Q]AOc"hS]A75-T:\K_K[q[lFJPVB#*pEC"c%f;?Ipb),s!VL#MtQFD:=_VoN
64GV[1mTaS/*1i^P`H"'^8EACpl'/+Gtb$6[bW-rO[(,o!T-sT\;9CksNsh-*2U++lCM"(UV
?u^gB&6`MNY_QBSg1G`o,fb,MKf5+JR[dASknf-A$,bb^3qIH.4^fVTNAXd7_6H#U+AooH^A
D4^l>D%nH:h@KPR\_n[TN[!m'%)jp8Q!>E,6"i^t#f%=+]A7nj^4qH7l]AF-EiIsH`FKu/!Mqd
Fo3oUpdAINk_HWG>+jmD]Aj[r8U/J;mKqu)Q'SV!ahC*cUH]A``%1t]A!glM(ku2E7oEfEq.gO1
bFkGj,pHC2G2;5=mM^ZURR!l4K)mh8R/gO#sT@81^5M`%+]A5bb'A=/IhlAau&SWQ03;c/.\\
QYT2N#r8c-@HR-]A"Zcud@mV5@#eYZ'pZaBs!ogd`GXFl*)bH4Frs*%W=nkcMuQ1/LA`WZJ\i
f*iF\"oad%W,kRY:mo'C,mRl5Yg/a1=UnY]AM06^oBj&3&8Uh1p7;((2Xm,^T(Ek8e%=4eO#&
UecWqO,i>rSMR/IMZXoZTZP1=NNi?9Id*:;+m+\6&lu7:n>#CK%p\Y[0]AG[*K.3E:Xq9.D\0
8AuV/RXkCuRPf\%#e4,QA\@j&?C1]AK$2ErJs4o\h?84W8enO=`+/YGYNUt[siZ)Iq7i<oaQ9
p]Ar)N)R`;^Cl=#^.8'^dOg>E"#IO#6N<'\=dQ0WY\mN]Acso/6/_D6hi9U4VLo,HZ/NTq0ZoC
Sl>Q_Bt43Ym"<(C,><6?O^+L@:3]AkY!(bn"rWoC+,h52fRqRNF;WiJ[s-Ud70^`!+q#bP5j#
QN_\^Q,I==^oFW?pf7a@$jA?8bm*I!ufg>noY,INMBZgBPi?&XYaSp2N0F@:Tc"sX_"nJGV#
;r4'<H-ajX#5\6'rTf\]AcVW.eKb;2mqME\ji@!TTAqRqRZ>/ZU<,&RsU-58(gH+Ns_+87=ZY
)9MS&\6Wd8?d(c*&*fd^5m/RoFmBS.Ep7I)4/7hY=4Dq96>p.P)L1pCS@@qn05V),#>Prdop
<a*8H?a'g5rW!"C+B.MgPM["bI;WZZQ#gGT>'ZnBgns>[/j($QPa>g[W=a@M_U)s2mnD!sp*
ie:b\s0BsYFmo"n-M'pUNJ=i"TOoA$TRD,!YDEjk79'k%-9W/8jVslf).l>Vq&t+)q_a7p);
i,dbH7DYP'X\G<j2:8g/.93J#b/?mdq$X2+P+9#.tsg\iJYfLtsCZkX4(26r\Ll04bqc2'Y(
*&"F<B4_@XD^>u<@Z!jA;`=NS0E2.12)*sYN(F5T@rBR%`<3NI@S7G+_I)Ac!V8iHU+ucjKS
8;49#=9<F'LGa`*qb]AI3;%,"'H,V#QmY`:YR2f$L:t'OhNk54(A>A=%1X0Hk@+a0I3%g_9pj
%")R?&-<Shebh6H)b4_)+!l7NW?]A$D-:gTo\cQij-``=+-?3cs5#t="KiV-0mPB@\9S)`gd^
nk;#P'ijZJUo"[2A"l'lGJ/ka`Nb)bLK^9fV6`--_YkU4>21%2ArR0^Q[31l1)Pj,p)0JYHH
":'m_m+#1"=3U+KojaS?@r&7Yk1+.Dc7-7XL;Uuf;DNV7UHKgq+iaFo@!piEu:]A0>0nY_Lid
:R:bR:6>`.2)XnG&::<;g_7[LD?XkJgS2V)b6Kb;@.[$X!/#]A8GJH3K6655?\*%$^7rhB&U&
2$7OF"H%8?HMDh@.5#W\A0&Z3G,@-[M4+CGG?aT]AhoRLX7@n*j;bH3>-n*\L^*%KKJ>H<MCs
87m?dU9V(Vcnd#!lBA3lAF"ZH5LD;nbMA:CNhi4C5ONjLDJj@c+q=QKBk?FG]ADm_YmN0!kma
h'CGpcMuK&:(:?*Y'2_mL3)AD98ERLPti:"8%C-l4UU82aS_0G\0EG)k]AS$>!GG6f#K@KNVm
ZqAho9^A!['1?:O_j@9j('_tsc=K\rn[AD."@Ama`D*)9-:hJq''poukcH1:0Y0Q.$,Sqg5l
O?@CCnBRL@`cQU$^-DTLkKH*+/GkVo]A$UqH0s1PjL[bqdA@38lMuTbg'ki(9\\d@kZ*4;:%^
%kgc/l,*Zj1'<r5e>')6h9-MW&j=fB=LMkr.1`ZheGQ-^nBo[0/uXn,V.ZW=;FC^E!X=mX,#
cDYi\7B58Ks1t!B:;kRl"IIJa*]Aj3pb,-0n#iC5n?Hl;`j;,.2W9(3ok,XD&H$,Ue4Use)5>
MnZ0F5OG0SP]A@G`gu9$7YoZVZfrJRjoI-/[eMdMAgP=h0PHrc-MkM/WaGLqlhbUJ`t>,RHSb
(meWK9&7OqOfmcu?&HL[TNle#$8Iaajf:D9,<$BP[)2m0Cu^(NXt\1:.:#k.AOi:Q+s4fQ$2
:Q@BJ<#09<E_TmddEN[5c(UJ]Agf;Ren(iGb9X2$T#kHLQ5#s@g`ne]AARlb:>L4R,:_$)P;jn
1m;)bGlRc3b/or^Of)HlrMTpcjD2^@IlrG+r>=Aa2=+;I^*aKWefUf9I6t9uJ"SM)NG)r&Mr
!PV!O>45@/%/2$>F[6A0$!%s0IBCcauS2#l=e/H]Ar%;+6c)!MBm$J1kt5]AKm1rP:>2fQ33M_
kmn%D\YSn>tl,9;!+\<QG>8>U9GX\6c)tG+;&U*5e3bdm0=k"W^=.V=]AetG2RN+A21A3.ME,
$#[I$]A<d=(i$^=Fk#o6dgr/JE%LSP:+^eildWFod'gFR)&acg"\)(GDTYZp")>EU!4Ag6W>F
#"+XA`:/H(@U"r%*t9&MZI2,f4%Au/.%B;WmSlN-qQ&W5"r\K'cU@c`EBM:@;Z(n;;C(_V9:
NYR.gWf<ReX2mGGs(io9G4X]Af`8[D!!(?E`IH2UqXFqQoEI<A!1i*#o$J5/56ZGbf4uo@od7
!Uh*SU7'n$+,\^Fu/]AU94).ZAu^T3F]AdVJUBCqT&t6o+f8g\WC(JGo"dCT0L'P@Z\^DMF3&b
/:F\=cG0Zlg:+Eh)%Fg1+R4ZhXkBK2TpLJnBP=%-*W6:48Y;/jcA??&oq_;ntZ<3]AW4d_Ip`
4P(.*%Hd;&#QQKgN?'h.o-7KRsQPo&IM0(83T[m(1?3TY>Nn./U\jkh=WG$r,d9I`4UCn9IG
qG_5SI_k<`C7f&PE8\jiB<Rj\#0IQj'6"1>AD4\fR53^9LiSZ_hP9]A;Tu=>cAT"@c>TcbD<p
q*\TPST,b"kcuaE5T*BGtVF"Yq:4ZC=K467pG<aS]A=tXr[1EATirA]A-gaC0X'oqe#qnV[pYb
t\_Gdic%/YP;iCbSZl9'!L.`g<I_;7;hl-PGdp6S8jHGIKG>?S??*+Kk0Hb@K=PW*=6W:510
I2]A`'c^*VZ_XAHKtE*eN&!ODKNf'G/?md>>HD*<I\bG&Y[Z?i-laONF^romD43o2c/Q&?:[H
E!.U:[,Tus_cddXTq)bop0F168s2e]A[D@PUs,,fu4('Uj"8i+?]AQ(<%7A7:Oc(AF4;kKH\/D
&pisfA47X*pBBteOt!+3'6*o?9%./!p-ka66^%Kpg[W/+<.F=<LG1%P0s?p8;MtlH@Z(%mfp
t$Jj7<\EdH<Lq;!KFMQ(=qtYneJeR5W\=Tl5<!>NfH&Lj5d$4[+]AOX>pqTd(p4\>Q]A+qaF19
WMqqM\hu$.FP0dm[CJ,f3FGl:,7u4R;[7,kun2kVNr>jh0osCT#]A4<&\N0O^Wr+q(@gl)"B2
XQ#!KsoWRDp((GXWLZ`?Q@X$M;p!1(^2qGlf:CfPK3.X4n:6UTO1$7<;J-WbIpS5`[7ju>_!
KTFA#G4Zr%LV7'ntV[.M$GZt!'6FiU_agBrse*/-Ln"eP\!qJ$oP_f.@jEX1D>8(2566SAP(
b'J_'%YB4m=aAul[rs$NVT?/7qG_BCPX!9>5PuqtM+(/QXBK%$]AUk8OnC5Uh5*rjH.))c_iD
&k4>Ff=UpLTJjeZHWHRUrR[2GB!o+Yh2)lC"dRaPsfS<?/DHVC+[6DL<*8BLDtK'DTC!+u1h
Ki6%)hd@TU?6V-0V@G\ZjDj%N/:NsR,o//\_\&ZP[R60R`@E4imO:12Tr7*]A2"RMPL#o^]AN&
RNU2[n"j+onGluK30s$T5Hm"\-M)eT[[hG"^3PL]AO"i'7Ic[A._uM#4D]A-QPJ$N\CL$sC:*M
#J<R2P3]AHV0_p$Ob:mKKu=*=X9TALQ.$M6BNi!qnY1UCB.X%umo/ZuY0<dR#hfL^Q9!&6jka
V7fMDk9S^kaisRQQQ]AX;;f*U9'gM_A)-I3_kDFu*UZ!UF4h0iV[TV4NGgkd.3+uq,*P14J>I
"?G?OhVl2Q9D1`1MumXODF(a8$p>`lIFJ\'AW_Ml&"Pk3tF01Y9[V1qEfjbDc3Hp_0"[`\8F
ZA+5%Gk>_H7K-H[0?!:4.a?lQ'^<T0H_]ANS#`Ur`==h)("M2s(L9T,(P+MmL]A\'Qiu*l!tVT
q?Q23nf(C2a'EF??0c*?CI&Oo<s2_ia'6q=`n$W^$jc5[Mbe+<fG-Q's`$&cB^nGHG?rPdo.
OZAH-f%[gkaOmM'[pW=oAXRq7X[]A5J1tHn_[aHXqX@?]Al`%]A-LU>n9I8-4V\P3#;RO^Vh]AAA
#^\rFXXgj1!,ric*b,cTYh4cO>^1W;`1G"R/JU:_]AU!8nJj0gAL@]AnB1j+gC\o/*+0&aQrbb
4%PF6@sRn6IrsXlQAtrO1/r9j8hf]AH-,]ACtRf40^cN1Vd5:tn^P!]AY35bqg4V<\gKa2b>qTT
c#;%0IgtBAu'^tP12EdYF8^3r/Z.%q6ia%eJ3I*d^T"J%"-/r$,6"8,Pau'bN\_r8^F5l$XE
:+`l\0I.Do5Fm85S5U.hY^^Ga8'd)=1ao2G_')ojE0pPC#erg[X0majL3k-IsqHJI4-';[iM
<?<V8F5[[s.DLK>GW:rAH+NQ*)h@"X]A=8q)P2lL:XY'M*l/PHu#g>s)o?(]AB4V4Lm'r5[MO9
LRT??LV*/[hU`FuP4TQFGH&0&a99K2c;]Ai+.EVRBEM,hp'-?U0ij-N3RnPt.l^-/g=k,q3p$
13`N=N;`Hp+H>`X3"d'+\`)&r\c8G>^ttSs.-lSY?h>n!g`]A*9Nd,ZQ$<i)u[TH=[WJGHeCE
@qZfYuT1G&+h;pIsDSqEIEGR@@`MW'`?]A[^FhCp\XhjB"Dj#LctKsa)s/78h98hTV\`1fUR7
t)^@QtLqa%GQut1N/(O$0Z;bGm#0rp%/_!X-c>5"(&#K0Wj*oq[Yf87RFggpk'Og5]At'JWAQ
&-Kk]AfR?5.kqpfU']A`]AU(Ss5GaJqMci&=c'`SXlLi>MX]AkY9r^[_LmfFOU<P>5>e!Y2%,:=(
7,gDNX6iTiSa,c7`7'4%,btlJ956A"q`l6([2RZLVudhJQ]AEb%S#S7O3*H!AAjEph+"6W;2n
R<'p%\G:SRledXlC/(ZTUMBV4H$_Ht9+6#HSC,5?C3Cj]Ak^:&4C]Ac]AM&(j*!&sLVXU5ChH2$
8ocS9YO!.+_DqL2QO\0qIa8",f0QJ-C:WmJOjK&6:Zi)0>_6Os7j#'s^,6VgKfhHlFOCCm)`
*HJ+oMdKuY"YI!pr=WU/GSB:VbpSZa\WeA"HH'$HL-:=cN<"+bf%a-7:S(t+\X9]A!Hjf.Ck(
lb5P0>c6d<&Fhp->qr?.@u#n3^l$\>3FEInJ@cZuLk,ICsjp%8&X^Ou/a`BL$,KZEIBq64p_
!VoAL9lN&h%H4&/$$rB+;<K2aU/Z1?H3OrA5ip:9-Zl49qF,K6bK0jlSFW&U`Y@d6=u(^Mr)
:!4S7+#"J_r8+#0,@'6!S\O5:a/eZ74gern>CCa?(4sZc4bW3iobHoGJO&Y-tk4qE)cVH+;#
qn0SpO0uiADWUV1c$?K&2F=pDP8kb0A4OV#5G,e\]A)TCqTL-\i_-ci'@'X-n$1sPaUGt->+%
^&%PAk#X:G"98ALr()uZpi8fnb+J4js5>_eqB&g<`<.TAN$F9R00!7c=e?+0FcA*KPXn7;Ss
%S.jT:e=f-_Abn;SC<Lh9nlA3![)'0\od2jlV.jpe+G8!L`5qrVKM("]AV)O>."`tL1=^73.T
F0;FXF,5X*=g.6T1L.@!iOb3AT?A0r39)A?:2FhbPE0[_Ao0C.?OdUWH!UE/FN"l5&!"8J*s
fk9.Y[Bm=Ek`@[B-Ljl?UV_-l;*dI-r`82PQ%CCVL@N7qg.XI+<ArL'[ep;*6Fu'_]A71LNf[
FMdC846:sdN4LjS$BCg/l2#/9\Qh^E7@%PQ7,gmk?<+Hg+p5P)6`j6^9.FbJ*Q'(cMG`FV%k
uCoG1I4O54!@QnFbT=Cc6h9=/RGOWM0H\KnFeSn@K8Ce)Uj$jRiU<&jP1WrE)?=t^u;Y9\Bp
Go%u:1,NQdO@*DU%92U]A"#@oS>#982Q+MFUXN3n7Vlp@.o&0BBf@KCufH?^r.p7eJjC6h\K)
D._s9Y(%CR5TV)Go\t<q'Y#e+1Q;&,*Drhs?_j"_'U@8%E'U.1pNDZ`l`*E#*]A9DoBdf=LRI
N-!%=Y<eR1:j(TV=ad*r0\[VJ0nieL,!XF,&s18]An-`kn6>D&ujpr\%k!2J/(:BdH2E>QT1b
`mKbmB/656h2%p\nat_V<^Jmh'\NqMOfmgeT3b1&C8ppEp[/Cf,V9.(gbf,>%^U<@ar`Zr4/
8URPOmo=ola%3B*``tq4huGjd69$kD>h::k4tR>3YdZZ5X:49_lC`X_*NU\pr\$*-[A]AinG=
\AA=$E)FhK+$:6P[5#cR>3p*Xh7(.CJ2L!Fs62TB\[[j2?Z%bB?G.bn&"%=\W=^l0X[3Cp_'
'Eh\OMiT:\Qep3mTf*Q<#G#0cIH#DME*<Fo4/n@4T8-!TSWVj$Ku'3[:"=cq3ce!22^oj6W]A
RGh7@#iqZ`uJjTJRn:7+2;/eQ&j)+tRf3V-+1'YpO[/Bi8Dr/lVDU^"%hh'Idj6,/S4J;#.J
=kB:MlU>%KeXNY^a9u%6T4nW"(VVq6Bi>7!SJMd$J9h<OobcQB%X>cHf4"Sm"5_rEC-((JQD
5sA<:Wg_'a>H+E2FJg(@na8C+m/.6KmTenKAo66Oho9$hc&WLKjJ2hcq*Ha-<HH2rAf^q.jV
c!9&G@QL."?5/hCkZ.p(\Q5_rKOKHQ#N@>M^Z)[5(I8Uj<:<1-r#"jboNDlf\nUV%WX'li?_
Q"uf-f,*5M!DIgUJOii=iC$lFR0I(mAo>Q:o;'1#rX_#jcUFd#=*;D(?u"b\$BV4a/="clOZ
=gG?Quu6B(._2fqU)JF$8+>9BnJ(nWU/;&_\4MM.f4K%(rYG8i.euF7,&E7sS9uUtl,+_kY]A
SLVa8jf`H?jZu_c!^H,T=0\OE(P$;tU2X7TrE9;FJpg1\Y^F;0Vl?=Wnn0B@b$QJ;k<./$<e
S3rUC*qO^a_qQs(EH^T=jg9lRj^-I3-lPh1,WXU!2PD]Ad3&P$M`N4]A&-n"T+-nDX1Yo#c@$u
9`3V1+_Q)%U52MkJ3=0R+1Zm0tsq?__8%4h=+^05PYmG(PT1:Ld3`&C11Xl3(#-0-9iI<QQd
9c=O]A=`jD!itFJn+eS(4I$U^DD7L8RpFrb1rtXNAbQE,.e,DkPQ*`=&(.OaFM<=.XfHt1"h]A
5/<+'lrVDh#%"j24e#JNcYk,YQ3<1:i1UF9,>nk1!Odo`MgK[/Y^_F;kdp]AmBfqrt(P<N>3f
Lh)&bV?"HnjZO4sO=5Ipp6teCnnG3>46L1PZW!X-_R=<kH?D3pGHN!h+*cd+>E*I;?,3o?*e
a.?NJ?C)C/pgMuI&Am+Tun0_h(=r3F0d0:33#V_Gqe_H]A.N%PVk4dZLp\5oZlgAJ)tQ:ABcA
a:G<"J-,.!p$hm+_;"[kT9c4H!nccO4*#pS7H$%-(?&.c=nW&@Hq)bko+:S0J77Ta!2bDbBo
f4gDJi4Lmkr_%DP\+j1l43t(*LN\pl:Z_#RT6"lYo@'[DGO21j`SY0(-+oZJOKNH:#47_0^!
ar57s"N53QVG%-*c$.a.DhkOr3P'*'EFF>P)hBS0U;uH?2=<pboBs4CP\DIsD1[?rtFNS(7<
.-%"A7jgg8tf^koIUk.;hKU=RmX)c!k`sWIG+n/E*J0S'l.qcGuU[RO'r]A,6]ANlb.!g,ZiN5
fUd<0B]AmeYc$:8VdfHS0@k?-r@Y6i("'g!%NPZQr$Ob#cL_jBV=C0#<C@O"Pm?r'KdqUYi3o
4p*aSA59nX5iK"d)7ISe38N=W+:mh=b%S]Aa@(DO6^7UC4>qna\)u62f$gU5&=lZ,_rg)M=8\
<E=/8k&>VHSr>+\HleDtr(]AXcInG,20=``(<-6Sn:7b54',$k82H6O\elee:@iqDDn<[?B1/
N]Aa\Ad)pcGkFTe08Fg&3gTu?WJB=EkWF)m[Mu<EWuqO`jMMYL,+>L4JWo)NK9AdO/[%nf&O/
s;+?<*/:Whf9B^UTX4.=kFI`d`SoKVq+Kj3P^"a(HhXjeX%]AGn)()oM#m"h2@]A4kahoVB*:]A
8""ShL&Wmp&ZMrSkK:W]APjt(s"<2ef=p)3?U!#!$OZ&Z42-Pi^`6`.G@?_"*NK,F"g$Onk!V
Mq!YBuNV"9`'C?CD\S4b%+V6B_4.UgG0XaAUUOm&L:0h%C^Z",mT87.\fGKLZ1>)lGG>iTYp
Rk[]A,IIfrCp_]A[fCWLZ9ED00egsF43KR_o(X1u#9akQaM_b9S[\>fh.$*(NId?$SKm@iHC-f
\t7Y2b*T=D8N,.,ppsXWCF.::bbOL"GnfYVUYO"8jS!k-^gqj'1LJ:6"`/r!7U_J3>pkeZJ:
rfh8bKZJI92/>c\8onCe,6Shhrpc7rX`\am-a5bJ.V-rnIhaN"-,kqlO-`kYq@[R=2,Pn%QL
#uF*2r7kUKD$fChpsqO<N-I[49+EYkh4("#>!je7l+iS$(G%S#6_pY*X)UURd#XV2;eFShrU
OLN#aaQ$5d9Y%Su>e!9K^(SZpj=(PXu^'EIsZM!G<,&3uLO`juat7[ut6"$$^q3E.DALQh_c
a,sqLc`0p1GY1Qm?[f<1`%piuBUBQ-#!:o\n6,PU=lf&Vg:hZ)U=@C`,!.n45V1jFe,Upm]A+
9%<,lC85E6.6^ir5aW/WhJ8B5D39g-[HG_E'U'fVn/.'l/HZ0+Hbn/`0>r0m]Ab9f%/Dq\IR2
\hm!3NGh3e0\&s`f7OtYk02.T?b;i!h/!=)89EAYl;_lBSa)'W]A"SW!0TOXnGebcN^k7>.Q2
3^;M*>BVom9AlE^#VN:eDVj[oAIR*Ueo."QK<h=_NjIp_`q"9?V;sbD39Y&mWpN"eY%6%GY\
Qg4Z(DM3cc]A-W)XMLm%K[I/Q'kHJ\[Q'pU@8siB4+H!Y+LDOTA!;XA++C-3nNL`LE9*8ULsi
WV!'Q$@+\K,R/OMM%2&CeUd(URCJn:pYK;USCY*-G`iedZBrM,Ocp:FctBTUZXEIcgU^BRg.
(Kl!)8*r&gFOX"9_0`rKe@U-i/Ppm9F\C%84\#NVRP;c&PeiS"IPK)+",6]Akbr7?_.?^Z`^3
:iWD0kd@i#u.FOJtg\NXgE;685DCFa4T/Jo8`QgBcdQ:nj[5_%\XGM=t'#V?pX"a;+-3lB5L
DqgI3J3J,eau8=0uZ;Fb4l>gQI\$c3)r^Bi1]AS(1Tc[<Zp5h1(q<]A.B]Ae9FQuU:5k$hEuo\8
h,nb9-[Gn7bKoQ,8@ZmQ1':i,96e;Inc*OEkMLrV!"S5iKdjVc<dXi(L\o%Q7al/HlEc*94;
KRd`0O^\i"+D$`tP$ZdE2^k$!r2!ikc=-5,r*.\.0*nZp2<n3JHceR`?C$_^(0=Dj*o='q@I
gmc!KTS!;`c>%hpDFSO`D0'PX,f<etF\jYd>HQeSf!DfWG[rAkJ"j"Estd2X4LfJfCSeCFFL
5H_IttULo4b]AH1c.%*i_m9/N#2`@d^`=AJ>.f%@'U=+4ZD#JnB2:[Bockm08$ku_dFBs,.^%
ZI]AfcqQr,?a7buLnY5%!'CC1,dc\#s/nncE3T1(4F:VnloXCqCBoL&'-:hRc<`^VdkilGN>6
7]A]A70Q7JEEa_ou)a4BWYtX8^+XgNUhG^:9d!<,`;9LHXifP^GV@e5JZeDM12l3CKJd.b/'R1
Qe0:LLY]AEurU"JRkk2*1pa[N3"'f<8WWt*6@Qh;(!FdgC:[?B8BX)>mN%0Eoj]ArI;h%:A2"F
'Y+>5F61oo.Mm*Ca6b.Ut3;oi$2/=l1)P0R.,H>;M2[ipm"FT+pJ@NI\`E;de'ER8cqD@Y6W
9?&_YU#>-e66BW'9T&Y_^KAcmGC;3bf;AlN)L,UeOB]Aah1+17p-p*Cp:b"8n3F$l9`EFn"kN
U9uCRj?mB3e,="QC@!4/Pc@Fht_5WB"g,*Y69dc/^Fcr#;(aXrRWs=%W,NF=)Md!)?Of%?d$
CRhboLMi]AUHE'lJt.g#r1-#i6c)q;P3BN2Z.!d6#%Z++is,1.YH>ltMKG3M62]A?8:""I7<tF
:pHMWj7uXO6,UTr:B2X&(qip[;.@EIcQ7:O=2B^Z[F0IQrNr._F6j0E`D?%ZB9ClS"\.$eqh
MruHO/-In^e$Ck^BOr?`UkR_iP$rOXUO1aJG@Vn=%if"H#>o`?59^'W$gY#-p>Dmm_o3ZPhM
^h&FjeY66d_qAeQ,Y/"[)F!c=7Ge1c7j9`7!DsHqcGJY1B=D9!bAOKkSJsh8-m+b!;=c9.D^
1<EZ:-G9hKltpXX=)PO@>Oj-0&S&tCuP)iO<d\lm#dj=#4e59o;i,'<ejVHXf.3rb?&L"EPP
"Q"`;P;aN+3XXS9Dg#ua4DMN/9A9lABO2E#Zd9[WFA520_Iho31^dt.719$O6aLuY,iY&07'
Fr[qpN#)RrEQ#&o>'B<FZ\fQ`Z(=h8D.eF"?[m$k]ACq;6[B,%=.9\(0rlW<B<'_)"E"[/]Aa^
KTjJCo61_7.W(%k_u9r93cF,F60"XS_0u0^tEiSk2,h6E:S!Kin)&fmo7U[uj>00XC+[lXi_
Skh/1lnjgP(7L_gfn,7Z3eAY'0huTF/4,Z)LU-r3)V/:)^V8Onm>ENp@"&[F7.Sm.!:Kr.Zr
W\^Bs%cNCs+=PuJF)htc$TqFn-3li_Jnbd[uiee6W_sfS-F:GZtl7dEG8dgSAC(I*u#I+Kr*
_A-ZH?]AOK^O(bG`_[gshW$ZkNc"rA;[6EI$$6o+>_8LuP+,#4t\'F7.kW-k0eEOq&Y<iO]A*9
>N`@G:LFJ-H.pc)-Ym!:'lggs)jnt?C#uCgb`S_Mgel\U[*g]A_Y=38V]A8h9CfJ^&4YFesM<"
S8`"[)>W:!mF`IUb,d9VkA+HmZe9%4J6H]AGt/;1]A$t<K\fn17s,fm/WRKCTLA9b[+uJCY#Ls
(GNrfQ?m?)C1(&)onM2@+_mT$J"&HtV]A&]AiJT/_p)G9a\`IHA>[_<fp>^_9mh&YOCVhnB>Eq
=%f2mV/?!GLg0KF@9u,:/*H(/bV\;EkoM@'*p+JDc+'7UjBNSd':p8i7,Bd;j[(%a!QNr+g3
3k.%!qJ<QL\KlT)H%0FCR7klo$$YKrm@:!?%roGZiuF%d!aco(307Nn&;VKR8_P'q+7^!lKZ
Iq#hB>fW7ThCh$NGdJ\VHf63>Y%6>QBod(IE[RkIf8iHDgeZ#&$0kPAnk@^s)[0G1$8TXd]A>
0YVoXiXBN[H7WMOT[t_^W3Sh?Z@aEl#ha0q#N5EC;Mc<Dq_"ls<]A>a--BuPE3QuAD&pX1g0A
pjE$'QrCikT/4lCK9J[7A?m(56$8t<C,KL[$m,-fh[EYEYcd@)fbn@pBI6W\WF38ZG9n4+Lp
++l4UEnNZbH_fsRL.$[s6L6(<_Ib.bUqP)gHYn3*s(8@m7RDB/HaWeY%Bo)>HUh?dkh<SO-B
HBSG41//_5>[Q8]AND5Q;^RN.r1TQsuD[N=n/.>Bg^io$3\`jU\?<';\==4q*CtOZ^",W>08<
E`imrCd;U)Er*R")+u!62A27eXM4TJ?RDc8AH'!p4mr@c#2lW!/"8+&Rc7#hE8\ig-Urn9A,
LQ3*0\D"DJ3:;hK8*_WWEFiq?)_Npj_`'DYn'Y+FCo]AG605d[D,YE^1j=bf2u5/K2[u00NI9
`8XF=J71J)[r/\.]ActajcPo(g9deoBr0.rV+(#g,dCh5Ep4nX!:lt']A^?/\"Ti*Y,3OB`L`:
OU."B;)qHgt34RUY?;LD6&S@XU"l+W.BcA!GV^ql?KD!mC</L$ZIe1=!.ESY@@f<qQ;h;>dJ
!^*kf,oG6Qd_3hjCH4jj2"+TH^1.I]Aq0[_@1_EARPcD2jM`@%`&LPN.J6,/?h0"QE*OG_2E#
DauXBL7,'o,sa0`VfJ=4754ceRdX-u(#8e<fmatV*m=<nQI^8.FBLH*n6]AD`0K$?kiCh*?iT
doJWLj.6\>c%,3);NtV0j'igo\;olMkE3"i(2US?H+@;`\k&q"uMZF,pf!n85jR,Z*Z?2#kK
plQG?iZ[iTTC30p##':ssmhL<`!W=tF'c8i6(?PQ9pA#YbrEh?E*FJCMs0qW*leqdO0i>gfI
Hgg0pA_5j/3.1Z:VgeDRLf/]A;3Y"CXcYLNqHj~
]]></IM>
</FineImage>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style vertical_alignment="1" imageLayout="4">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style vertical_alignment="1" imageLayout="1" paddingLeft="0" paddingRight="0">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[buo6me(M0PShkZt'rIpcMPprs7&:3`$r)uC,kR$n6e*;I#UClE=D8(uKJlGZ1jK.SU$<aPTo
:+%,SW*:JWOOn+XE-cmmm3LNVD<(]A_?dIqOcpJcIljt^"6HbGhq6-@Y`TBYt^]AGm5T7:b]A2+
/Y7R0]ArKlAJ[YXp:`qmmM9q0Yu:RN(^?d+t\7c)8Xb96A&$p#KpM>mRb7G.TckuuXKJ"^(Rg
OK!b9rSW;3:G]A;R;VBh5Us&k4'anqbX,5q\YMuQFetnGqllI__7!!$?i'G.SI<L47#Y^=pE`
QLUDEVLQ87nU;73g\7B#3K>0UFXFg@D-TFid/['We15#QHg<,d.5mJsi(IK))s5^i-0R/``!
AbHf:q>K&&aBL!g.hpRuW'cOn8Od*6rjM"3itW/(hiP1jbM3B#S,AkH9i891h;[19b"DYp`:
Q03)'2%9I']A0(EmAmgQl$V:eo9e[qpf%b_0CamB[_NZp[2=%jZbS#j^)7Z[dfF(mriM,^:+2
R&A>:%YMg>,XgiB#PoSDGYQLc8XMZ`n4\MSFQ^$(E5T9->HWIgRk'2US6cHU)=<hj=@02rLP
X+-0i1R.jXu_2u&n\Ne,Ndm:.H9MB]As(n=?P&He.b<g3UZ=]A2/*+,_n,5<b_8d3ZP/E@@kJ`
7+ikJ-3^;JNU]ACgLf40Ya8Vg"8i%q`NCSrYUPE1c)0/n[otW\&oE=,TV[*S"VX]Ai'l?F-"nl
$@Y2oolTDfqK.%c+sMk%6YYcOOh'QVC2)osjtj&l"gcqj8YlteDLBM3AaWp>JV%'#-b#%ZS=
G'Bp_.cKNHKnYq=]AZ$cI(^eA%/s$I*VK\]Aa,t<4Y)tOf-L8W!2[2L+.lC0Bg7k.b02)kZ2U,
dAPT,qD^7NI:+G5dSLs3@lI=CrO?4P[0=e">]Am%V'P9eB>lm+EZqC=$>p4*jfH@*cW@t_J/d
E^6k9ZRMGX.VpYkH''rU%=0)jHGLHO#\XDZ?5CjE^N_+h!";)G6CQr([!K!ZFfV]A0:%XePX[
6B:p[9uWKP.5[AE9J0Z;jt_sk*RJs#Pm/YMG&,Kj^+GUj=cZbgE"WZcLd*<*f;]Ag[?)YgHVL
2R;Np(;+<Q)LUu>al5>!4T&o4H*13^6A+;\"kesp$hFD[(20I!W\,"'S.*??==h^__\O>u@'
b*&H!ZUUX7#&a%")AuJk2WZfVNYE+$7'8i;5#?CXXfRM@8>q/0O<d\O&_(#U4d8)[dVF.Mb\
b8#SZOHqHNPHRXn*]AP&DSLGlpP4Gh7RIaZ5gmML]A7B]A06-kiB(FEP3aG4Q4"Y^6s1mN'CCiR
%@;+B!DKr5#CKi;Ec[KaCcShNtDb,VXiA`N4Kt_oYso=2NM%l;Bj,4D\SQi6s.8pQLOT?#)t
#6(ApK#Mj3W:,TGeKLXdI1\uJ\`lO.d!<tMgUFXMYaP'_+>;J9+@p<K.j"f*j^]AG1PN);Y!o
F-?bVbAsX#kNBJPV/S=`?0Zj6!M`.gZ.X,nkqW@MbNEc"65QI.MXU!4h4psI8br,;90Ko.G2
C,q;_jMYr5Qb!9%-kF('875o-_pep+H35Atn`CieYHiJ&CF4p\oDS]A:_Gp^bVMr%ZBXO)9I/
H#9DQQ@T+iMfsHkVQ;lH,b<q,Qi/&PYLbP1\mls9aTXROfZc>efaILoW2i3dS1*`+jT`fZ)@
^Ap8X+Y5VP,,[k#+m6_nUEO!#)0)Fmd85SKY&ciL0cH">4Pb_W>[B/Ni'QlK,m5R"tr+96S2
4u1qh(mRF\*/MH;cfp3sE"aJ\V(d[V\e!VAgQMOs;[S3cqqI/A(Z"*QeU6Kk;jA$OHCF":&S
mPL$cB+PlF]Ak`@tl83??%W*02<h1Ppg/AZ+ZcKDRFA-'.SDAh#0TU\(!Y8>q7kDWcc6<QAG7
PmN91mSB,Koa5YhAYa]A#9-[9!'_"#>8+/$c=H9$?QU+R6s#<X*9d!HhB(JrYAJ#0iY!,m'NN
%[LjuZIEGR_@uF</5K(FE<cU#SjE']AcpSPe]AI1U=B)\$&$e(6<t#W9(@Dd9H<X^Wp_-N.L^:
T#=Uqr2_sESi#mpm*0@\]A^n%AB'-rkSAI+8f(TQZMS0O*X['-n;+7Cb%,00=_D7gO[BIGSat
)m^^7U$G]AH+<njU6H5PPF;d#cVU-'T%;^l:pooVADFL\t=NTaBrcIP=u>,YZN0N6lgD<mPTk
%&,J0b.0f*ZNi<khAF,H-$=q7G56!dTtQuE9jkssDQ+XG'!?F9D)oS[$0Q*"T[LuQ@#fQo#W
+!62:Snc7YKrIKipR'`bP/T_jP_m`p$f()`LTHJ!THg5$[("XsV4om%_)O-J,4RR5hW,O&;3
:8Q;lVTh\d]AL%gQ627q5C;_boq&isPL"`Mr\qH%\N=jcIMU8fWD[mBi>#-WoU!/h@e#@<QMP
4AHn*BjG)3[RWX-f'87?`Sf?\2&a*adK2C)chR:]Aq2CJ>KkLM2I;ilZRPEUQ1!X*%oqe>P#6
@MX#+@S?rGk=D2\WS`.&Btm1@7Pkbok019CIg(T&j9N&(ncRjM<Kl:/-V29*&]AFek"spG>oa
FHpSdVhPSB6,)L(Rr'TV,&E,)gXW>kIt4CG?7i!T)a6"tmr?D&<miLJ=`AG0(PF/M$rG6UaZ
#r[-K2<m&8!G.L`ha:Sm1/h;nNZrWSJ+IUQB/#RK1=%:DD.3UKBs/^PJQ/%^+U\7*a,"8AU:
bnt:3>5,3`Qp+(hX7$XD#:?l'Fq0#&>,]A(-B?)a!SXeHtGG*868M-sH,S9N)o$[-^6+_lCgc
]AiZ\GY7TKm#H]AW%lWR1@j!2'W/sl<ACdgrC!$[L$<lEUkbWU'^bBq4Z^&'X\Ji:nR-s;!kt:
`L_B<S"$n&fP+Cd1%nhW6@$H-(J#p,OHi)#/"8lFhH$^]Ak@7p.a8Y?Ng]ARLpsu9Gt2lX(c&6
X)a\NmTTg<BdKdl&*dE98KCXXS(=]A`Y*4>9eM-iN^-OSN+9'QR1m-2eT03jMDtV6hg-^Fbl6
hQ>C5>tTQ/!*W/uL?!#5.j(Y=boG'0#3pb^'+,7d80ch.[S@3JM.!IqdMlSmjc[BqfPJMb+P
Yk]A8m=>aUq-(S[o3/7&qs'bUWWP8G)[>ANA^dkJHrEqk(ES[EPhEARhX51<^Jq2l6:jc+;?h
Z!$NcAI@<UF3^\%8sIXq@Gte'S38m9-GrER=T@,b1uicPP*5tNGcpR@=jY!>WcR\[+Xi4Mm?
;(,EM,e`u84jjauKnC8S:SBYSg]An0!V_c>Tq^5?Dg#Zb8*K0UF^WaJacbSOOged1m6a@r6j%
21@6sNq(b7TKkGFAnsStYE;m%>-=<JN,a-09s#U3-I69@:1BVg*=%6;k-t=%0k\p-r-n8:NM
bW+R]AraXD7%LVLb5aLV-c%^fn<d$'=C5^legQ\BV!GWMlZH>D&VaH#_um/L\="pN(2qoE9c4
.'bU]A2$uc/c5LhUZpSo%>m2@#\DmE6ZR^Qro9Ge]Anf\W,9cGWdCaQ^]A,NJ[A6$Wo*=+ns*"n
mlG)=6JQmJ#A)[\@tV@&h_aM8r#0$4?7i1OHnopr"DIF1=+,#%[oRfVmBhshPG/%]A@0L!U>&
3Jr!H'c:'i5^>mS"[h:Qc?%!$C6eoo#+1LQ_,GPI[OD_dT=T"W*J>WsjpS`At/hI*4iE/L<b
U>D)59d-7OD*8SFpm#^0,P$9$XOQcJoWg;lC>Pn[]AY$oYX9l+uOmGoUBrK[;4:`aB;:?1X+!
pL/!OTK5#ZV=5`PQ1o,QmC^DUGNo:e``I.)crJjsUQs-,f]Ao$p8Oo1-G:LUCgA@oEIBGF_>@
aF6U9+hs&CEf;1.R=diZV>/F.ZBd5RI_<%XG9ca34[L?B.:S/'F!-'4cb43&$D>>&QOk2['q
@83;)7!X<4`4=(YFVSa,<Tek=&i)E'GmoRQBmHQ2*r(XB%<EmM1%bA]AWI<48OV(ZlM6Id?02
"33mkQ4eLd-O<k$RP`LL>6la9t'$4Q74?Elhlo[1oRO@<e)9*@bOG(/N`?F]AN@,ccOg9AfGX
cG&@QZ)Gj#;:LH!Un$,0Y$b&%;#Uq!Mq98(Y6DOue\P(8IMMO?]A\Vje2aOkJ?7hF]A?7kbJl(
)Bi@UY$c&#UP;E?j.0@AnJVRs4pEdPrV2cBOnO\!lucYUc4@?dVLgiI1*`+d?RF"!rk#2iO,
$mXoDt)#^`]AQ=]AVa@Dc.72PZgmeL\GU\L1s0VW8s!-Br=S;**Oc1+-O$Fruht0k#^@6O-lhj
Rr=g1;L=VZT;?6I%,o:[=$)mR%A6,W$Y:%/P_qVUjd-EDjFoj]A-)Y:r0j>AkDhT&),"&equ@
1@qGFlM+Hps!Jl)J)(sM).pOS&HVdn(^ltsk'A>FH$%Gb,:i18tP'OZVH.Di-8:q6_hUXHg]A
@U#l/,h?K_P`_FBjc@J<_KFbnG&E^0;.tPHes7?l*oLU=\)8HrQL<irg%!pB8uG$VB;FCr=t
t+Cr.O?[YQ`3V`h)j5.Er1-1TESThik3$SZLD+3(T1unb`^Q=_U$L?G8[N0B5Ag$[Bh,fc_>
to\hP]AY]AA_BV0j$Dg:l_^Un9-%YW$^Q,@.H`B6tAQjc%]Ahfq:YbhYk@:d(O5eNjBqZ@g)@QM
D7S'.L9f[Ne*W=mL+D@Eh,IYTh9<2grg;9d7*(4R3G&Kbc/FF'B)gLRoO`ZQ0`^U4mNP(4_%
P33,MLAri7"k`D0jnNQD/]A0p%TX*,QhJc[.l>I'p5GKuQ*W0sjS7r]A;b3kSUui>4bEXH>9kJ
Jcq.DlMF!a6^3#U4Th</5*<E18B/k@htFD*o:!r<<;CZ?n8=r34ClDi__[<+"j7dPrG?F";E
W/$Hetu,*PJ5mU[Q&'<[r4ec/gsF#Jq*s#BG#57.4-H?gEUlHhTb>:ec;on'NY0afUP#fi,(
,RDnW.7%g7UH?M3scQ"(P-<W#nit+H+>bs)qBUZ9?_oSkHoXbf*j4ee'&!HVK^i$D6?-Y9oK
cbuJ'h8)7NL2gH]A"$,Iq`9X.Sd!Xd[L40SZfhH@FBp%ekZlIC#!*`fXM=7F_"jRc63Glu'YT
[D.+&&^T>t02-;8N6<no/9i@BOm(50leXVKR@O#0o'H&ktCDS2A^$Oa\U94ZLg=r8Il'nTl`
a<;t8-8C!*k0<]A1D?cHoTMq;&HCkSA7Ah]A5,g=WWIC.kPAgMI7Q8-CJgQGX!h+,[9aFi4<,`
Hi2DtR=cn1lD#^nbS?6mK0:e"Y;ac))"I@7h+>iB;FNG#00bT^JZ'5?fU7/QKk^UGClh:>+p
7/AjH17u7&CS]A>lq;F_04dmDClD=kWO$jE3LeFA<hLA8cBlYZ'<gPS9+J#!uVlDo0j`lcu9>
[^!#3/,RjDiCc.:0,Y9Ksl<Xlmad7Wn`bN0&Q/An\WfNA\O1i?"97E&Y^iB""9<`4nY(R`[g
D0K4`cgE8f7m9]Aes69Kk,7`XZXQHe^`?KIY&(h]A,$fBoOO.>C(X`5@TWBG#ZHF/;h)b?A$]An
r<R#JCJZ\aiY]A5^"5Tp*&9qi0U:)FEU[&7Ei$1NlHB7^Ye?A0CNFZ"YmBGfVF._hJ%gVK/>^
AIMH!(m+1Pq]Ao^QS7RVm;B/5d_\C>>B:`:`&T>$>q\'>"k2;VbYOOO7+M+DUAbURgV7iN>+W
$6RnKb1JA=[_Xlh[lAn`8@,\qHg$phe_-/oSF7I+]A42YGG>1F!t3'!a!I[%HD?,%(QGJRY=:
#qbTPGJeZHlP6(=hK?e_HH"ZL5#,>2@P:S#;`6cmAAeHAJAmT2(Wdb6a6>2c\$CP7Y\Brl;b
J;m[b*\'j+r2"2fgE4to.h%F/(G?%Jd`1g1]A@=E.F2[^*gmYFP+trdj^;jT=Tm]A[ZbBl6PQH
SoCK'f4G>;_QI!I&Cq3t[2Q+RVq.n?1Pd'MKlGPCX'Q\oU1]A0oLnl[h%C+cV\gB$SF49ocBP
3XXVNOO2'iuQ%qQb/`1r>`l3>T;9;g/,F1%erX@S)nJZAd>;s,`qBGp(CoDeL3jm\uYrTTo(
4cY*Y*8hI-BQ&iL0Ql;0W0,f>QGK_:IaM>?PKfIA^dVTie@b]A2l&GJ<cLmP,@D*K#(T^B.KF
j.am5:4`N)aL3"q*&XKE4.ULb15f#^8MWs$Sb\Wd-mF0.,EuNPL*gpZ5V@`P=2f[?G_uX6*Y
+NZ(8j]AVcacuOtf.]A?;]AWTA8J#RP`?o'E`@c=44A;_K@1l3a$;P/_CQM,6-B-Qc^S.H45MPr
]AMRP6==o%AZ.s?n&ZJMVqf$m_Uh2Xt\ah(D#n71ldN9OUAme(oL*1%%1)eFjR-5BAA>sXD%I
uE:_+l!mk0.00NRnPnR:htZFJ;q*lo0u?_>,B'C0aW1e<0JdmHn%H]AK`"J_XPiZ?>FXG^eVM
@[uQh+()_O1lgCpT3!\eUg7c2(P.9mJ_N.a2^bf>8j5&9^%9S*_WIkFLS_9fgQSok_aGg_eU
@J53FroYWem3=6a(MjEKVda7h;e'_nFBd2$_4?WaUX##4Vge!Pl/gkKJ\*:oR2K7UK\FiD8&
TH<iY=J*6CN@p+VfirdOL&FK25`CJ7uJHE8^_Uq.2u>iMm,pHB?WiVaW=FlB(V^L%XYrR'cX
`VWpObHC4piS<k4eL8QK%Wc&q2QBe`4F+s5lKW$B'+Ub@eU1$MA\a'mV/@Q>n!.eH:O+@K@U
>i(<mc":`-j8AXbBSVTgsS8r%88<$9ik1qd%5HSgK@>)dk^uoX;MLH,rKZnFGTk`*',kdhl;
]A8?]A2mI/I+9A(+Jl`J:a5<b,puT6I7/lP!iO4lX)(4UE"XRT'7&qD@tJ`9Oa+OlF3X(\BT;3
)Rk/=76Ru'`JNYpHE-P':W'UUE84"[]Ac;t2p$o!AFH-L/>^4ZWi>N\\T3BgKOW95='Am#f@r
91S.T@sJ)m3CCA\1DY<EV754.Ul7r1\^>+&mHgP5L`bssh>p*]Ag6p&>;+;7>;(rQtCJJ,YUV
=)8o.0"ppG&odcRA2QW#\OCD"Lj[TuT_NS!Bf:*HpDl?Tro[YPd`#Q+0-J0^5A7aQoD0]AiCD
trsXe3:Es5-nrk@(7a9<@MW^sba_R#/p7s7lc,qj,Q.WrEY%Ts;&4f\aA?2ZO^,!n]ApVJk]AT
Mg*)#UYk4:bD!>S1$"r>VS>6,Q02B<6K.0T$&$?[pf5>T#djOVQ>jL[:f13p1b%ki,P-STrV
GeiPYcuk62QH\=:&/9^DVo<8"X&baJs=Sm>Uqk?=:W,SDB<#r,``\[g7jT]A5/.'scqL&b[M"
cST7\X1GF*KMC-CC30_:9AV@Z&u7%t:'$>+kD[_[;D,66s3SDQaQ-31RnDrM77f/1GE/,rlP
I\m]AX,qij`Z4D+#frjjnU?i[RQQ)ep:\FQRQZm8>Y")keM0k29Qib>;5XPXM1na\e!%<1P6=
dKBm9X)>\YB#4BI5XGieX45&%tqZo9ZiV5(\Q:5u&A>lhQ2iGHQF0EE'fu>L]Act!C[?g$9@V
'bNm#AHT=q`![oGJ^\uqK^u5A>N<"@QPsjAaZJHuU\\Z$T):dLA^F=g2/:Z;`-LGRK&oB;eA
^u8!-`+<SgHe40r1pBD1-_>3+]AVcIVULs?;&fNOh&BuD0$\dCD3d%c]AeROl:a4P364\)9lST
q@n@fgO/!g2+5Gt_/.:#HP7sl\%nR[_l$8)FMfe\/jS@Z_A2EL7)YE,c?#rjfP_TegJ#%@Yt
,k;b.(r9-Ep[L%tg,MfWB)2#3qNB/(f9?X#Q6khOf=Sf#FT)3+K&[o-e[$-S6W1R53\32+("
lE?aO,bCmAMGWN8._m_%:Nk9fhCK$MWKi)[kSqe^Q^MEVu8gW$#uLm/`<7)[9WD]AT<:F6S/j
9jAjf0;]Aq7!GY0;FnbHA5i++`o8^2(e91]Au@\J.bc(bs;sZcE+8QWI%7!TO+HFYSme\[h#;:
f'P:]A6+fb$;>YkaSPmS.h\*bid:\FIaZSMSa5ToIm-c%@7^!fqAe51d4.9-Znn0:M^T4@%:C
bQ,3=D*Qi<O8e[QNgOPL2_cUPPF^_Fp]A%M0eVbRL($Lc7^f*oM"Ee.=Ejl%%dYXf!HT>tHqn
5'-XC'>V'94At_V5j+"18VIl>?i$DCJKdIg%Q8l`QY^HNDU@59i&(`?R!$qU95oD6!Ot;.0t
Ld;MjpZXII#e8.m_+G\qiL2eq!$&Z;S#F^]ASc[67JfRbWN4Er88BO4F[6f#A#[8^Rqe2FtL#
A/_&T+VC)?P'MX`%cs2..9qQtmE7TScZ^S5L7$C),r+Bo-X,C_u]A`)&^/"PHrS;"Rk#p>gOk
oqJj+<&Pfh0:_@1qoY]As1YJR`J`h51qCL*W9N7i?,\6_Ie\kUnZ>Krb;(A$T3L>e)EA;[#Gj
*e"Sj5H?unR/B*Td1;#r$G&2sjp,7L_C+$3`&(BgQ-%aO5:M"+=F<-lW9_[`=u"?muV[*$Js
5R!mJ`li8la8R!eN!eKQ?%<+IK?Gee"fNLDs09ABIC?pJ8NYmlO%j/9S_$@,i**rD[f+aaP5
G:BBtl:fp?J"=ANs&jckHQuTT$k0LU^UfF^:)S0s"G@49:>$>\<&Cgd$\u2BJ1Qb1>5P5VY6
UDRaA9"g;uI>A-,4kT'SE6>!(Mm_:,8pFfl5BBbGobC+$sgmn*@TL(%?dj5E*!%'8>;*=kMn
fn5a[iXcI=4TKVDM3u3Lhup.i:Tm;qr3;f,h%?&)=u*0+A3NS4m/AjWoZ+nd9DP0@dM\WTfB
saD)d92g_e?AmfmC(MFQls<aONNb6rG!ESj0%m7*07T)AItebL%_3j!euV[+%IHNUmcc',Qg
kQ%\o1^M1ce]A-.i.Sa.IY0p;.4s+cA!dn,`1m2V.?k;2\V')bCHDQVC_^4`5[2c[:dl'FHI(
rnp"PJObd*!m<'sL6ZB[`:riP54Ld'%qfPWZ\\PV-(G1-I<bk0F#3F[0RTSc_Z4Db)uHFhsc
%[Vh9s($O*XpCeYg/uMj5$pUG(\,$#5O&S?Kk+^#J^jT,QU=S&h\`_cJPe"fG-SBlSfT?(Y-
;!6iTEFXn(qtKH(FP<)jh#tnYOTKO\mr4u5CJEd9dh1YI(OruHaM8A1Rk?01/`%$L+`Dp'*(
H@<uUk*XYk23H2l@@>;R+<Dt(S-bC'?NGjN2k(\jU3(%V6L,pJgBV<33?&@b42cp(@9:fVeq
dS0]A_1M5ZYh@6fd@Oio7T"#pg>H#e&^!F'J8+s-op#s5QF.UL.+kCuPf4OjSadXJoks+/::;
gq/j8nih[5]AInoZ<',5=/m`0:ofBEM+C-8o"ob]A^/"Lp#dinW<e%OoK1=]Aej]AN2,s^KNT!(!
%^@h/&AN.30EZ.XQH%OMPgC#rDS1"5L;7`EDX0m0%-IJGak-ek49RaPC56~
]]></IM>
<ReportFitAttr fitStateInPC="3" fitFont="false"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[`E6nT'5&5DAQrDXWEZu7+J`mNO*V?jcrD]A]AY\G+^'XW#K,*gfTU90;-9%8s@edJBE'!!o+$`
5g_FD]A87Ta?I8mDYlQ-K:j-8P%YL!sk*2*Q)ENSX>g`@]AWVa*h-N)RIC!bch"lspV"<qNAGT
WfJ"5'2KE-HgfJ3s+T`SLM.o>L_V^/-8#^40n;[&%raYJaP"sc+[)j3??E$_jOC#^%G[p3km
U:V([iUcT-bm2Iou/j7P4s)]AZZVlc\h.L;\N+F.5K/u7bl(:6juD"$1J=qn8I>!-.OT&sN(k
<)Q#=>%QJU)'[mWRKXTIV,3CYHYRIC.0k)-RKf;HMJADEqXq+*uL61e)WiRReq,M>NqSL+7h
6*#2'36^6(D3GHU@6-O+ADqtaoVuQ3C\1;3BkZ7*%<;qG!2%?(&<>s;"1RZX-AgnYaQ&E<&U
G&`0qP1mH^#+>BrPiu)0W9FD]AFe@5eX/+Y2Tj7PP#AZVp719.]A$=En#Hirj4Up@.)9.Q]AB/7
>cK>hTb!1uSgNgKuX^7!k`T+A@1D<g0_JEb]AXk@_5g;TNfB2rqRgLU4.Ggi5LSc5MNP0@-Cf
F.&8muB46Zp30b;g<%3j_0%+Xu421e*C>_?Y[qYmU1uME<GrK+XaA+E*9'Jhn&l+X\XI#=CQ
H@:[(egWtDmY<f5Gc#K2D\=QF8Xe5nYQ]A;5plFm%&nmAh0ZSaO%^ETVTj[^U+OKB^'J!6'YZ
'LMb2mWPXMKZ%oK0h!2I/s2GLjn)[-C=9'T]AQuLD[DDl:PFsIFkBphohk42!+=n[3?A-makD
]A:C&IV)ZY?j8\D(US6s#]A7I2\)jU!&_gpo5=%E%e<tpBM<]Ai<b`t^Gkn*E0hn:WL^m5%gOgh
C<]A7nm?5>e8BBXAEErT:VMs48'';[iqZQdfA/C(@aP$-VDj%MAgFmb"%a2jTTrLNke1<"?B:
O5,cA\2D4SCFe&/e[c8"<46n&q,:+Ag$s*^V7u8o$XBF+4b)U>%R3M$m'ZMA@7>^NN+'!l&f
dh=@uq9k0J^7QV[LGDE7f0;(_CA3_.Fos0*g*CPi@gM4Lpm&#=+sBs*?h(SA?^M<Mt7eJn?,
@Jsn,0#XL8Z_r4&-+:NM+cd12gN>h>a0H"X"?24!5^_9:2)hCn&4@@@,E5RAGlON5="e@Q7i
p.lN1SLqd43LT!5T<&kjEB)E\I#0BI1tW,IXo.CstB,q3P?`F0)hpb+K'h7%&errr15q?Xjg
tGkOK(6b\Bc5tML_pZI_&p]AlJI@g@Y&-mR=*C>%r5e(s_m'T1B6D/!GGoRE#V%3n`k[YA)p_
AWsc<ud$gmFdKS?U,t&Men6b8HoQGlDJ</@DlXabY^5Dc.U;N)SpF/>U@U!PodRUqa/:)fCH
-L7nD#X4a"5.3A"=HAf,gQgKh4]ATu8=Kqf>qjOY7S.i5=GPYR(=aO_<REN=8tj[&uB5.AfZD
H.Rjf8IpbK[0$PX*--iL$q&8Z4.(GZ;Z@)]A99W=nABsn`k!U#Z:]AE0lj>(Rs6"d44:RqN%4g
fLI9D]A\O>-<=rL&f$o4KPcm\"t";&7#irV(Hr6&O$L,$8um:iltk_3\'blQ>Rt'`"UiLLmRD
>_5]AK=bn@7T'VjSGBhtUB#oQFWn]AuJ+&<?s'S\_aN4Alrr^TEn.9"@jY3M>kZSr-aoV7<#q8
+";]A!hdObgEWN"fHfU^0<3)G>r*9]AK#W6thO\%tpXu,Hf;9!H?AX*bYDIP%#6lolKp364pP#
cAmG/)IVug369\dub+Ha)X$1OZZ`&Hc2IB,iQ5Q-]AI@X;hPWlH;j\J4ubFRpGNOFgH5k%^Z/
AcXg5$s&@O6\MRf,C@5"!+b9%$Xn[$l@&"V=+ql$/!9S#n.EL3d6XT0.#\,k.IP,fC['a>72
Xb`9lJKET!q',Et2CXo$n)gF,f^;STaF(&s[^(eaDg\"ta`TejU;Gf7+d#TS&mb^.F@jAOW3
t-/_3>hW1W<MG,3@0b)\Uin</5qLb%#K;-&)3Xce6!YT^3PhY3K15"_XJ:#k2>r,m\d]AX6q*
G_$8r1/9:@:QTI.'_J)OMPb!8u1A8,hp7AD6>P_'/WOU.5r]AVMQeG;F#B%'Gh@%7%@ApK]Ak7
L1Wr\L[(SLom?>TXs!fGbO-?_$EhM?#(M!4hl<Sc6YCI&GGKA\"C6stM02`2`DRFXW+,LKf4
phBJ9faDXY#Vh4VFCSN'H$"d)og`T.4^,4Mr=kp@`K9Z-`7\999uLuD$0',n34:+,6_kBLi-
!$5PrrnX1c/KoHlcNW_@]AqH>VmGM_RoH=``5<LT(pV1ODFPHh1isU!qCY>QoQAJ5fPEn#2IQ
fk!IJ)rP@@">J5(..OU8o["9Z5P;.1OioqcP<6GrUM<=t'DsO2&O_4g5T$VJB]AauufWTd+<Z
IrAD-]A0]AG3TQn&IQ[u*8I>9K`f:P>*kAa9:3qVnZ5*ub/4tUe?i)O6]Aa/oWJ+DI%DZat:g.#
Dg]AsusoQX2E3IO$k.VZqd.4c8_u/@\j>=:fkc=D*nU%3aiYe-@2TU"nrj>(eS5:T-b-SG3GW
$VimHX#s;J2?m47fEMoad^<,@-om?TP6,tZ(l,'W>"[N:Fi>g4"jGfD7upSOn(Ta\OohsjhX
?g,"3ff[105(@2ktlMpTgk6i?5K!>3KI`mr/'?S0;2l<0:b5BRi@C7cG95#S3sC%I16++3hR
13ZL^8`]AjW`UHl"<)4DW1'CjjUpnf+2SXOGa!@n6pq2-O\?Bl8PnMeOASYWHDo3Z,bXLngo3
q<k/P&jsIjg,Of5i'fL*+q]AlYVNI)!Ee3(]A=b0[j8Br#Gg/9=8dXg"0OQa@!=n,B_f=rGaWX
9?/"+$)*CC`bFV2#+9oj/C+$!!gc`L&O)!"h,aJN*,b&MD0i6IUd&Fj\B+b=n%)&GO!S/'9:
)KT_>!#<$-p9h1q$R,L+-A&IUe9@6*L82[*0jF(*!.h?ZC3Y%_J.HjuoO(6IC$YqL%\Q,05V
7_Ya!0_YO>FkhTuU;r)PUk9*r9c$DAcHcGe(eG@0o..:,bsK,q;)N&+s4\Ho^D+O9l?V*LQA
cQ#!lWJbIXSLFFEuqQ>IT`n8mZB$sLdF<=!"0$i8mqRXH]A'<`95m.3^5AD&f1\!\utP?en>E
[2_;G_Bhs#^Z)79S5D=&sF+?",g%ko#=JHYQtqjHbo/<+oc[^D:sq;.HLJ:cnsH074XKE4?Q
#tQk5:Vi.6@_?5fXdi+Hn&]A3NYdXN<IUKH"NOe2DkEJUodDg35g4oDtf6g4Q[Z5SQY%*k?'3
rmG#+'^2.i2,i2Gg?=G,;NM*aWCu-h53+!!@\Ji"KKoDu09qPa@Y;rep"j`so44LIS**Ed*4
6aOYY,<g-$msA`C2$N"c9eJ,d-j6.Om4l7=?Q\.<26EB9\D-Vr#=lBWieGH@\dQ)S3er+D?<
Em(\T7lhK[1Dqe*$#BUR)^DG3'^nG2foB>MU1<?L:im&R$l[]AeoC"#V!78OFjXDU@r7bi@V8
6V:\X9i+'r`7JX5a,^G`YYT4`+-ASVUn\5kCh1RlUVCsTeD]AWp/..s_R^>?pJfV==b91M*rl
f/IRSHbWLXLE+i!?JJO>r&)g,uMLKN5<)\>2YR4=Ptoa&phIMo^beRY#&mbnKPilO=S66/-1
!I7BX-RC(j2<4JeQMV$A?n_"u7k9@9UMT(b[.431oOhMjC@(0F"@.TV5H&=("pj\0SgMcNG_
/dR[fTo[hImS>1('29CE%rKrK1'fBe`+Up\DMF^"fFH/K4LPo(XGK<e2b9S+tI;IJTt!e1/q
A3q&7_L9DNoaq'fe2#K<$jg;RrAhSZ&rr~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="373" height="48"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0"/>
<Widget widgetName="report1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1440" absoluteResolutionScaleH="900"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="570"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="570"/>
<ResolutionScalingAttr percent="1.0"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="4"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="ceca87f6-b1df-4e34-9356-462b97594213"/>
</TemplateIdAttMark>
</Form>
