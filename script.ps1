# Menus

function Show-CustomMenu
{
    param (
        [string]$menuname = 'Select an option'
    )

    Clear-Host
    
    Write-Host "1: Download Stuff"
    Write-Host "2: Optimization Stuff"
    # Write-Host "3: Submenu 2"
    # Write-Host "4: Submenu 3"
    Write-Host "Q: Exit"
    Write-Host ""
    Write-host ""
}

function Show-DownloadMenu
{
    Clear-Host

    Write-Host "1: Drivers"
    Write-Host "2: Software"
    # Write-Host "3: idk yet"
    # Write-Host "4: idk yet"
    Write-Host "B: Back to Main Menu"

}

function Show-OptimizationMenu
{

    Clear-Host

    Write-Host "1: Registry Stuff"
    Write-Host "2: Delete Temporary Files"
    Write-Host "B: Back to Main Menu"
}


# Show main menu
Show-CustomMenu
# Functions that do some stuf

function CleanTempAndPrefetchFiles {
    Clear-Host
    # Clean current users temporary files
    Get-ChildItem -Path $env:TEMP | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
        } catch {
            # Write-Host "This is normal, an error occured deleting $($env:TEMP)\$($_.Name): $($_.Exception.Message)"
        }
    }
    Write-Host "Deleted User Temp files successfully"
    # Clean system temporary files
    $systemTempPath = "C:\Windows\Temp"
    Get-ChildItem -Path $systemTempPath | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
        } catch {
            # Write-Host "This is normal, an error occured deleting $($systemTempPath)\$($_.Name): $($_.Exception.Message)"
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
                    'q' {exit}
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
                    'q' {exit}
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
            exit
        }
    }
} while ($true)
