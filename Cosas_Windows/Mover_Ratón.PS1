## Script sacado de https://techexpert.tips/powershell/powershell-moving-mouse-automatically/

$MYJOB = Start-Job -ScriptBlock {

    $MOVEMENTSIZE = 10
    $SLEEPTIME = 5
    
    Add-Type -AssemblyName System.Windows.Forms
    while ($true) {
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x += $MOVEMENTSIZE
    $POSITION.y += $MOVEMENTSIZE
    [Windows.Forms.Cursor]::Position = $POSITION
    Start-Sleep -Seconds $SLEEPTIME
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x -= $MOVEMENTSIZE
    $POSITION.y -= $MOVEMENTSIZE
    [Windows.Forms.Cursor]::Position = $POSITION
    Start-Sleep -Seconds $SLEEPTIME
    }

    }