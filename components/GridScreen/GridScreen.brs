

' entry point of GridScreen
' Note that we need to import this file in GridScreen.xml using relative path.
sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.top.ObserveField("visible", "onVisibleChange")
    m.rowList.ObserveField("rowItemFocused", "OnItemFocused")
    
    regionDex = getConstants("REGION_DEX")
    allRegions = []
    for each region in regionDex
        value = regionDex.Lookup(region)
        allRegions.push({
            regionName: region.ToStr()
            id: value
            status: value <= regionDex.KANTO_ID or value <= regionDex.JOHTO_ID or value <= regionDex.HOENN_ID
        })
    end for
    allRegions.SortBy("id")
    m.allRegions = allRegions 
end sub

sub OnVisibleChange() ' invoked when GridScreen change visibility
    if m.top.visible = true
        m.rowList.SetFocus(true)
    end if
end sub

sub OnItemFocused() ' invoked when another item is focused
    isToLoadMoreRowContent = false
    rowPosition = 0
    itemPosition = 1
    focusedIndex = m.rowList.rowItemFocused

    if valid(m.lastFocusedRow) and m.lastFocusedRow < focusedIndex[rowPosition] then
        isToLoadMoreRowContent = true
    end if

    m.lastFocusedRow = focusedIndex[rowPosition]
    row = m.rowList.content.GetChild(focusedIndex[rowPosition])
    item = row.GetChild(focusedIndex[itemPosition])
    m.descriptionLabel.text = item.description
    m.titleLabel.text = item.title

    m.background = m.top.findNode("backgroundImage")
    m.background.width = 630
    m.background.height = 360
    m.background.uri = item.alternativePosterURL
    
    if isToLoadMoreRowContent then
        for each region in m.allRegions
            if not region.status
                ' TODO: uncomment code below when roURLTransfer problem is fixed
                ' GetDex(region.id, true)
                region.status = true
                exit for
            end if            
        end for
    end if
end sub