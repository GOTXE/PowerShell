$IP =  "xxx.xxx.xxx.xxx"
ping.exe -t $IP | Foreach{"{0} - {1}" -f (Get-Date -f "yyyMMdd HH:mm:ss"),$_}
