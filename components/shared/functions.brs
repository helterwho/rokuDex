function valid(item) as Boolean
    return type(item).inStr("Invalid") = -1 and type(item) <> "<uninitialized>"
end function

function GetDex(dexId as integer, isLastInitialRow as boolean) as object
    
    if not valid(m.request)
        xfer = CreateObject("roURLTransfer")
        xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
        m.request = xfer
    else
        xfer = m.request
    end if

    xfer.SetURL("https://pokeapi.co/api/v2/pokedex/"+ dexId.ToStr() + "/")
    rsp = xfer.GetToString()


    rootChildren = m.rootChildren
    rows = m.rows

    ' parse the feed and build a tree of ContentNodes to populate the GridView
    json = ParseJson(rsp)
    if json <> invalid
        for each category in json
            value = json.Lookup(category)
            if Type(value) = "roArray" and category = "pokemon_entries"
                row = {}
                regionName = getInitialStringUppercased(json.region.name)
                row.title = regionName + " Dex"
                row.children = []
                for each item in value ' parse items and push them to row
                    itemData = GetItemData(item.pokemon_species)
                    row.children.Push(itemData)
                end for
                rootChildren.Push(row)
            end if
        end for
        ' set up a root ContentNode to represent rowList on the GridScreen
        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        ' populate content field with root content node.
        ' Observer(see OnMainContentLoaded in MainScene.brs) is invoked at that moment
        if(isLastInitialRow) then
            m.top.content = contentNode
        end if
    end if
    return xfer
end function

function GetItemData(pkmn as Object) as Object
    index = pkmn.url.replace("https://pokeapi.co/api/v2/pokemon-species/", "").replace("/", "")
    pkmnName = getInitialStringUppercased(pkmn.name)
    item = {}
    ' if pkmn.longDescription <> invalid
    '     item.description = pkmn.longDescription
    ' else
    '     item.description = pkmn.shortDescription
    ' end if
    item.hdPosterURL = "https://pokeres.bastionbot.org/images/pokemon/" + index.ToStr() +".png"
    item.title = "#" + index.ToStr() + " " + pkmnName
    ' item.releaseDate = pkmn.releaseDate
    ' item.id = pkmn.i
    ' if pkmn.content <> invalid
    '     ' populate length of content to be displayed on the GridScreen
    '     item.length = pkmn.content.duration
    ' end if
    return item
end function

function getInitialStringUppercased(name as String) as String
    initialChar = mid(name, 0, 1)
    firstCharacterName = Ucase(initialChar)
    newNameTemp = "*" + name
    newName = newNameTemp.replace("*" + initialChar, firstCharacterName)
    return newName
end function