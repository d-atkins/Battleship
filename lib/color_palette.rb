# terminal color codes

$red_bold = "\e[1;31m"
$yellow_bold = "\e[1;33m"
$white_bold = "\033[01;37m"
$cyan = "\e[36m"
$color_restore = "\033[0m"

$M = $cyan + "M" + $color_restore
$miss = $cyan + "*miss*" + $color_restore

$H = $yellow_bold + "H" + $color_restore
$hit = $yellow_bold + "hit!" + $color_restore

$X = $red_bold + "X" + $color_restore
$sunk = $red_bold + "!!SUNK!!" + $color_restore

$S = $white_bold + "S" + $color_restore
