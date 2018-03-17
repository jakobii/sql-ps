Import-Module "$PSScriptRoot\New-Row.psm1"

# Dates
new-row -Column 'Some Date' -Value $(Get-Date) -Type 'datetime2'
new-row -Column 'Some Date' -Value $(Get-Date) -Type 'datetime'
new-row -Column 'Some Date' -Value $(Get-Date) -Type 'date'















