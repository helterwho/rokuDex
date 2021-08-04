sub ShowDetailsScreen(content as Object)
    detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    dexContent = content.content
    detailsScreen.content = dexContent
    detailsScreen.jumpToItem = 0
    detailsScreen.ObserveField("buttonSelected", "OnButtonSelected")
    ShowScreen(detailsScreen)
end sub
