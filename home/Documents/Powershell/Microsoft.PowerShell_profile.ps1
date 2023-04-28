
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-Alias G git
if (Get-Command oh-my-posh -errorAction SilentlyContinue) {
  oh-my-posh init pwsh --config "$env:USERPROFILE\.config\oh-my-posh\theme_default.yaml" | Invoke-Expression
}
