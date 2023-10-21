<#
 # * bootstrap.ps1
 #
 # * Creates a new React project for VS Code with Yuri's settings
 #
 # ! Disclaimer: I'm not a PowerShell power user... 
 #
 # * -- Yuri - Oct 2023
#>

Write-Output "`nVS Code React Bootstrap Script -- Yuri - 2023`n"

if ($null -eq (Get-Command "npm" -ErrorAction SilentlyContinue)) 
{ 
   Write-Host "Unable to find npm in your PATH."
   Write-Host "Download the installer at https://nodejs.org/en/download"
   Write-Host "`nDone.`n"
   exit 1
} else {
    Write-Output "Found npm version $(npm -v)`n"
}

$hasCargo = $false
if ($null -eq (Get-Command "cargo" -ErrorAction SilentlyContinue)) 
{ 
   Write-Host "Unable to find cargo in your PATH."
   Write-Host "Follow install instructions at:`nhttps://doc.rust-lang.org/cargo/getting-started/installation.html'`n"
   Write-Host "Will skip Tauri initialization option (Ctrl-C to exit now)...`n"
} else {
    Write-Output "Found $(cargo --version)`n"
    $hasCargo = $true
}

$script_path = "$PWD"

$project_name = "$args"

if ("" -eq $project_name) {
    $project_name = Read-Host "New project name"
}

$path = Join-Path (Resolve-Path ..) "$project_name"

Set-Location -Path ".."

Write-Output "`nCreating project with Vite.`nRecommend choosing React and Javascript-SWC...`n"

npm create vite@latest "$project_name" -- --template react-swc

Write-Output "`nInstalling dependencies...`n"

Set-Location -Path "$path"

npm install

Write-Output "`nInstalling React Bootstrap...`n"

npm install react-bootstrap bootstrap

if (Test-Path "$path\.vscode") {
    Write-Output "`n.vscode exists, not overwriting.`n"
}
else {
    Write-Output "`nCopying .vscode folder...`n"
    Copy-Item "$script_path\.vscode" -Recurse -Destination "$path"
}

Write-Output "Setting bootstrap dark mode in index.html`n"

$indexHtml = ".\index.html"

$fileContents = Get-Content $indexHtml

$line = $fileContents | Select-String '<html lang' | Select-Object -ExpandProperty Line

if ($null -eq $line) {
    Write-Output "<html> header not found in index.html"
    exit
}

$modifiedContents = $fileContents | ForEach-Object { $_.Replace($line, '<html lang="en" data-bs-theme="dark">') }

$modifiedContents | Out-File $indexHtml

Write-Output "Importing bootstrap.min.css in src/main.jsx`n"

$mainJsx = ".\src\main.jsx"

$fileContents = Get-Content $mainJsx

$line = $fileContents | Select-String "import './index.css'" | Select-Object -ExpandProperty Line

if ($null -eq $line) {
    Write-Output  "import './index.css' statement not found in src/main.jsx"
    exit
}

$modifiedContents = $fileContents | ForEach-Object { $_.Replace($line, "import './index.css'`nimport 'bootstrap/dist/css/bootstrap.min.css'") }

$modifiedContents | Out-File $mainJsx

$doneStr = "`nDone. Now run:`n`n  npm run dev`n"

if ($hasCargo) {
    $doTauri = Read-Host "Make this a Tauri project (y/N)?"
    if ($doTauri -eq "y" -or $doTauri -eq "Y") {
        Write-Output "`nInitializing Tauri...`n"
        cargo tauri init -A $project_name -W $project_name -D ../build -P http://localhost:5173 --before-dev-command "npm run dev" --before-build-command "npm run build"

        Write-Output "Copying vite.config.js..."
        Copy-Item "$script_path\vite.config.js"  -Destination "$path"

        $doneStr = "$doneStr      or`n  cargo tauri dev`n"
    }
}

Write-Host "$doneStr`n"

Write-Host -NoNewLine "Press any key to open new project in VS Code (ESC to exit)..."
$key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

if (!(27 -eq $key.VirtualKeyCode)) {
    code $path
}

Write-Host "`n"
