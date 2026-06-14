param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$reportPath = Join-Path $RepositoryRoot 'src/Reports/Rep52392.EmployeeAppraisalScorecard.al'
$layoutPath = Join-Path $RepositoryRoot 'src/report_layout/EmployeeAppraisalScorecard.rdl'

$report = Get-Content -LiteralPath $reportPath -Raw
$layout = Get-Content -LiteralPath $layoutPath -Raw

$failures = [System.Collections.Generic.List[string]]::new()

function Assert-Contains {
    param([string]$Content, [string]$Pattern, [string]$Message)

    if ($Content -notmatch $Pattern) {
        $failures.Add($Message)
    }
}

function Assert-NotContains {
    param([string]$Content, [string]$Pattern, [string]$Message)

    if ($Content -match $Pattern) {
        $failures.Add($Message)
    }
}

Assert-Contains $report 'SetRange\("Appraisal Line Type",\s*"Appraisal Line Type"::Objective\)' 'The scorecard dataset must exclude heading and subheading appraisal lines.'
Assert-Contains $report 'column\(CurrentReviewWeighting;' 'The scorecard dataset must expose weighting for the current review period.'
Assert-Contains $report 'column\(AppraiseeReviewComments;' 'The scorecard dataset must expose quarter-specific appraisee comments.'
Assert-Contains $report 'column\(AppraiserReviewComments;' 'The scorecard dataset must expose quarter-specific appraiser comments.'

Assert-Contains $layout 'QUARTERLY PERFORMANCE SCORECARD' 'The layout must identify itself as a quarterly performance scorecard.'
Assert-Contains $layout 'Fields!CurrentReviewPeriod\.Value' 'The layout must display the active review period.'
Assert-Contains $layout 'Fields!ReviewStartDate_Appraisal\.Value' 'The layout must display the review start date.'
Assert-Contains $layout 'Fields!ReviewEndDate_Appraisal\.Value' 'The layout must display the review end date.'
Assert-Contains $layout 'Fields!ActualValue\.Value' 'The layout must display actual performance.'
Assert-Contains $layout 'Fields!SelfRating_Goals\.Value' 'The layout must display the appraisee self-rating.'
Assert-Contains $layout 'Fields!AppraiserRating_Goals\.Value' 'The layout must display the appraiser rating.'
Assert-Contains $layout 'Fields!QuarterScore_Goals\.Value' 'The layout must display the calculated quarter score.'
Assert-Contains $layout 'Fields!AppraiseeReviewComments\.Value' 'The layout must display quarter-specific appraisee comments.'
Assert-Contains $layout 'Fields!AppraiserReviewComments\.Value' 'The layout must display quarter-specific appraiser comments.'
Assert-Contains $layout '<FilterExpression>=Fields!WorkplanCodeValue\.Value</FilterExpression>' 'The objective tables must exclude non-appraisal-line dataset rows.'
Assert-Contains $layout 'No objectives have been captured for this review period\.' 'The scorecard must explain when the selected quarter has no objectives.'
Assert-NotContains $layout '<Group Name="WorkplanCode2">' 'The quarterly layout must not use the legacy workplan grouping.'
Assert-NotContains $layout 'Fields!WeightedRating\.Value' 'The quarterly layout must not present the ambiguous legacy Weighted Rating field.'

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host 'Appraisal scorecard layout checks passed.'
