function Init()
    m.top.ObserveField("visible", "OnVisibleChange")
    m.top.ObserveField("itemFocused", "OnItemFocusedChanged")
    m.fullDexLabel = m.top.FindNode("fullDexLabel")
    m.fullDexPosterGrid = m.top.FindNode("fullDexPosterGrid")
    m.fullDexPosterGridcontent = createObject("roSGNode","ContentNode")
    m.readPosterGridTask = createObject("roSGNode","postergridCR")


    m.backgroundDetailsScreen = m.top.findNode("backgroundDetailsScreen")
    m.backgroundDetailsScreen.width = 1280
    m.backgroundDetailsScreen.height = 720

end function

sub buildpostergrid(content)
    gridposter = createObject("roSGNode","ContentNode")
    gridposter.hdgridposterurl = content.hdPosterURL
    gridposter.hdposterurl = content.hdPosterURL
    gridposter.sdgridposterurl = content.hdPosterURL
    gridposter.sdposterurl = content.hdPosterURL
    gridposter.shortdescriptionline1 = content.dexNumber + " " +  content.title
  
    m.fullDexPosterGridcontent.appendChild(gridposter)
end sub

sub showpostergrid()
    m.fullDexLabel.text = m.top.content.title

    font = CreateObject("roSGNode", "Font")
    font.uri = "pkg:/fonts/Montserrat-SemiBold.ttf"
    font.size = 28
    m.fullDexLabel.font = font

    m.fullDexPosterGrid.content=m.fullDexPosterGridcontent
    m.fullDexPosterGrid.visible=true
    m.fullDexPosterGrid.setFocus(true)
end sub

sub onVisibleChange()' invoked when DetailsScreen visibility is changed
    if m.top.visible = true
        m.top.SetFocus(true)
    end if
end sub

sub SetDetailsContent(contents)
    for i = 0 to contents.Count() - 1
        buildpostergrid(contents[i])
    end for

    showpostergrid()
end sub

sub OnJumpToItem() ' invoked when jumpToItem field is populated
    content = m.top.content
    if content <> invalid and m.top.jumpToItem >= 0 and content.GetChildCount() > m.top.jumpToItem
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub OnItemFocusedChanged(event as Object)' invoked when another item is focused
    focusedItem = event.GetData()
    contents = m.top.content.GetChildren(-1, 0)
    SetDetailsContent(contents)
end sub