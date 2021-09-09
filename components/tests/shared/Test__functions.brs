sub init()
    Runner = TestRunner()

    Runner.SetFunctions([
        MainTestSuite__SetUp
        TestCase__function_TestValid__Passed
        TestCase__function_TestValid__Failed
        ValidItemDataProps
        TestCase__function_TestGetItemData
        TestCase__function_TestGetInitialStringUppercased
        TestCase__functions_CheckLiteRootCount
        TestCase__functions_CheckLiteRootSeeMore
        TestCase__functions_CheckRootShouldSeeMoreDisabled
        TestCase__functions_CheckRootCount
        ThisFunctionShouldBeCalledAfterAllTests
    ])
end sub

' @BeforeAll
sub MainTestSuite__SetUp()
    kantoID = 2
    isLastInitialRow = false
    m.rootChildren = []
    m.liteRootChildren = []
    m.rows = {}
    m.maxItemsPerRow = 10

    GetDex(kantoID, m.rootChildren, m.liteRootChildren, m.rows, isLastInitialRow, m.maxItemsPerRow)

end sub

' @Test
function TestCase__function_TestValid__Passed() as object
    scheme = {
        key1  : {subKey1: "string"}
        key2  : {subKey1: "boolean"}
        key3  : {subKey1: "integer"}
    }
    inputObject = ItemGenerator(scheme)

    result = valid(inputObject)
    return UTF_assertTrue(result)
end function

' @Test
function TestCase__function_TestValid__Failed() as object
    obj = {}
    scheme = obj.uninitializedProps
    inputObject = ItemGenerator(scheme)

    result = valid(inputObject)
    return UTF_assertFalse(result)
end function


' @Ignore
function ValidItemDataProps(prop as String, valueType as String, valueSearch as String) as Boolean
    return valid(prop) and type(prop) = valueType and prop.Instr(valueSearch) > -1
end function


' @Test
function TestCase__function_TestGetItemData() as object
    inputObject = {
        name: "bulbasaur"
        url: "https://pokeapi.co/api/v2/pokemon-species/1/"
    }
    
    ouputObject = GetItemData(inputObject)

    isValidAlPosterURL = ValidItemDataProps(ouputObject.alternativePosterURL, "String", "http")
    isValidhdposterurl = ValidItemDataProps(ouputObject.hdposterurl, "String", "http")
    hasTitle = ValidItemDataProps(ouputObject.title, "String", "#")

    return UTF_assertTrue(isValidAlPosterURL and isValidhdposterurl and hasTitle)
end function

' @Test
function TestCase__function_TestGetInitialStringUppercased() as object
    
    scheme = "string"
    inputObject = ItemGenerator(scheme)

    outputObject = getInitialStringUppercased(inputObject)

    initialChar = mid(inputObject, 0, 1)
    firstCharUppercased = Ucase(initialChar)

    hasWorked = outputObject.Instr(firstCharUppercased) > -1
    return UTF_assertTrue(hasWorked)
end function

' @Test
function TestCase__functions_CheckLiteRootCount() as Boolean
    itemCollection = m.literootchildren[0].children
    maxItemsPerRow = m.maxItemsPerRow + 1
    return UTF_assertArrayCount(itemCollection, maxItemsPerRow)
end function


' @Test
function TestCase__functions_CheckLiteRootSeeMore() as Boolean
    itemCollection = m.literootchildren[0].children
    hasSeeMore = true
    return UTF_assertArrayContains(itemCollection, hasSeeMore, "isSeeMore")
end function


' @Test
function TestCase__functions_CheckRootShouldSeeMoreDisabled() as Boolean
    itemCollection = m.rootchildren[0].children
    hasSeeMore = false
    return UTF_assertArrayContains(itemCollection, hasSeeMore, "isSeeMore")
end function

' @Test
function TestCase__functions_CheckRootCount() as Boolean
    itemCollection = m.rootchildren[0].children
    maxItemsPerRow = m.maxItemsPerRow + 1
    return UTF_assertArrayNotCount(itemCollection, maxItemsPerRow)
end function

' @AfterAll
sub ThisFunctionShouldBeCalledAfterAllTests()
    m.Delete("rootChildren")
    m.Delete("liteRootChildren")
    m.Delete("rows")
    m.Delete("maxItemsPerRow")
end sub
