##################################################
#region Define Functions
##################################################

<#
.SYNOPSIS
Log to $env:windir\Temp.

.DESCRIPTION
Logging function with severity types, so as to play nicest with CMTrace highlighting. Will log to $env:windir\Temp by default.

.PARAMETER Message
The message you want to log.

.PARAMETER MessageType
Severity level of the message you are logging.

.PARAMETER FileName
File name of the log.

.EXAMPLE
Write-Log -Message "Task failed. Reason $_" -MessageType WARNING -FileName TaskLog.log

.NOTES
Because I use this in other scripts, I dynamically generate the file name based off the following:
    $fileName = $script:MyInvocation.MyCommand.Name
    $fileName = $fileName.Replace(".ps1", "")
    $logFile = $fileName + (Get-Date -Format ddMMyyyyhhmmss) + '.log'
    Write-Log -Message "Logging start." -MessageType INFO -FileName $logFile

Contact information for continuing maintenace:
https://github.com/BradyDonovan/
@b_radmn

#>

function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message,
        [Parameter(Mandatory = $true)]
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$MessageType,
        [Parameter(Mandatory = $true)]
        [string]$FileName
    )
    process {
        $logPath = "$env:windir\Temp\$FileName"
        IF (Test-Path $logPath) {
            Add-Content -Path $logPath -Value ("$(Get-Date -Format HH:mm:ss) :" + "$MessageType" + ": $Message")
        }
        ELSE {
            New-Item -Path $logPath
            Add-Content -Path $logPath -Value ("$(Get-Date -Format HH:mm:ss) :" + "$MessageType" + ": $Message")
        }
    }
}

##################################################
#endregion
##################################################

##################################################
#region Get Pre-Run Variables
##################################################

#Get current location. We're going to come back here when the script has finished.
$currentLoc = Get-Location

#Logging Variables
$fileName = $script:MyInvocation.MyCommand.Name
$fileName = $fileName.Replace(".ps1", "")
$logFile = $fileName + (Get-Date -Format ddMMyyyyhhmmss) + '.log'

#Setting markers for total runtime.
$counterStart = Get-Date

##################################################
#endregion
##################################################

##################################################
#region Begin
##################################################

#Do-Stuff

##################################################
#endregion
##################################################
