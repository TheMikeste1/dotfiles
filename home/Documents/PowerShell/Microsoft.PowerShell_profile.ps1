# Check if starship is installed
if (Test-Path -Path "C:\Program Files\starship\bin\starship.exe") {
  # If it is, run the init script
  Invoke-Expression (&"C:\Program Files\starship\bin\starship.exe" init powershell)
}
