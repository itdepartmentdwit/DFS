
$folderPath = "C:\DFS\DFS\WEB"

Get-ChildItem -Path $folderPath -Filter *.* -Recurse | ForEach-Object {
    if (Get-Content $_.FullName | Select-String -Pattern "system.deerwalkfoods.com") {
        Write-Output "Found in $($_.FullName)"
    }
    
}
