' Note that we need to import this file in MainLoaderTask.xml using relative path.
sub Init()
    ' set the name of the function in the Task node component to be executed when the state field changes to RUN
    ' in our case this method executed after the following cmd: m.contentTask.control = "run"(see Init method in MainScene)
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    m.rootChildren = []
    m.rows = {}
    getInitialRegions()
end sub

function getInitialRegions() as Object
    regionDex = getConstants("REGION_DEX")
    kanto = GetDex(regionDex.KANTO_ID, false)
    kantoPlusJohto = GetDex(regionDex.JOHTO_ID, false)
    return GetDex(regionDex.HOENN_ID, true)
end function