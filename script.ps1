
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

function Show-SoftwareDownloadMenu
{
    Clear-Host
    Write-Host -NoNewline "---------------   "
    Write-Host -ForegroundColor Yellow "Software" -NoNewline
    Write-Host "   ---------------"
    EntrySelection -key "1: " -value "VS Code"
    EntrySelection -key "2: " -value "IntelliJ Community Edition"
    EntrySelection -key "B: " -value "Back to Download Menu"
    Write-Host ""
    Write-Host ""
    
    do {
        $choice = Read-Host "Select a software to download (1/2/B): "
        switch ($choice) {
            '1' {
                DownloadSoftware "VS Code" "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
                Show-SoftwareDownloadMenu
            }
            '2' {
                DownloadSoftware "IntelliJ Community Edition" "https://download.jetbrains.com/idea/ideaIC-2023.2.3.exe"
                Show-SoftwareDownloadMenu
            }
            'B' {
                Show-DownloadMenu
            }
            default {
                Write-Host "Invalid choice. Please select a valid option."
            }
        }
    } while ($choice -notin '1', '2', 'B')
}

function DownloadSoftware($softwareName, $downloadUrl)
{
    $downloadDirectory = "C:\Downloads"
    if (-not (Test-Path -Path $downloadDirectory)) {
        New-Item -Path $downloadDirectory -ItemType Directory
    }

    Write-Host "Downloading $softwareName..."

    $downloadPath = Join-Path -Path $downloadDirectory -ChildPath "$softwareName.exe"
    
    
    $curlCommand = "curl -o `"$downloadPath`" `"$downloadUrl`""
    Invoke-Expression $curlCommand

    
    while (-not (Test-Path -Path $downloadPath)) {
        Start-Sleep -Seconds 1  
    }

    Write-Host "$softwareName downloaded to $downloadPath"

    
    Write-Host "Opening $softwareName..."
    Start-Process -FilePath $downloadPath
    

    Read-Host "Install the software like you normally would. Press Enter when you're done"
    

    
    Remove-Item -Path $downloadPath -Force

    Write-Host "Deleted $softwareName installer file."

    
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



Show-CustomMenu


function ClearExit {
    Clear-Host
    exit
}



function CleanTempAndPrefetchFiles {
    Clear-Host
    
    Get-ChildItem -Path $env:TEMP | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
        } catch {
            
        }
    }
    Write-Host "Deleted User Temp files successfully"
    
    $systemTempPath = "C:\Windows\Temp"
    Get-ChildItem -Path $systemTempPath | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
        } catch {
            
        }
    }
    Write-Host "Deleted System Temp files successfully."
    
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
                    '2' {Show-SoftwareDownloadMenu}
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
            
        }
        '4' {
            
        }
        'q' {
            ClearExit
        }
    }
} while ($true)
