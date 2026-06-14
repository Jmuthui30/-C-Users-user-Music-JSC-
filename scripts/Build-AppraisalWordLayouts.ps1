$ErrorActionPreference = 'Stop'

$wdCollapseEnd = 0
$wdContentControlText = 1
$wdContentControlRepeatingSection = 9
$wdAlignParagraphLeft = 0
$wdAlignParagraphCenter = 1
$wdAlignParagraphRight = 2
$wdAlignVerticalCenter = 1
$wdOrientPortrait = 0
$wdOrientLandscape = 1
$wdPaperLetter = 2
$wdAutoFitFixed = 0
$wdBorderBottom = -3
$wdLineStyleSingle = 1
$wdLineWidth150pt = 12
$wdFormatDocumentDefault = 16

$Green = '0B6E3E'
$DarkGreen = '07532F'
$Gold = 'C68A14'
$LightGreen = 'EAF3EE'
$LightGold = 'F7F1DF'
$LightGray = 'F2F4F5'
$MidGray = 'D4D9DC'
$DarkGray = '4D565C'
$White = 'FFFFFF'

function ConvertTo-WordColor {
    param([Parameter(Mandatory)][string]$Hex)

    $clean = $Hex.TrimStart('#')
    $red = [Convert]::ToInt32($clean.Substring(0, 2), 16)
    $green = [Convert]::ToInt32($clean.Substring(2, 2), 16)
    $blue = [Convert]::ToInt32($clean.Substring(4, 2), 16)
    return $red + ($green * 256) + ($blue * 65536)
}

function Get-ReportXml {
    param(
        [Parameter(Mandatory)][string]$DocxPath,
        [string[]]$AdditionalGoalFields = @()
    )

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [System.IO.Compression.ZipFile]::OpenRead((Resolve-Path $DocxPath))
    try {
        $entry = $archive.Entries |
            Where-Object { $_.FullName -match '^customXml/item\d+\.xml$' } |
            Select-Object -First 1
        if (-not $entry) {
            throw "No Business Central custom XML part was found in $DocxPath."
        }

        $reader = [System.IO.StreamReader]::new($entry.Open())
        try {
            [xml]$xml = $reader.ReadToEnd()
        }
        finally {
            $reader.Dispose()
        }
    }
    finally {
        $archive.Dispose()
    }

    if ($AdditionalGoalFields.Count -gt 0) {
        $namespace = $xml.DocumentElement.NamespaceURI
        $manager = [System.Xml.XmlNamespaceManager]::new($xml.NameTable)
        $manager.AddNamespace('n', $namespace)
        $goals = $xml.SelectSingleNode('//n:Goals', $manager)
        if (-not $goals) {
            throw "The Goals data item was not found in $DocxPath."
        }

        foreach ($fieldName in $AdditionalGoalFields) {
            if (-not $goals.SelectSingleNode("n:$fieldName", $manager)) {
                $element = $xml.CreateElement($fieldName, $namespace)
                $element.InnerText = $fieldName
                [void]$goals.AppendChild($element)
            }
        }
    }

    return [pscustomobject]@{
        Xml = $xml.OuterXml
        Namespace = $xml.DocumentElement.NamespaceURI
    }
}

function Set-DocumentDefaults {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)][ValidateSet('Portrait', 'Landscape')][string]$Orientation
    )

    $section = $Document.Sections.Item(1)
    $section.PageSetup.PaperSize = $wdPaperLetter
    $section.PageSetup.Orientation = if ($Orientation -eq 'Landscape') { $wdOrientLandscape } else { $wdOrientPortrait }
    $margin = if ($Orientation -eq 'Landscape') { 39.6 } else { 57.6 }
    $section.PageSetup.TopMargin = $margin
    $section.PageSetup.BottomMargin = $margin
    $section.PageSetup.LeftMargin = $margin
    $section.PageSetup.RightMargin = $margin
    $section.PageSetup.HeaderDistance = 28.8
    $section.PageSetup.FooterDistance = 28.8

    $normal = $Document.Styles.Item('Normal')
    $normal.Font.Name = 'Aptos'
    $normal.Font.Size = 9
    $normal.Font.Color = ConvertTo-WordColor $DarkGray
    $normal.ParagraphFormat.SpaceAfter = 4
    $normal.ParagraphFormat.LineSpacingRule = 0
}

function Get-EndRange {
    param([Parameter(Mandatory)]$Document)

    return $Document.Range($Document.Content.End - 1, $Document.Content.End - 1)
}

function Add-Paragraph {
    param(
        [Parameter(Mandatory)]$Document,
        [string]$Text = '',
        [double]$Size = 9,
        [bool]$Bold = $false,
        [string]$Color = '4D565C',
        [int]$Alignment = 0,
        [double]$SpaceBefore = 0,
        [double]$SpaceAfter = 4,
        [switch]$KeepWithNext,
        [switch]$GoldRule
    )

    $range = Get-EndRange $Document
    $start = $range.Start
    $range.InsertAfter($Text + "`r")
    $paragraph = $Document.Range($start, $start + $Text.Length + 1).Paragraphs.Item(1)
    $paragraph.Range.Font.Name = 'Aptos'
    $paragraph.Range.Font.Size = $Size
    $paragraph.Range.Font.Bold = if ($Bold) { 1 } else { 0 }
    $paragraph.Range.Font.Color = ConvertTo-WordColor $Color
    $paragraph.Format.Alignment = $Alignment
    $paragraph.Format.SpaceBefore = $SpaceBefore
    $paragraph.Format.SpaceAfter = $SpaceAfter
    $paragraph.Format.KeepWithNext = if ($KeepWithNext) { -1 } else { 0 }

    if ($GoldRule) {
        $border = $paragraph.Borders.Item($wdBorderBottom)
        $border.LineStyle = $wdLineStyleSingle
        $border.LineWidth = $wdLineWidth150pt
        $border.Color = ConvertTo-WordColor $Gold
    }

    return $paragraph
}

function Add-SectionHeading {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)][string]$Text
    )

    [void](Add-Paragraph -Document $Document -Text $Text.ToUpperInvariant() -Size 10.5 -Bold $true -Color $DarkGreen -SpaceBefore 10 -SpaceAfter 5 -KeepWithNext)
}

function Set-CellAppearance {
    param(
        [Parameter(Mandatory)]$Cell,
        [string]$Fill = 'FFFFFF',
        [string]$FontColor = '4D565C',
        [double]$FontSize = 8.5,
        [bool]$Bold = $false,
        [int]$Alignment = 0
    )

    $Cell.Shading.BackgroundPatternColor = ConvertTo-WordColor $Fill
    $Cell.VerticalAlignment = $wdAlignVerticalCenter
    $Cell.Range.Font.Name = 'Aptos'
    $Cell.Range.Font.Size = $FontSize
    $Cell.Range.Font.Bold = if ($Bold) { 1 } else { 0 }
    $Cell.Range.Font.Color = ConvertTo-WordColor $FontColor
    $Cell.Range.ParagraphFormat.Alignment = $Alignment
    $Cell.Range.ParagraphFormat.SpaceAfter = 0
}

function Set-StaticCell {
    param(
        [Parameter(Mandatory)]$Cell,
        [Parameter(Mandatory)][string]$Text,
        [string]$Fill = 'FFFFFF',
        [string]$FontColor = '4D565C',
        [double]$FontSize = 8.5,
        [bool]$Bold = $false,
        [int]$Alignment = 0
    )

    $Cell.Range.Text = $Text
    Set-CellAppearance -Cell $Cell -Fill $Fill -FontColor $FontColor -FontSize $FontSize -Bold $Bold -Alignment $Alignment
}

function Add-BoundControl {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)]$Part,
        [Parameter(Mandatory)]$Range,
        [Parameter(Mandatory)][string]$XPath,
        [Parameter(Mandatory)][string]$Name,
        [double]$FontSize = 8.5,
        [bool]$Bold = $false,
        [string]$Color = '4D565C',
        [int]$Alignment = 0,
        [switch]$MultiLine
    )

    $node = $Part.SelectSingleNode($XPath)
    if (-not $node) {
        throw "XML node not found for $Name at $XPath."
    }

    $Range.Text = $Name
    $control = $Document.ContentControls.Add($wdContentControlText, $Range)
    $control.Title = $Name
    $control.Tag = $Name
    if (-not $control.XMLMapping.SetMappingByNode($node)) {
        throw "Could not map $Name at $XPath."
    }
    if ($MultiLine) {
        $control.MultiLine = $true
    }
    $control.Range.Font.Name = 'Aptos'
    $control.Range.Font.Size = $FontSize
    $control.Range.Font.Bold = if ($Bold) { 1 } else { 0 }
    $control.Range.Font.Color = ConvertTo-WordColor $Color
    $control.Range.ParagraphFormat.Alignment = $Alignment
    $control.Range.ParagraphFormat.SpaceAfter = 0
    return $control
}

function Add-BoundCell {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)]$Part,
        [Parameter(Mandatory)]$Cell,
        [Parameter(Mandatory)][string]$XPath,
        [Parameter(Mandatory)][string]$Name,
        [double]$FontSize = 8.5,
        [bool]$Bold = $false,
        [string]$Fill = 'FFFFFF',
        [string]$Color = '4D565C',
        [int]$Alignment = 0,
        [switch]$MultiLine
    )

    $range = $Cell.Range.Duplicate
    $range.End = $range.End - 1
    $control = Add-BoundControl -Document $Document -Part $Part -Range $range -XPath $XPath -Name $Name -FontSize $FontSize -Bold $Bold -Color $Color -Alignment $Alignment -MultiLine:$MultiLine
    Set-CellAppearance -Cell $Cell -Fill $Fill -FontColor $Color -FontSize $FontSize -Bold $Bold -Alignment $Alignment
    return $control
}

function Add-Table {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)][int]$Rows,
        [Parameter(Mandatory)][int]$Columns,
        [Parameter(Mandatory)][double[]]$Widths
    )

    $range = Get-EndRange $Document
    $table = $Document.Tables.Add($range, $Rows, $Columns)
    $table.AllowAutoFit = $false
    $table.AutoFitBehavior($wdAutoFitFixed)
    $table.Borders.Enable = 1
    $table.Borders.InsideColor = ConvertTo-WordColor $MidGray
    $table.Borders.OutsideColor = ConvertTo-WordColor $MidGray
    $table.TopPadding = 4
    $table.BottomPadding = 4
    $table.LeftPadding = 5
    $table.RightPadding = 5
    $table.Rows.AllowBreakAcrossPages = 0

    for ($index = 0; $index -lt $Widths.Count; $index++) {
        $table.Columns.Item($index + 1).SetWidth($Widths[$index], 0)
    }

    $table.Range.InsertParagraphAfter()
    return $table
}

function Add-MetadataTable {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)]$Part,
        [Parameter(Mandatory)][object[]]$Rows,
        [Parameter(Mandatory)][string]$RootPath,
        [Parameter(Mandatory)][double]$TotalWidth
    )

    $labelWidth = $TotalWidth * 0.15
    $valueWidth = $TotalWidth * 0.35
    $table = Add-Table -Document $Document -Rows $Rows.Count -Columns 4 -Widths @($labelWidth, $valueWidth, $labelWidth, $valueWidth)

    for ($rowIndex = 0; $rowIndex -lt $Rows.Count; $rowIndex++) {
        $row = $Rows[$rowIndex]
        Set-StaticCell -Cell $table.Cell($rowIndex + 1, 1) -Text $row.LeftLabel -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $Document -Part $Part -Cell $table.Cell($rowIndex + 1, 2) -XPath "$RootPath/ns0:$($row.LeftField)" -Name $row.LeftField)
        Set-StaticCell -Cell $table.Cell($rowIndex + 1, 3) -Text $row.RightLabel -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $Document -Part $Part -Cell $table.Cell($rowIndex + 1, 4) -XPath "$RootPath/ns0:$($row.RightField)" -Name $row.RightField)
    }

    return $table
}

function Add-RepeatingTable {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)]$Part,
        [Parameter(Mandatory)][string]$RootPath,
        [Parameter(Mandatory)][string]$DataItem,
        [Parameter(Mandatory)][object[]]$Columns,
        [string]$HeaderFill = '07532F'
    )

    $widths = @($Columns | ForEach-Object { [double]$_.Width })
    $table = Add-Table -Document $Document -Rows 2 -Columns $Columns.Count -Widths $widths
    $table.Rows.Item(1).HeadingFormat = -1

    for ($columnIndex = 0; $columnIndex -lt $Columns.Count; $columnIndex++) {
        $column = $Columns[$columnIndex]
        Set-StaticCell -Cell $table.Cell(1, $columnIndex + 1) -Text $column.Label -Fill $HeaderFill -FontColor $White -FontSize 8 -Bold $true -Alignment $column.Alignment
    }

    for ($columnIndex = 0; $columnIndex -lt $Columns.Count; $columnIndex++) {
        $column = $Columns[$columnIndex]
        [void](Add-BoundCell -Document $Document -Part $Part -Cell $table.Cell(2, $columnIndex + 1) -XPath "$RootPath/ns0:$DataItem/ns0:$($column.Field)" -Name $column.Field -FontSize 8 -Alignment $column.Alignment -MultiLine:$column.MultiLine)
    }

    # Word preserves nested field controls only when the row is wrapped after
    # the field controls have been created and mapped.
    $rowRange = $table.Rows.Item(2).Range.Duplicate
    $repeat = $Document.ContentControls.Add($wdContentControlRepeatingSection, $rowRange)
    $repeat.Title = $DataItem
    $repeat.Tag = $DataItem
    $dataNode = $Part.SelectSingleNode("$RootPath/ns0:$DataItem")
    if (-not $dataNode) {
        throw "Data item $DataItem was not found at $RootPath."
    }
    if (-not $repeat.XMLMapping.SetMappingByNode($dataNode)) {
        throw "Could not map repeating data item $DataItem."
    }

    return $table
}

function Add-ReportHeader {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)]$Part,
        [Parameter(Mandatory)][string]$RootPath,
        [Parameter(Mandatory)][string]$CompanyField,
        [Parameter(Mandatory)][string]$Title
    )

    $companyParagraph = Add-Paragraph -Document $Document -Text $CompanyField -Size 11 -Bold $true -Color $Gold -Alignment $wdAlignParagraphCenter -SpaceAfter 2
    $companyRange = $companyParagraph.Range.Duplicate
    $companyRange.End = $companyRange.End - 1
    [void](Add-BoundControl -Document $Document -Part $Part -Range $companyRange -XPath "$RootPath/ns0:$CompanyField" -Name $CompanyField -FontSize 11 -Bold $true -Color $Gold -Alignment $wdAlignParagraphCenter)

    [void](Add-Paragraph -Document $Document -Text $Title -Size 17 -Bold $true -Color $Green -Alignment $wdAlignParagraphCenter -SpaceAfter 8 -KeepWithNext -GoldRule)
}

function Add-Footer {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)][string]$Text
    )

    $footer = $Document.Sections.Item(1).Footers.Item(1).Range
    $footer.Text = $Text
    $footer.Font.Name = 'Aptos'
    $footer.Font.Size = 8
    $footer.Font.Color = ConvertTo-WordColor $DarkGray
    $footer.ParagraphFormat.Alignment = $wdAlignParagraphCenter
    $footer.Borders.Item($wdBorderBottom).LineStyle = 0
}

function Wrap-RootDataItem {
    param(
        [Parameter(Mandatory)]$Document,
        [Parameter(Mandatory)]$Part,
        [Parameter(Mandatory)][string]$RootPath,
        [Parameter(Mandatory)][string]$DataItem
    )

    $range = $Document.Content.Duplicate
    $range.End = $range.End - 1
    $repeat = $Document.ContentControls.Add($wdContentControlRepeatingSection, $range)
    $repeat.Title = $DataItem
    $repeat.Tag = $DataItem
    $node = $Part.SelectSingleNode($RootPath)
    if (-not $node) {
        throw "Root data item $DataItem was not found at $RootPath."
    }
    if (-not $repeat.XMLMapping.SetMappingByNode($node)) {
        throw "Could not map root data item $DataItem."
    }
}

function New-ObjectivesLayout {
    param($Word, [string]$SourcePath, [string]$OutputPath)

    $reportXml = Get-ReportXml -DocxPath $SourcePath -AdditionalGoalFields @(
        'WorkplanCode_Goals',
        'WorkplanDescription_Goals',
        'PerformanceMeasure_Goals',
        'InitiativeCode_Goals',
        'InitiativeDescription_Goals'
    )
    $document = $Word.Documents.Add()
    try {
        Set-DocumentDefaults -Document $document -Orientation Landscape
        $part = $document.CustomXMLParts.Add($reportXml.Xml)
        $root = '/ns0:NavWordReportXmlPart/ns0:Appraisal'

        Add-ReportHeader -Document $document -Part $part -RootPath $root -CompanyField 'CompName' -Title 'PERFORMANCE OBJECTIVES'
        $metadata = @(
            [pscustomobject]@{ LeftLabel = 'Appraisal No.'; LeftField = 'AppraisalNo_Appraisal'; RightLabel = 'Appraisal Period'; RightField = 'AppraisalPeriod_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Appraisal From'; LeftField = 'PeriodStart_Appraisal'; RightLabel = 'Appraisal To'; RightField = 'PeriodEnd_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Review Period'; LeftField = 'CurrentReviewPeriod'; RightLabel = 'Employee No.'; RightField = 'EmployeeNo_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Review From'; LeftField = 'ReviewStartDate_Appraisal'; RightLabel = 'Review To'; RightField = 'ReviewEndDate_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Appraisee'; LeftField = 'AppraiseeName_Appraisal'; RightLabel = 'Job Title'; RightField = 'AppraiseesJobTitle_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Job Group'; LeftField = 'JobGroup_Appraisal'; RightLabel = 'Directorate'; RightField = 'DirectorateName_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Responsibility Centre'; LeftField = 'UserDept'; RightLabel = 'Appraiser No.'; RightField = 'AppraiserNo_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Appraiser'; LeftField = 'AppraisersName_Appraisal'; RightLabel = 'Appraiser Job Title'; RightField = 'AppraisersJobTitle_Appraisal' }
        )
        [void](Add-MetadataTable -Document $document -Part $part -Rows $metadata -RootPath $root -TotalWidth 712.8)

        Add-SectionHeading -Document $document -Text 'Agreed Performance Objectives'
        $columns = @(
            [pscustomobject]@{ Label = 'Code'; Field = 'WorkplanCode_Goals'; Width = 54; Alignment = 1; MultiLine = $false },
            [pscustomobject]@{ Label = 'Objective'; Field = 'WorkplanDescription_Goals'; Width = 151; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Performance Measure'; Field = 'PerformanceMeasure_Goals'; Width = 108; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Initiative'; Field = 'InitiativeDescription_Goals'; Width = 144; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Target'; Field = 'FY_Target'; Width = 62; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Weight %'; Field = 'Weighting_Goals'; Width = 58; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Due Date'; Field = 'AgreedTargetDate_Goals'; Width = 77; Alignment = 1; MultiLine = $false },
            [pscustomobject]@{ Label = 'Review'; Field = 'ReviewPeriodCode_Goals'; Width = 58; Alignment = 1; MultiLine = $false }
        )
        [void](Add-RepeatingTable -Document $document -Part $part -RootPath $root -DataItem 'Goals' -Columns $columns)

        [void](Add-Paragraph -Document $document -Text 'This report records the agreed objectives and performance measures for the selected review period.' -Size 8 -Color $DarkGray -SpaceBefore 6 -SpaceAfter 0)
        Add-Footer -Document $document -Text 'Confidential - Performance Appraisal Management'
        $document.SaveAs2((Resolve-Path (Split-Path $OutputPath -Parent)).Path + '\' + (Split-Path $OutputPath -Leaf), $wdFormatDocumentDefault)
    }
    finally {
        $document.Close($false)
        [void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($document)
    }
}

function New-AppraisalLayout {
    param($Word, [string]$SourcePath, [string]$OutputPath)

    $reportXml = Get-ReportXml -DocxPath $SourcePath -AdditionalGoalFields @(
        'WorkplanCode_Goals',
        'WorkplanDescription_Goals',
        'PerformanceMeasure_Goals',
        'InitiativeCode_Goals',
        'InitiativeDescription_Goals',
        'Actual_Goals',
        'AchievedPercent_Goals'
    )
    $document = $Word.Documents.Add()
    try {
        Set-DocumentDefaults -Document $document -Orientation Landscape
        $part = $document.CustomXMLParts.Add($reportXml.Xml)
        $root = '/ns0:NavWordReportXmlPart/ns0:Appraisal'

        Add-ReportHeader -Document $document -Part $part -RootPath $root -CompanyField 'CompName' -Title 'PERFORMANCE APPRAISAL REPORT'
        $metadata = @(
            [pscustomobject]@{ LeftLabel = 'Appraisal No.'; LeftField = 'AppraisalNo_Appraisal'; RightLabel = 'Appraisal Period'; RightField = 'AppraisalPeriod_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Appraisal From'; LeftField = 'PeriodStart_Appraisal'; RightLabel = 'Appraisal To'; RightField = 'PeriodEnd_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Review Period'; LeftField = 'CurrentReviewPeriod'; RightLabel = 'Employee No.'; RightField = 'EmployeeNo_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Review From'; LeftField = 'ReviewStartDate_Appraisal'; RightLabel = 'Review To'; RightField = 'ReviewEndDate_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Appraisee'; LeftField = 'AppraiseeName_Appraisal'; RightLabel = 'Job Title'; RightField = 'AppraiseesJobTitle_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Job Group'; LeftField = 'JobGroup_Appraisal'; RightLabel = 'Directorate'; RightField = 'DirectorateName_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Responsibility Centre'; LeftField = 'UserDept'; RightLabel = 'Appraiser No.'; RightField = 'AppraiserNo_Appraisal' },
            [pscustomobject]@{ LeftLabel = 'Appraiser'; LeftField = 'AppraisersName_Appraisal'; RightLabel = 'Appraiser Job Title'; RightField = 'AppraisersJobTitle_Appraisal' }
        )
        [void](Add-MetadataTable -Document $document -Part $part -Rows $metadata -RootPath $root -TotalWidth 712.8)

        Add-SectionHeading -Document $document -Text 'Review Score Summary'
        $scoreTable = Add-Table -Document $document -Rows 1 -Columns 4 -Widths @(111, 160, 111, 160)
        Set-StaticCell -Cell $scoreTable.Cell(1, 1) -Text 'Current Review Score' -Fill $LightGold -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $scoreTable.Cell(1, 2) -XPath "$root/ns0:CurrentReviewScore" -Name 'CurrentReviewScore' -FontSize 10 -Bold $true -Color $DarkGreen -Alignment $wdAlignParagraphRight)
        Set-StaticCell -Cell $scoreTable.Cell(1, 3) -Text 'Cumulative Score' -Fill $LightGold -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $scoreTable.Cell(1, 4) -XPath "$root/ns0:TotalReviewScore" -Name 'TotalReviewScore' -FontSize 10 -Bold $true -Color $DarkGreen -Alignment $wdAlignParagraphRight)

        Add-SectionHeading -Document $document -Text 'Objective Assessment'
        $metricColumns = @(
            [pscustomobject]@{ Label = 'Objective'; Field = 'WorkplanDescription_Goals'; Width = 174; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Performance Measure'; Field = 'PerformanceMeasure_Goals'; Width = 126; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Target'; Field = 'FY_Target'; Width = 58; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Actual'; Field = 'Actual_Goals'; Width = 58; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Achieved %'; Field = 'AchievedPercent_Goals'; Width = 66; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Weight %'; Field = 'Weighting_Goals'; Width = 62; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Self Rating'; Field = 'SelfRating_Goals'; Width = 62; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Appraiser Rating'; Field = 'AppraiserRating_Goals'; Width = 70; Alignment = 2; MultiLine = $false },
            [pscustomobject]@{ Label = 'Score'; Field = 'QuarterScore_Goals'; Width = 56; Alignment = 2; MultiLine = $false }
        )
        [void](Add-RepeatingTable -Document $document -Part $part -RootPath $root -DataItem 'Goals' -Columns $metricColumns)

        Add-SectionHeading -Document $document -Text 'Objective Review Commentary'
        $commentColumns = @(
            [pscustomobject]@{ Label = 'Objective'; Field = 'WorkplanDescription_Goals'; Width = 132; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Appraisee Comments'; Field = 'AppraiseeComments_Goals'; Width = 145; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Appraiser Comments'; Field = 'ResultsAchievedComments_Goals'; Width = 145; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Achievement Notes'; Field = 'AchievementNotes_Goals'; Width = 145; Alignment = 0; MultiLine = $true },
            [pscustomobject]@{ Label = 'Corrective Action'; Field = 'CorrectiveAction_Goals'; Width = 145; Alignment = 0; MultiLine = $true }
        )
        [void](Add-RepeatingTable -Document $document -Part $part -RootPath $root -DataItem 'Goals' -Columns $commentColumns)

        Add-SectionHeading -Document $document -Text 'Overall Review Comments'
        $commentsTable = Add-Table -Document $document -Rows 2 -Columns 2 -Widths @(151, 562)
        Set-StaticCell -Cell $commentsTable.Cell(1, 1) -Text 'Appraisee Comments' -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $commentsTable.Cell(1, 2) -XPath "$root/ns0:AppraiseeCommentsSummaryText" -Name 'AppraiseeCommentsSummaryText' -MultiLine)
        Set-StaticCell -Cell $commentsTable.Cell(2, 1) -Text 'Appraiser Comments' -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $commentsTable.Cell(2, 2) -XPath "$root/ns0:AppraiserCommentsSummaryText" -Name 'AppraiserCommentsSummaryText' -MultiLine)

        Add-SectionHeading -Document $document -Text 'Training and Development Needs'
        $trainingColumns = @(
            [pscustomobject]@{ Label = 'Employee No.'; Field = 'EmployeeNo_TrainingRequest'; Width = 90; Alignment = 1; MultiLine = $false },
            [pscustomobject]@{ Label = 'Development Need'; Field = 'Description_TrainingRequest'; Width = 622; Alignment = 0; MultiLine = $true }
        )
        [void](Add-RepeatingTable -Document $document -Part $part -RootPath $root -DataItem 'Training_Request' -Columns $trainingColumns)

        Add-Footer -Document $document -Text 'Confidential - Performance Appraisal Management'
        $document.SaveAs2((Resolve-Path (Split-Path $OutputPath -Parent)).Path + '\' + (Split-Path $OutputPath -Leaf), $wdFormatDocumentDefault)
    }
    finally {
        $document.Close($false)
        [void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($document)
    }
}

function New-OutcomeLetterLayout {
    param($Word, [string]$SourcePath, [string]$OutputPath)

    $reportXml = Get-ReportXml -DocxPath $SourcePath
    $document = $Word.Documents.Add()
    try {
        Set-DocumentDefaults -Document $document -Orientation Portrait
        $part = $document.CustomXMLParts.Add($reportXml.Xml)
        $root = '/ns0:NavWordReportXmlPart/ns0:AppraisalOutcome'

        $companyParagraph = Add-Paragraph -Document $document -Text 'CompanyName' -Size 15 -Bold $true -Color $Green -Alignment $wdAlignParagraphCenter -SpaceAfter 2
        $companyRange = $companyParagraph.Range.Duplicate
        $companyRange.End = $companyRange.End - 1
        [void](Add-BoundControl -Document $document -Part $part -Range $companyRange -XPath "$root/ns0:CompanyName" -Name 'CompanyName' -FontSize 15 -Bold $true -Color $Green -Alignment $wdAlignParagraphCenter)

        $addressTable = Add-Table -Document $document -Rows 2 -Columns 2 -Widths @(252, 252)
        [void](Add-BoundCell -Document $document -Part $part -Cell $addressTable.Cell(1, 1) -XPath "$root/ns0:CompanyAddress" -Name 'CompanyAddress' -FontSize 8 -Color $DarkGray)
        [void](Add-BoundCell -Document $document -Part $part -Cell $addressTable.Cell(1, 2) -XPath "$root/ns0:CompanyPhone" -Name 'CompanyPhone' -FontSize 8 -Color $DarkGray -Alignment $wdAlignParagraphRight)
        [void](Add-BoundCell -Document $document -Part $part -Cell $addressTable.Cell(2, 1) -XPath "$root/ns0:CompanyCity" -Name 'CompanyCity' -FontSize 8 -Color $DarkGray)
        [void](Add-BoundCell -Document $document -Part $part -Cell $addressTable.Cell(2, 2) -XPath "$root/ns0:CompanyEmail" -Name 'CompanyEmail' -FontSize 8 -Color $DarkGray -Alignment $wdAlignParagraphRight)
        $addressTable.Borders.Enable = 0

        [void](Add-Paragraph -Document $document -Text '' -Size 1 -SpaceAfter 8 -GoldRule)

        $referenceTable = Add-Table -Document $document -Rows 2 -Columns 4 -Widths @(74, 178, 74, 178)
        Set-StaticCell -Cell $referenceTable.Cell(1, 1) -Text 'Reference' -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $referenceTable.Cell(1, 2) -XPath "$root/ns0:AppraisalNo" -Name 'AppraisalNo')
        Set-StaticCell -Cell $referenceTable.Cell(1, 3) -Text 'Date' -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $referenceTable.Cell(1, 4) -XPath "$root/ns0:IssueDate" -Name 'IssueDate' -Alignment $wdAlignParagraphRight)
        Set-StaticCell -Cell $referenceTable.Cell(2, 1) -Text 'Review Period' -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $referenceTable.Cell(2, 2) -XPath "$root/ns0:ReviewPeriodCode" -Name 'ReviewPeriodCode')
        Set-StaticCell -Cell $referenceTable.Cell(2, 3) -Text 'Outcome' -Fill $LightGreen -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $referenceTable.Cell(2, 4) -XPath "$root/ns0:OutcomeType" -Name 'OutcomeType')

        [void](Add-Paragraph -Document $document -Text '' -Size 5 -SpaceAfter 2)
        $recipientTable = Add-Table -Document $document -Rows 3 -Columns 2 -Widths @(108, 396)
        Set-StaticCell -Cell $recipientTable.Cell(1, 1) -Text 'To' -Fill $White -FontColor $DarkGray -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $recipientTable.Cell(1, 2) -XPath "$root/ns0:EmployeeName" -Name 'EmployeeName' -Bold $true)
        Set-StaticCell -Cell $recipientTable.Cell(2, 1) -Text 'Employee No.' -Fill $White -FontColor $DarkGray -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $recipientTable.Cell(2, 2) -XPath "$root/ns0:EmployeeNo" -Name 'EmployeeNo')
        Set-StaticCell -Cell $recipientTable.Cell(3, 1) -Text 'Designation' -Fill $White -FontColor $DarkGray -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $recipientTable.Cell(3, 2) -XPath "$root/ns0:JobTitle" -Name 'JobTitle')
        $recipientTable.Borders.Enable = 0

        $subjectParagraph = Add-Paragraph -Document $document -Text 'Subject' -Size 11 -Bold $true -Color $DarkGreen -SpaceBefore 10 -SpaceAfter 8 -KeepWithNext
        $subjectRange = $subjectParagraph.Range.Duplicate
        $subjectRange.End = $subjectRange.End - 1
        [void](Add-BoundControl -Document $document -Part $part -Range $subjectRange -XPath "$root/ns0:Subject" -Name 'Subject' -FontSize 11 -Bold $true -Color $DarkGreen)

        $bodyParagraph = Add-Paragraph -Document $document -Text 'LetterBody' -Size 10 -Color $DarkGray -SpaceAfter 12
        $bodyRange = $bodyParagraph.Range.Duplicate
        $bodyRange.End = $bodyRange.End - 1
        [void](Add-BoundControl -Document $document -Part $part -Range $bodyRange -XPath "$root/ns0:LetterBody" -Name 'LetterBody' -FontSize 10 -Color $DarkGray -MultiLine)
        $bodyParagraph.Format.LineSpacingRule = 0

        Add-SectionHeading -Document $document -Text 'Appraisal Reference'
        $summary = Add-Table -Document $document -Rows 2 -Columns 4 -Widths @(90, 162, 90, 162)
        Set-StaticCell -Cell $summary.Cell(1, 1) -Text 'Appraisal Period' -Fill $LightGold -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $summary.Cell(1, 2) -XPath "$root/ns0:AppraisalPeriod" -Name 'AppraisalPeriod')
        Set-StaticCell -Cell $summary.Cell(1, 3) -Text 'Department' -Fill $LightGold -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $summary.Cell(1, 4) -XPath "$root/ns0:DepartmentCode" -Name 'DepartmentCode')
        Set-StaticCell -Cell $summary.Cell(2, 1) -Text 'Rating' -Fill $LightGold -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $summary.Cell(2, 2) -XPath "$root/ns0:Rating" -Name 'Rating')
        Set-StaticCell -Cell $summary.Cell(2, 3) -Text 'Grade' -Fill $LightGold -FontColor $DarkGreen -Bold $true
        [void](Add-BoundCell -Document $document -Part $part -Cell $summary.Cell(2, 4) -XPath "$root/ns0:Grade" -Name 'Grade')

        [void](Add-Paragraph -Document $document -Text 'Yours faithfully,' -Size 10 -SpaceBefore 16 -SpaceAfter 18)
        $issuerParagraph = Add-Paragraph -Document $document -Text 'IssuedBy' -Size 10 -Bold $true -Color $DarkGreen -SpaceAfter 1
        $issuerRange = $issuerParagraph.Range.Duplicate
        $issuerRange.End = $issuerRange.End - 1
        [void](Add-BoundControl -Document $document -Part $part -Range $issuerRange -XPath "$root/ns0:IssuedBy" -Name 'IssuedBy' -FontSize 10 -Bold $true -Color $DarkGreen)
        [void](Add-Paragraph -Document $document -Text 'For: Human Resource Management' -Size 9 -Color $DarkGray -SpaceAfter 0)

        Add-Footer -Document $document -Text 'Official Performance Appraisal Correspondence'
        Wrap-RootDataItem -Document $document -Part $part -RootPath $root -DataItem 'AppraisalOutcome'
        $document.SaveAs2((Resolve-Path (Split-Path $OutputPath -Parent)).Path + '\' + (Split-Path $OutputPath -Leaf), $wdFormatDocumentDefault)
    }
    finally {
        $document.Close($false)
        [void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($document)
    }
}

$repoRoot = Split-Path $PSScriptRoot -Parent
$layoutDirectory = Join-Path $repoRoot 'src\report_layout'
$objectivesPath = Join-Path $layoutDirectory 'EmployeeObjectivesNew.docx'
$appraisalPath = Join-Path $layoutDirectory 'EmployeeAppraisalNew.docx'
$outcomePath = Join-Path $layoutDirectory 'AppraisalOutcomeLetter.docx'

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    New-ObjectivesLayout -Word $word -SourcePath $objectivesPath -OutputPath $objectivesPath
    New-AppraisalLayout -Word $word -SourcePath $appraisalPath -OutputPath $appraisalPath
    New-OutcomeLetterLayout -Word $word -SourcePath $outcomePath -OutputPath $outcomePath
}
finally {
    $word.Quit()
    [void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($word)
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}

Write-Output 'Rebuilt appraisal Word layouts:'
Write-Output $objectivesPath
Write-Output $appraisalPath
Write-Output $outcomePath
