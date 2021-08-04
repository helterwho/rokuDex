
' Note that we need to import this file in MainScene.xml using relative path.

sub ShowGridScreen()
    m.GridScreen = CreateObject("roSGNode", "GridScreen")
    m.GridScreen.ObserveField("rowItemSelected", "OnGridScreenItemSelected")
    ShowScreen(m.GridScreen) ' show GridScreen
end sub

sub OnGridScreenItemSelected(event as Object)
    grid = event.GetRoSGNode()
    content = grid.content
    buttonIndex = event.getData() ' index of selected button
    rowIndex = 0
    itemIndex = 1
    selectedRow = buttonIndex[rowIndex]
    rowContent = grid.content.GetChild(selectedRow)
    
    selectedItem = rowContent.GetChild(buttonIndex[itemIndex])
    
    if selectedItem.isSeeMore then
        OnSeeMoreItemSelected(selectedItem)
    end if
end sub

sub OnSeeMoreItemSelected(selectedItem as Object)
    ShowDetailsScreen(selectedItem) 
end sub
