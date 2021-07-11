function getConstants(key as String) as Dynamic
    if key = "REGION_DEX" then
        return {
            kantoId: 2
            johtoId: 3
            hoennId: 4
            sinnohId: 5
            unovaId: 8
            kalosCentralId: 12
            kalosCpastalId: 13
            kalosMountainId: 14
        }
    end if
    return {}
end function