param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$pagePath = Join-Path $RepositoryRoot 'src/Pages/Pag52358.AppraisalCardReview.al'
$processPath = Join-Path $RepositoryRoot 'src/CodeUnit/Cod52395.AppraisalProcessMgt.al'
$appPath = Join-Path $RepositoryRoot 'app.json'

$page = Get-Content -LiteralPath $pagePath -Raw
$process = Get-Content -LiteralPath $processPath -Raw
$app = Get-Content -LiteralPath $appPath -Raw
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

$agreementGroup = [regex]::Match($page, '(?s)group\("Do We Agree\?"\).*?part\(Control8').Value
Assert-Contains $agreementGroup 'field\("Appraisee Agreed"' 'The review card must expose Appraisee Agreed.'
Assert-Contains $agreementGroup 'field\("Appraiser Agreed"' 'The review card must expose Appraiser Agreed.'
Assert-NotContains $agreementGroup 'Visible\s*=\s*FinalVisible' 'The agreement fields must not be limited to the final review period.'
Assert-Contains $agreementGroup 'Editable\s*=\s*ReviewActionsEnabled' 'Agreement fields must only be editable while the appraisal is under review.'

Assert-Contains $process 'EmployeeAppraisal\."Appraisee Agreed"\s*:=\s*false' 'Moving to a new period must reset Appraisee Agreed.'
Assert-Contains $process 'EmployeeAppraisal\."Appraiser Agreed"\s*:=\s*false' 'Moving to a new period must reset Appraiser Agreed.'
Assert-Contains $process 'Commit\(\);\s*if not TrySendNextReviewPeriodNotification' 'The new period must be committed before attempting email notification.'
Assert-Contains $process '\[TryFunction\]\s*local procedure TrySendNextReviewPeriodNotification' 'Email notification must be best-effort and must not roll back the period transition.'
Assert-Contains $process 'Employee\."Company E-Mail"' 'The notification must prefer the employee company email.'
Assert-Contains $process 'Employee\."E-Mail"' 'The notification must fall back to the employee personal email.'
Assert-Contains $process 'Email\.Send\(EmailMessage, Enum::"Email Scenario"::Default\)' 'The notification must use the standard Business Central email framework.'

Assert-Contains $app '"version"\s*:\s*"1\.0\.1\.900"' 'This change must not bump the extension version.'

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host 'Appraisal period transition checks passed.'
