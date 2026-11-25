$ErrorActionPreference = 'SilentlyContinue'
$endTime = (Get-Date).AddMinutes(2)

while ((Get-Date) -lt $endTime) {
    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:3000' -TimeoutSec 2
        if ($response.StatusCode -eq 200) {
            Start-Process 'http://localhost:3000'
            exit 0
        }
    } catch {
        Start-Sleep -Seconds 2
    }
}
