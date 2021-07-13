function getConstants(key as String) as Dynamic
    if key = "REGION_DEX" then
        return {
            KANTO_ID: 2
            JOHTO_ID: 3
            HOENN_ID: 4
            SINNOH_ID: 5
            UNOVA_ID: 8
            KALOS_CENTRAL_ID: 12
            KALOS_COASTAL_ID: 13
            KALOS_MOUNTAIN_ID: 14
            ORIGINAL_ALOLA_ID: 16
            ORIGINAL_MELEMELE_ID: 17
            ORIGINAL_AKALA_ID: 18
            ORIGINAL_ULAULA_ID: 19
            ORIGINAL_PONI_ID: 20
        }
    end if
    return {}
end function