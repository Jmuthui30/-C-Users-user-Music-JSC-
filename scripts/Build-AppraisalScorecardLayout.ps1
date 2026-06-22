param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$layoutPath = Join-Path $RepositoryRoot 'src/report_layout/EmployeeAppraisalScorecard.rdl'
[xml]$document = Get-Content -LiteralPath $layoutPath -Raw
$namespace = $document.DocumentElement.NamespaceURI
$namespaceManager = [System.Xml.XmlNamespaceManager]::new($document.NameTable)
$namespaceManager.AddNamespace('r', $namespace)

function New-TextboxXml {
    param(
        [string]$Name,
        [string]$Value,
        [string]$FontSize = '8pt',
        [string]$FontWeight = 'Normal',
        [string]$Color = '#1F2933',
        [string]$BackgroundColor = '',
        [string]$TextAlign = 'Left',
        [string]$VerticalAlign = 'Middle',
        [string]$Format = '',
        [string]$Top = '',
        [string]$Left = '',
        [string]$Height = '',
        [string]$Width = '',
        [switch]$Border,
        [switch]$CanGrow
    )

    $paragraph = @"
<Paragraphs>
  <Paragraph>
    <TextRuns>
      <TextRun>
        <Value>$Value</Value>
        <Style>
          <FontFamily>Segoe UI</FontFamily>
          <FontSize>$FontSize</FontSize>
          <FontWeight>$FontWeight</FontWeight>
          <Color>$Color</Color>
          $(if ($Format) { "<Format>$Format</Format>" })
        </Style>
      </TextRun>
    </TextRuns>
    <Style>
      <TextAlign>$TextAlign</TextAlign>
    </Style>
  </Paragraph>
</Paragraphs>
"@

    $position = ''
    if ($Top) {
        $position = "<Top>$Top</Top><Left>$Left</Left><Height>$Height</Height><Width>$Width</Width>"
    }

    $borderXml = ''
    if ($Border) {
        $borderXml = '<Border><Color>#B8C3BD</Color><Style>Solid</Style><Width>0.5pt</Width></Border>'
    }

    $backgroundXml = ''
    if ($BackgroundColor) {
        $backgroundXml = "<BackgroundColor>$BackgroundColor</BackgroundColor>"
    }

    $grow = if ($CanGrow) { 'true' } else { 'false' }
    return @"
<Textbox Name="$Name">
  <CanGrow>$grow</CanGrow>
  <KeepTogether>true</KeepTogether>
  $paragraph
  $position
  <Style>
    $borderXml
    $backgroundXml
    <VerticalAlign>$VerticalAlign</VerticalAlign>
    <PaddingLeft>3pt</PaddingLeft>
    <PaddingRight>3pt</PaddingRight>
    <PaddingTop>2pt</PaddingTop>
    <PaddingBottom>2pt</PaddingBottom>
  </Style>
</Textbox>
"@
}

function New-CellXml {
    param([string]$TextboxXml)
    return "<TablixCell><CellContents>$TextboxXml</CellContents></TablixCell>"
}

function New-StaticMembersXml {
    param([int]$Count)
    return (1..$Count | ForEach-Object { '<TablixMember />' }) -join ''
}

function New-ColumnDefinitionsXml {
    param([string[]]$Widths)
    return ($Widths | ForEach-Object { "<TablixColumn><Width>$_</Width></TablixColumn>" }) -join ''
}

$fieldsNode = $document.SelectSingleNode("//r:DataSet[@Name='DataSet_Result']/r:Fields", $namespaceManager)
foreach ($fieldName in @('CurrentReviewWeighting', 'AppraiseeReviewComments', 'AppraiserReviewComments')) {
    if (-not $document.SelectSingleNode("//r:DataSet[@Name='DataSet_Result']/r:Fields/r:Field[@Name='$fieldName']", $namespaceManager)) {
        $fieldNode = $document.CreateElement('Field', $namespace)
        $fieldNode.SetAttribute('Name', $fieldName)
        $dataFieldNode = $document.CreateElement('DataField', $namespace)
        $dataFieldNode.InnerText = $fieldName
        [void]$fieldNode.AppendChild($dataFieldNode)
        [void]$fieldsNode.AppendChild($fieldNode)
    }
}

$metadataDefinitions = @(
    @('Appraisal No.', '=First(Fields!AppraisalNo_Appraisal.Value, "DataSet_Result")', 'Appraisal Period', '=First(Fields!AppraisalPeriod_Appraisal.Value, "DataSet_Result")'),
    @('Review Period', '=First(Fields!CurrentReviewPeriod.Value, "DataSet_Result")', 'Review Dates', '=Format(First(Fields!ReviewStartDate_Appraisal.Value, "DataSet_Result"), "dd/MM/yyyy") &amp; " to " &amp; Format(First(Fields!ReviewEndDate_Appraisal.Value, "DataSet_Result"), "dd/MM/yyyy")'),
    @('Appraisee', '=First(Fields!AppraiseeName_Appraisal.Value, "DataSet_Result")', 'Employee No.', '=First(Fields!EmployeeNo_Appraisal.Value, "DataSet_Result")'),
    @('Job Title', '=First(Fields!AppraiseesJobTitle_Appraisal.Value, "DataSet_Result")', 'Job Group', '=First(Fields!JobGroup_Appraisal.Value, "DataSet_Result")'),
    @('Directorate', '=First(Fields!DirectorateName_Appraisal.Value, "DataSet_Result")', 'Responsibility Centre', '=First(Fields!UserDept.Value, "DataSet_Result")'),
    @('Appraiser', '=First(Fields!AppraisersName_Appraisal.Value, "DataSet_Result")', 'Appraiser No.', '=First(Fields!AppraiserNo_Appraisal.Value, "DataSet_Result")'),
    @('Appraiser Job Title', '=First(Fields!AppraisersJobTitle_Appraisal.Value, "DataSet_Result")', 'Document State', '=First(Fields!StatusText.Value, "DataSet_Result") &amp; " / " &amp; First(Fields!AppraisalStatusText.Value, "DataSet_Result")')
)

$metadataRowsXml = ''
$metadataIndex = 0
foreach ($definition in $metadataDefinitions) {
    $metadataIndex++
    $cells = @(
        (New-CellXml (New-TextboxXml -Name "MetaLabel${metadataIndex}A" -Value $definition[0] -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Border)),
        (New-CellXml (New-TextboxXml -Name "MetaValue${metadataIndex}A" -Value $definition[1] -CanGrow -Border)),
        (New-CellXml (New-TextboxXml -Name "MetaLabel${metadataIndex}B" -Value $definition[2] -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Border)),
        (New-CellXml (New-TextboxXml -Name "MetaValue${metadataIndex}B" -Value $definition[3] -CanGrow -Border))
    ) -join ''
    $metadataRowsXml += "<TablixRow><Height>0.62cm</Height><TablixCells>$cells</TablixCells></TablixRow>"
}

$summaryCells = @(
    (New-CellXml (New-TextboxXml -Name 'SummaryLabelWeight' -Value 'Current Review Weighting' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Border)),
    (New-CellXml (New-TextboxXml -Name 'SummaryValueWeight' -Value '=First(Fields!CurrentReviewWeighting.Value, "DataSet_Result")' -FontWeight 'Bold' -TextAlign 'Right' -Format 'N2' -Border)),
    (New-CellXml (New-TextboxXml -Name 'SummaryLabelQuarter' -Value 'Current Quarter Score' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Border)),
    (New-CellXml (New-TextboxXml -Name 'SummaryValueQuarter' -Value '=First(Fields!CurrentReviewScore.Value, "DataSet_Result")' -FontWeight 'Bold' -TextAlign 'Right' -Format 'N2' -Border)),
    (New-CellXml (New-TextboxXml -Name 'SummaryLabelCumulative' -Value 'Cumulative Review Score' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Border)),
    (New-CellXml (New-TextboxXml -Name 'SummaryValueCumulative' -Value '=First(Fields!TotalReviewScore.Value, "DataSet_Result")' -FontWeight 'Bold' -TextAlign 'Right' -Format 'N2' -Border))
) -join ''

$detailHeaders = @('Objective', 'Performance Measure', 'Initiative', 'Target', 'Actual', 'Achieved %', 'Weight %', 'Self Rating', 'Appraiser Rating', 'Quarter Score')
$detailValues = @(
    '=Fields!WorkplanCodeValue.Value &amp; IIF(Fields!WorkplanDescription.Value = "", "", " - " &amp; Fields!WorkplanDescription.Value)',
    '=Fields!PerformanceMeasure.Value &amp; IIF(Fields!Actualtargets.Value = "", "", " - " &amp; Fields!Actualtargets.Value)',
    '=Fields!Initiativecode.Value &amp; IIF(Fields!InitiativeDescription.Value = "", "", " - " &amp; Fields!InitiativeDescription.Value)',
    '=Fields!FY_Target.Value',
    '=Fields!ActualValue.Value',
    '=Fields!Achieved.Value',
    '=Fields!Weighting_Goals.Value',
    '=Fields!SelfRating_Goals.Value',
    '=Fields!AppraiserRating_Goals.Value',
    '=Fields!QuarterScore_Goals.Value'
)
$detailFormats = @('', '', '', 'N2', 'N2', 'N2', 'N2', 'N2', 'N2', 'N2')
$detailHeaderCells = ''
$detailValueCells = ''
for ($index = 0; $index -lt $detailHeaders.Count; $index++) {
    $detailHeaderCells += New-CellXml (New-TextboxXml -Name "DetailHeader$index" -Value $detailHeaders[$index] -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -TextAlign 'Center' -Border -CanGrow)
    $alignment = if ($index -ge 3) { 'Right' } else { 'Left' }
    $detailValueCells += New-CellXml (New-TextboxXml -Name "DetailValue$index" -Value $detailValues[$index] -TextAlign $alignment -Format $detailFormats[$index] -Border -CanGrow)
}

$noteHeaders = @('Objective', 'Appraisee Comments', 'Appraiser Comments', 'Achievement Notes', 'Corrective Action')
$noteValues = @(
    '=Fields!WorkplanCodeValue.Value &amp; IIF(Fields!WorkplanDescription.Value = "", "", " - " &amp; Fields!WorkplanDescription.Value)',
    '=Fields!AppraiseeComments_Goals.Value',
    '=Fields!AppraiserComments_Goals.Value',
    '=Fields!AchievementNotes_Goals.Value',
    '=Fields!CorrectiveAction_Goals.Value'
)
$noteHeaderCells = ''
$noteValueCells = ''
for ($index = 0; $index -lt $noteHeaders.Count; $index++) {
    $noteHeaderCells += New-CellXml (New-TextboxXml -Name "NoteHeader$index" -Value $noteHeaders[$index] -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -TextAlign 'Center' -Border -CanGrow)
    $noteValueCells += New-CellXml (New-TextboxXml -Name "NoteValue$index" -Value $noteValues[$index] -Border -CanGrow)
}

$metadataColumns = New-ColumnDefinitionsXml @('3.3cm', '10.75cm', '3.3cm', '10.75cm')
$summaryColumns = New-ColumnDefinitionsXml @('5cm', '4.366cm', '5cm', '4.367cm', '5cm', '4.367cm')
$detailColumns = New-ColumnDefinitionsXml @('5.3cm', '5.3cm', '4.4cm', '1.8cm', '1.8cm', '1.8cm', '1.8cm', '1.7cm', '2cm', '2.2cm')
$noteColumns = New-ColumnDefinitionsXml @('5cm', '5.8cm', '5.8cm', '5.8cm', '5.7cm')

$bodyXml = @"
<Body xmlns="$namespace">
  <ReportItems>
    <Image Name="CompanyLogo">
      <Source>Database</Source>
      <Value>=First(Fields!CompPic.Value, "DataSet_Result")</Value>
      <MIMEType>image/png</MIMEType>
      <Sizing>FitProportional</Sizing>
      <Top>0cm</Top><Left>0cm</Left><Height>1.7cm</Height><Width>2.4cm</Width>
      <Style />
    </Image>
    $(New-TextboxXml -Name 'CompanyName' -Value '=First(Fields!CompName.Value, "DataSet_Result")' -FontSize '14pt' -FontWeight 'Bold' -Color '#0B6B3A' -Top '0cm' -Left '2.7cm' -Height '0.8cm' -Width '25.4cm')
    $(New-TextboxXml -Name 'ReportTitle' -Value 'QUARTERLY PERFORMANCE SCORECARD' -FontSize '16pt' -FontWeight 'Bold' -Color '#1F2933' -Top '0.8cm' -Left '2.7cm' -Height '0.9cm' -Width '25.4cm')
    $(New-TextboxXml -Name 'ReviewIdentity' -Value '="Appraisal " &amp; First(Fields!AppraisalNo_Appraisal.Value, "DataSet_Result") &amp; " | " &amp; First(Fields!CurrentReviewPeriod.Value, "DataSet_Result")' -FontSize '9pt' -FontWeight 'Bold' -Color '#C69214' -Top '1.65cm' -Left '0cm' -Height '0.55cm' -Width '28.1cm' -TextAlign 'Right')
    <Tablix Name="AppraisalMetadata">
      <TablixBody>
        <TablixColumns>$metadataColumns</TablixColumns>
        <TablixRows>$metadataRowsXml</TablixRows>
      </TablixBody>
      <TablixColumnHierarchy><TablixMembers>$(New-StaticMembersXml 4)</TablixMembers></TablixColumnHierarchy>
      <TablixRowHierarchy><TablixMembers>$(New-StaticMembersXml $metadataDefinitions.Count)</TablixMembers></TablixRowHierarchy>
      <DataSetName>DataSet_Result</DataSetName>
      <Top>2.3cm</Top><Left>0cm</Left><Height>4.34cm</Height><Width>28.1cm</Width>
      <Style />
    </Tablix>
    <Tablix Name="ScoreSummary">
      <TablixBody>
        <TablixColumns>$summaryColumns</TablixColumns>
        <TablixRows><TablixRow><Height>0.78cm</Height><TablixCells>$summaryCells</TablixCells></TablixRow></TablixRows>
      </TablixBody>
      <TablixColumnHierarchy><TablixMembers>$(New-StaticMembersXml 6)</TablixMembers></TablixColumnHierarchy>
      <TablixRowHierarchy><TablixMembers><TablixMember /></TablixMembers></TablixRowHierarchy>
      <DataSetName>DataSet_Result</DataSetName>
      <Top>6.9cm</Top><Left>0cm</Left><Height>0.78cm</Height><Width>28.1cm</Width>
      <Style />
    </Tablix>
    $(New-TextboxXml -Name 'ObjectivesHeading' -Value 'OBJECTIVES AND QUARTERLY SCORING' -FontSize '10pt' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Top '7.95cm' -Left '0cm' -Height '0.65cm' -Width '28.1cm')
    <Tablix Name="QuarterObjectives">
      <TablixBody>
        <TablixColumns>$detailColumns</TablixColumns>
        <TablixRows>
          <TablixRow><Height>0.85cm</Height><TablixCells>$detailHeaderCells</TablixCells></TablixRow>
          <TablixRow><Height>0.75cm</Height><TablixCells>$detailValueCells</TablixCells></TablixRow>
        </TablixRows>
      </TablixBody>
      <TablixColumnHierarchy><TablixMembers>$(New-StaticMembersXml 10)</TablixMembers></TablixColumnHierarchy>
      <TablixRowHierarchy>
        <TablixMembers>
          <TablixMember><KeepWithGroup>After</KeepWithGroup><RepeatOnNewPage>true</RepeatOnNewPage></TablixMember>
          <TablixMember><Group Name="QuarterObjectiveDetails" /></TablixMember>
        </TablixMembers>
      </TablixRowHierarchy>
      <Filters>
        <Filter>
          <FilterExpression>=Fields!WorkplanCodeValue.Value</FilterExpression>
          <Operator>NotEqual</Operator>
          <FilterValues><FilterValue></FilterValue></FilterValues>
        </Filter>
      </Filters>
      <NoRowsMessage>No objectives have been captured for this review period.</NoRowsMessage>
      <DataSetName>DataSet_Result</DataSetName>
      <Top>8.65cm</Top><Left>0cm</Left><Height>1.6cm</Height><Width>28.1cm</Width>
      <Style />
    </Tablix>
    $(New-TextboxXml -Name 'ScoringNote' -Value 'Scoring basis: Quarter Score = Weighting x Appraiser Rating / 5. Achievement is Actual / Target x 100.' -FontSize '8pt' -Color '#4B5563' -BackgroundColor '#F4F7F5' -Top '10.5cm' -Left '0cm' -Height '0.65cm' -Width '28.1cm' -Border -CanGrow)
    $(New-TextboxXml -Name 'NotesHeading' -Value 'OBJECTIVE REVIEW NOTES' -FontSize '10pt' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Top '11.4cm' -Left '0cm' -Height '0.65cm' -Width '28.1cm')
    <Tablix Name="QuarterReviewNotes">
      <TablixBody>
        <TablixColumns>$noteColumns</TablixColumns>
        <TablixRows>
          <TablixRow><Height>0.75cm</Height><TablixCells>$noteHeaderCells</TablixCells></TablixRow>
          <TablixRow><Height>0.75cm</Height><TablixCells>$noteValueCells</TablixCells></TablixRow>
        </TablixRows>
      </TablixBody>
      <TablixColumnHierarchy><TablixMembers>$(New-StaticMembersXml 5)</TablixMembers></TablixColumnHierarchy>
      <TablixRowHierarchy>
        <TablixMembers>
          <TablixMember><KeepWithGroup>After</KeepWithGroup><RepeatOnNewPage>true</RepeatOnNewPage></TablixMember>
          <TablixMember><Group Name="QuarterReviewNoteDetails" /></TablixMember>
        </TablixMembers>
      </TablixRowHierarchy>
      <Filters>
        <Filter>
          <FilterExpression>=Fields!WorkplanCodeValue.Value</FilterExpression>
          <Operator>NotEqual</Operator>
          <FilterValues><FilterValue></FilterValue></FilterValues>
        </Filter>
      </Filters>
      <NoRowsMessage>No objective review notes have been captured for this review period.</NoRowsMessage>
      <DataSetName>DataSet_Result</DataSetName>
      <Top>12.1cm</Top><Left>0cm</Left><Height>1.5cm</Height><Width>28.1cm</Width>
      <Style />
    </Tablix>
    $(New-TextboxXml -Name 'AppraiseeCommentsHeading' -Value 'APPRAISEE REVIEW COMMENTS' -FontSize '10pt' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Top '13.9cm' -Left '0cm' -Height '0.65cm' -Width '28.1cm')
    $(New-TextboxXml -Name 'AppraiseeCommentsText' -Value '=First(Fields!AppraiseeReviewComments.Value, "DataSet_Result")' -FontSize '9pt' -Top '14.6cm' -Left '0cm' -Height '1.1cm' -Width '28.1cm' -Border -CanGrow)
    $(New-TextboxXml -Name 'AppraiserCommentsHeading' -Value 'APPRAISER REVIEW COMMENTS' -FontSize '10pt' -FontWeight 'Bold' -Color '#FFFFFF' -BackgroundColor '#0B6B3A' -Top '15.95cm' -Left '0cm' -Height '0.65cm' -Width '28.1cm')
    $(New-TextboxXml -Name 'AppraiserCommentsText' -Value '=First(Fields!AppraiserReviewComments.Value, "DataSet_Result")' -FontSize '9pt' -Top '16.65cm' -Left '0cm' -Height '1.1cm' -Width '28.1cm' -Border -CanGrow)
  </ReportItems>
  <Height>18cm</Height>
  <Style />
</Body>
"@

$bodyFragment = $document.CreateDocumentFragment()
$bodyFragment.InnerXml = $bodyXml
$reportSection = $document.SelectSingleNode('//r:ReportSection', $namespaceManager)
$oldBody = $reportSection.SelectSingleNode('r:Body', $namespaceManager)
[void]$reportSection.ReplaceChild($bodyFragment.FirstChild, $oldBody)

$widthNode = $reportSection.SelectSingleNode('r:Width', $namespaceManager)
$widthNode.InnerText = '28.1cm'

$pageXml = @"
<Page xmlns="$namespace">
  <PageFooter>
    <Height>0.65cm</Height>
    <PrintOnFirstPage>true</PrintOnFirstPage>
    <PrintOnLastPage>true</PrintOnLastPage>
    <ReportItems>
      $(New-TextboxXml -Name 'FooterConfidential' -Value 'Confidential - Performance Appraisal Management' -FontSize '7pt' -Color '#66736C' -Top '0cm' -Left '0cm' -Height '0.5cm' -Width '22cm')
      $(New-TextboxXml -Name 'FooterPageNumber' -Value '="Page " &amp; Globals!PageNumber &amp; " of " &amp; Globals!TotalPages' -FontSize '7pt' -Color '#66736C' -TextAlign 'Right' -Top '0cm' -Left '22cm' -Height '0.5cm' -Width '6.1cm')
    </ReportItems>
    <Style />
  </PageFooter>
  <PageHeight>21cm</PageHeight>
  <PageWidth>29.7cm</PageWidth>
  <LeftMargin>0.8cm</LeftMargin>
  <RightMargin>0.8cm</RightMargin>
  <TopMargin>0.7cm</TopMargin>
  <BottomMargin>0.7cm</BottomMargin>
  <Style />
</Page>
"@

$pageFragment = $document.CreateDocumentFragment()
$pageFragment.InnerXml = $pageXml
$oldPage = $reportSection.SelectSingleNode('r:Page', $namespaceManager)
[void]$reportSection.ReplaceChild($pageFragment.FirstChild, $oldPage)

$settings = [System.Xml.XmlWriterSettings]::new()
$settings.Indent = $true
$settings.Encoding = [System.Text.UTF8Encoding]::new($false)
$settings.NewLineChars = "`r`n"
$writer = [System.Xml.XmlWriter]::Create($layoutPath, $settings)
try {
    $document.Save($writer)
}
finally {
    $writer.Dispose()
}

Write-Host "Rebuilt $layoutPath"
