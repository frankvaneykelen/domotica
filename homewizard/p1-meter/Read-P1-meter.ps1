<#
    active_power_w    : The total active usage in Watts
    active_power_l1_w : The active usage for phase 1 in Watts
    active_power_l2_w : The active usage for phase 2 in Watts (HWE-P1 returns ‘null’ when connection is single-phase)
    active_power_l3_w : The active usage for phase 3 in Watts (HWE-P1 returns ‘null’ when connection is single-phase)
#>

# Ensures that Invoke-WebRequest uses TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$hostname = Read-Host "Please enter the hostname of your Wi-Fi P1 meter ('p1meter-DDEEFF' for example)"

$endpoint = ("http://{0}/api/v1/data" -f $hostname)

Write-Host ("`nThe API endpoint is '{0}'" -f $endpoint)

do {
    $p1meterData = Invoke-WebRequest $endpoint | ConvertFrom-Json

    $ForegroundColor = "Red";
    if ($p1meterData.active_power_w -le 0) {
        $ForegroundColor = "Green";
    }

    Write-Host ("`nPhase1 Phase2 Phase3 Total")
    Write-Host ("------ ------ ------ -----")
    Write-Host ("{0} {1} {2} {3}" -f `
        $p1meterData.active_power_l1_w.ToString().PadLeft(6, " "), `
        $p1meterData.active_power_l2_w.ToString().PadLeft(6, " "), `
        $p1meterData.active_power_l3_w.ToString().PadLeft(6, " "), `
        $p1meterData.active_power_w.ToString().PadLeft(5, " ")`
    ) -ForegroundColor $ForegroundColor

    # The update frequency depends on the device and, in case of the HWE-P1, the smart meter that it is connected to. 
    # With a SMR 5.0 meter, this is every second for power and every 5 minutes for gas.
    Start-Sleep -Seconds 1
} 
while (1 -lt 2)