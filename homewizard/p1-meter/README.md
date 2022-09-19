## Usage

You can discover the hostname of your HomeWizard Wi-Fi P1 Meter by running the following commmand in a (PowerShell) terminal:

```cmd
dns-sd -B _hwenergy._tcp .
```

In this example result the hostname is `p1meter-DDEEFF`

```txt
Browsing for _hwenergy._tcp
Timestamp     A/R Flags if Domain                    Service Type              Instance Name
14:46:11.368  Add     2 29 local.                    _hwenergy._tcp.           p1meter-DDEEFF
```
When you run the `Read-P1-meter.ps1` script you will be asked to input the hostname.

The script will run until you exit it by **CTRL + C**.

## Legend

| label | API property | Description |
| --- | --- | --- |
| Fase1 | active_power_l1_w | The active usage for fase 1 in Watts
| Fase2 | active_power_l2_w | The active usage for fase 2 in Watts (HWE-P1 returns ‘null’ when connection is single-phase)
| Fase3 | active_power_l3_w | The active usage for fase 3 in Watts (HWE-P1 returns ‘null’ when connection is single-phase)
| Total | active_power_w    | The total active usage in Watts
