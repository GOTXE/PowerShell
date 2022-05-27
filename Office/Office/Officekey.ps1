function Get-MSOfficeProductKey {

    param(

    [string[]]$computerName = "."

    )

    $product = @()

    $hklm = 2147483650

    $path = "SOFTWARE\Microsoft\Office"

    foreach ($computer in $computerName) {

        $wmi = [WMIClass]"\\$computer\root\default:stdRegProv"

        $subkeys1 = $wmi.EnumKey($hklm,$path)

        foreach ($subkey1 in $subkeys1.snames) {

            $subkeys2 = $wmi.EnumKey($hklm,"$path\$subkey1")

            foreach ($subkey2 in $subkeys2.snames) {

                $subkeys3 = $wmi.EnumKey($hklm,"$path\$subkey1\$subkey2")

                foreach ($subkey3 in $subkeys3.snames) {

                    $subkeys4 = $wmi.EnumValues($hklm,"$path\$subkey1\$subkey2\$subkey3")

                    foreach ($subkey4 in $subkeys4.snames) {

                        if ($subkey4 -eq "digitalproductid") {

                            $temp = "" | select ComputerName,ProductName,ProductKey

                            $temp.ComputerName = $computer

                            $productName = $wmi.GetStringValue($hklm,"$path\$subkey1\$subkey2\$subkey3","productname")

                            $temp.ProductName = $productName.sValue

                            $data = $wmi.GetBinaryValue($hklm,"$path\$subkey1\$subkey2\$subkey3","digitalproductid")

                            $valueData = ($data.uValue)[52..66]

                            # decrypt base24 encoded binary data

                            $productKey = ""

                            $chars = "BCDFGHJKMPQRTVWXY2346789"

                            for ($i = 24; $i -ge 0; $i--) {

                                $r = 0

                                for ($j = 14; $j -ge 0; $j--) {

                                    $r = ($r * 256) -bxor $valueData[$j]

                                    $valueData[$j] = [math]::Truncate($r / 24)

                                    $r = $r % 24

                                }

                                $productKey = $chars[$r] + $productKey

                                if (($i % 5) -eq 0 -and $i -ne 0) {

                                    $productKey = "-" + $productKey

                                }

                            }

                            $temp.ProductKey = $productKey

                            $product += $temp

                        }

                    }

                }

            }

        }

    }

    $product

}