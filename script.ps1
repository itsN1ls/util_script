# Menus
function EntrySelection {

    param (
        [string]$key = 'default key',
        [string]$value = 'default value'
    ) 
    Write-Host -NoNewline -ForegroundColor Yellow "${key}"
    Write-Host "$value"

}
function Show-CustomMenu
{
    param (
        [string]$menuname = 'Select an option'
    )

    Clear-Host
    Write-Host -NoNewline "---------------   "
    Write-Host -ForegroundColor Yellow "Main Menu" -NoNewline
    Write-Host "   ---------------"
    EntrySelection -key "1: " -value "Download Stuff"
    EntrySelection -key "2: " -value "Optimization Stuff"
    EntrySelection -key "Q: " -value "Exit"
    Write-Host ""
    Write-Host ""
}

function Show-DownloadMenu
{

    Clear-Host
    Write-Host -NoNewline "---------------   "
    Write-Host -ForegroundColor Yellow "Downloads" -NoNewline
    Write-Host "   ---------------"
    EntrySelection -key "1: " -value "Drivers"
    EntrySelection -key "2: " -value "Software"
    EntrySelection -key "B: " -value "Back to Main Menu"
    Write-Host ""
    Write-Host ""
}


function Show-DriverDownloadMenu
{
    Clear-Host
    Write-Host -NoNewline "---------------   "
    Write-Host -ForegroundColor Yellow "Drivers" -NoNewline
    Write-Host "   ---------------"
    EntrySelection -key "1: " -value "Audio"
    EntrySelection -key "2: " -value "Graphics"
    EntrySelection -key "B: " -value "Back to Download Menu"
    Write-Host ""
    Write-Host ""
 

}
function Show-OptimizationMenu
{

    Clear-Host
    Write-Host -NoNewline "---------------   "
    Write-Host -ForegroundColor Yellow "Optimization" -NoNewline
    Write-Host "   ---------------"
    EntrySelection -key "1: " -value "Registry Stuff"
    EntrySelection -key "2: " -value "Delete Temporary Files"
    EntrySelection -key "B: " -value "Back to Main Menu"
    Write-Host ""
    Write-Host ""
}


# Show main menu
Show-CustomMenu
# Functions that do some stuf

function ClearExit {
    Clear-Host
    exit
}



function CleanTempAndPrefetchFiles {
    Clear-Host
    # Clean current users temporary files
    Get-ChildItem -Path $env:TEMP | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
        } catch {
            
        }
    }
    Write-Host "Deleted User Temp files successfully"
    # Clean system temporary files
    $systemTempPath = "C:\Windows\Temp"
    Get-ChildItem -Path $systemTempPath | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
        } catch {
            
        }
    }
    Write-Host "Deleted System Temp files successfully."
    # Clean prefetch files
    $prefetchPath = "C:\Windows\Prefetch"
    Remove-Item -Path $prefetchPath\* -Force -Recurse
    Write-Host "Deleted Prefetch files successfully"
    Read-Host "Press Enter to return to the optimization menu"
    Clear-Host
    Show-OptimizationMenu
}

do {
    $select = Read-Host "Select an option: "

    switch ($select){
        '1' {
            Show-DownloadMenu
            do {
                $downloadOption = Read-Host "Select a download option"
                switch ($downloadOption) {
                    '1' {Show-DriverDownloadMenu}
                    '2' { 'Downloading something (download 2)' }
                    'q' {ClearExit}
                }
            } while ($downloadOption -ne 'B')
            Show-CustomMenu
        }
        '2' {
            Show-OptimizationMenu
            do {
                $optimizationOption = Read-Host "Select an option"
                switch ($optimizationOption) {
                    '1' { 'Registry Tweaks Menu coming soon.' }
                    '2' {CleanTempAndPrefetchFiles}
                    'q' {ClearExit}
                }
            } while ($optimizationOption -ne 'B')
            Show-CustomMenu
        }
        '3' {
            # Submenu 2 logic
        }
        '4' {
            # Submenu 3 logic
        }
        'q' {
            ClearExit
        }
    }
} while ($true)
