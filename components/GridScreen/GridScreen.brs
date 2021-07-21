

' entry point of GridScreen
' Note that we need to import this file in GridScreen.xml using relative path.
sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    ' label with item description
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    ' label with item title
    m.titleLabel = m.top.FindNode("titleLabel")
    ' observe rowItemFocused so we can know when another item of rowList will be focused
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

sub OnItemFocused() ' invoked when another item is focused
    isToLoadMoreRowContent = false
    rowPosition = 0
    itemPosition = 1
    focusedIndex = m.rowList.rowItemFocused ' get position of focused item

    if valid(m.lastFocusedRow) and m.lastFocusedRow < focusedIndex[rowPosition] then
        isToLoadMoreRowContent = true
    end if

    m.lastFocusedRow = focusedIndex[rowPosition]
    row = m.rowList.content.GetChild(focusedIndex[rowPosition]) ' get all items of row
    item = row.GetChild(focusedIndex[itemPosition]) ' get focused item
    ' update description label with description of focused item
    m.descriptionLabel.text = item.description
    ' update title label with title of focused item
    m.titleLabel.text = item.title
    ' adding length of playback to the title if item length field was populated

    ' if item.length <> invalid
    '     m.titleLabel.text += " | " + GetTime(item.length)
    ' end if

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