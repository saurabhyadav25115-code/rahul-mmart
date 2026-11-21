$ErrorActionPreference = 'Stop'
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$pwBytes = New-Object byte[] 24
$jwtBytes = New-Object byte[] 48
$rng.GetBytes($pwBytes)
$rng.GetBytes($jwtBytes)
$pw = [Convert]::ToBase64String($pwBytes).TrimEnd('=').Replace('+','A').Replace('/','B')
$jwt = [Convert]::ToBase64String($jwtBytes).TrimEnd('=').Replace('+','x').Replace('/','y')
$rng.Dispose()
$lines = @(
  'PORT=3000',
  'NODE_ENV=development',
  "JWT_SECRET=$jwt",
  'ADMIN_USERNAME=admin',
  "ADMIN_PASSWORD=$pw",
  'DATABASE_FILE=./db/rahul-mart.sqlite'
)
Set-Content -Path '.env' -Value $lines -Encoding ascii
Write-Host ''
Write-Host 'Admin username: admin' -ForegroundColor Green
Write-Host "Admin password: $pw" -ForegroundColor Yellow
Write-Host 'Save these credentials. Password is shown once during setup.' -ForegroundColor Yellow
Write-Host ''
