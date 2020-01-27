[CmdletBinding(SupportsShouldProcess = $true)]
param(
	$Registry = "",
	$InstallSourcePath = "",
	$tags = "*solrcloud*1809",
	$IncludeExperimental = $false
)

Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -RequiredVersion 1.0.0 -Force

if ([string]::IsNullOrEmpty($InstallSourcePath))
{
    $InstallSourcePath = (Join-Path -Path $PSScriptRoot -ChildPath "\packages")
}

SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -InstallSourcePath $InstallSourcePath `
    -Registry $Registry `
    -Tags $tags `
    -ExperimentalTagBehavior:(@{$true = "Include"; $false = "Skip" }[$IncludeExperimental -eq $true]) `
    -WhatIf:$WhatIfPreference