param
(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [string]$VBOjob
)

# setting up security protocol
try
{
    Write-Host "Setting up security protocol."
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Ssl3 -bor [System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12
}
catch
{
    "The requested security protocol is not supported."
    exit(0)
}

# setting up job sessions
try
{
    $job = Get-VBOJob -Name $VBOjob
    $sessions = Get-VBOJobSession -Job $job
}
catch
{
    'Job {0} was not found. Provide a valid job name.' -f $VBOjob
    exit(0)
}

function Show-Error
# Displays the error if there are any.
{
    if ($session.Status -eq "Failed")
    {
        Write-Host $errorTitle -ForegroundColor Red
    }
}

function Show-Status
# Displays the status of the job and how much data transferred
{
    'Transferred: {0}. Status: {1}' -f $transferred, $status
}

$nl = [Environment]::NewLine

foreach ($session in $sessions)
{
    $StartDate = $session.CreationTime
    $EndDate = $session.EndTime
    $status = $session.Status
    $timespan = New-TimeSpan -Start $StartDate -End $EndDate
    $duration = @{
        Days = $timespan.Days
        Hours = $timespan.Hours
        Minutes = $timespan.Minutes
    }
    $transferred = $session.Statistics.TransferredData
    $errorTitle = $session.Log[1].Title

    if (($duration.Hours -eq 0) -and ($duration.Days -eq 0) )
    {
        'JobName: {0}, Created: {1}. Duration: {2} minute(s).' -f
        $session.JobName,
        $session.CreationTime,
        $duration.Minutes
        Show-Status
        Show-Error
        $nl
    }

    elseif ($duration.Days -eq 0)
    {
        'JobName: {0}, Created: {1}. Duration: {2} hours and {3} minute(s).' -f
        $session.JobName,
        $session.CreationTime,
        $duration.Hours,
        $duration.Minutes
        Show-Status
        Show-Error
        $nl
    }

    else
    {
        'JobName: {0}, Created: {1}. Duration: {2} days, {3} hours and {4} minute(s).' -f
        $session.JobName,
        $session.CreationTime,
        $duration.Days,
        $duration.Hours,
        $duration.Minutes
        Show-Status
        Show-Error
        $nl
    }
}