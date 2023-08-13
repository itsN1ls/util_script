# Menus

function Show-CustomMenu
{
    param (
        [string]$menuname = 'Select an option'
    )

    Clear-Host
    Write-Host -NoNewline -ForegroundColor Yellow "1: "
    Write-Host "Download Stuff"
    Write-Host -NoNewline -ForegroundColor Yellow "2: "
    Write-Host "Optimization Stuff"
    # Write-Host -NoNewline -ForegroundColor Yellow "3: "
    # Write-Host "Submenu 2"
    # Write-Host -NoNewline -ForegroundColor Yellow "4: "
    # Write-Host "Submenu 3"
    Write-Host -NoNewline -ForegroundColor Yellow "Q: "
    Write-Host "Exit"
    Write-Host ""
    Write-host ""
}

function Show-DownloadMenu
{
    Clear-Host
    Write-Host -NoNewline -ForegroundColor Yellow "1: "
    Write-Host "Drivers"
    Write-Host -NoNewline -ForegroundColor Yellow "2: "
    Write-Host "Software"
    # Write-Host -NoNewline -ForegroundColor Yellow "3: "
    # Write-Host "idk yet"
    # Write-Host -NoNewline -ForegroundColor Yellow "4: "
    # Write-Host "idk yet"
    Write-Host -NoNewline -ForegroundColor Yellow "B: "
    Write-Host "Back to Main Menu"

}


function Show-DriverDownloadMenu
{
    Clear-Host
    Write-Host -NoNewline -ForegroundColor Yellow "1: "
    Write-Host "Audio"
    Write-Host -NoNewline -ForegroundColor Yellow "2: "
    Write-Host "Graphics"
    Write-Host -NoNewline -ForegroundColor Yellow "B: "
    Write-Host "Back to Main Menu"

 

}
function Show-OptimizationMenu
{

    Clear-Host
    Write-Host -NoNewline -ForegroundColor Yellow "1: "
    Write-Host "Registry Stuff"
    Write-Host -NoNewline -ForegroundColor Yellow "2: "
    Write-Host "Delete Temporary Files"
    Write-Host -NoNewline -ForegroundColor Yellow "B: "
    Write-Host "Back to Main Menu"
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
                    '1' { 'Downloading something (download 1)' }
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
