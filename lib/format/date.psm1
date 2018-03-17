


Function Format-Date($Value) {
    # Returns Time formated in base 24h
    if ($Value) {
        $DateTime = $(Get-Date -Date $Value).ToShortDateString()
        return $DateTime
    }
}






