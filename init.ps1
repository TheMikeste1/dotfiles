# Check if we have admin permissions
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
# If not, relaunch as admin
if (-not $IsAdmin) {
  Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
  Exit
}

# Loop through the repo's "./home" directory, checking if those files and directories exist in the user's home directory
# If they don't exist, create a soft symbolic link to the file in the home directory
# If they do exist, check if they are symbolic links
# If they are symbolic links, check if they point to the correct file
# If they already exist or don't point to the correct file, notify the user but don't touch it
$HomeDir = $env:USERPROFILE
$RepoDir = (Get-Item -Path ".\home").FullName
$HomeFiles = Get-ChildItem -Path $HomeDir
$RepoFiles = Get-ChildItem -Path $RepoDir

foreach ($RepoFile in $RepoFiles) {
  $RepoFilePath = $RepoFile.FullName
  $HomeFilePath = $HomeDir + "\" + $RepoFile.Name

  if (-not (Test-Path -Path $HomeFilePath)) {
    # The file doesn't exist in the home directory, create a symbolic link
    Write-Host "Creating symbolic link for $RepoFilePath in $HomeFilePath"
    New-Item -ItemType SymbolicLink -Path $HomeFilePath -Target $RepoFilePath | out-null
  } else {
    # The file exists in the home directory, check if it's a symbolic link
    $HomeFile = Get-Item -Path $HomeFilePath

    if ($HomeFile.Attributes -eq "ReparsePoint") {
      # If the object is a symbolic link, check if it points to the correct file
      if ($HomeFile.Target -ne $RepoFilePath) {
        Write-Host "Symbolic link $HomeFilePath already exists, but points to $HomeFile.Target, not $RepoFilePath"
        Write-Host "Please delete the symbolic link and re-run this script"
      } else {
        Write-Host "Symbolic link $HomeFilePath already exists, and points to the correct target, skipping"
      }
    } else {
      # If the object is a directory, step down one level and create links for those files instead
      if ($RepoFile.Attributes -eq "Directory") {
        $RepoSubFiles = Get-ChildItem -Path $RepoFilePath

        foreach ($RepoSubFile in $RepoSubFiles) {
          $RepoSubFilePath = $RepoSubFile.FullName
          $HomeSubFilePath = $HomeFilePath + "\" + $RepoSubFile.Name

          if (-not (Test-Path -Path $HomeSubFilePath)) {
            Write-Host "Creating symbolic link for $RepoSubFilePath in $HomeSubFilePath"
            New-Item -ItemType SymbolicLink -Path $HomeSubFilePath -Target $RepoSubFilePath | out-null
          } else {
            $HomeSubFile = Get-Item -Path $HomeSubFilePath

            if ($HomeSubFile.Attributes -eq "ReparsePoint") {
              if ($HomeSubFile.Target -ne $RepoSubFilePath) {
                Write-Host "Symbolic link $HomeSubFilePath already exists, but points to $HomeSubFile.Target, not $RepoSubFilePath"
                Write-Host "Please delete the symbolic link and re-run this script"
              } else {
                Write-Host "Symbolic link $HomeSubFilePath already exists, and points to the correct target, skipping"
              }
            } else {
              Write-Host "File $HomeSubFilePath already exists, skipping"
            }
          }
        }
      } else {
        # The object exists, is not a directory, and isn't a symbolic link. 
        # Notify the user but don't touch it
        Write-Host "File $HomeFilePath already exists, skipping"
      }
    }
  }
}
