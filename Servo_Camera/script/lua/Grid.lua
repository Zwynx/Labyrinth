Grid = Appkit.class(Grid)

local myWidth = 1
local myHeight = 1
local myGridNumbers = {}

local myMarchingInfo = {}
local myTilePaths = {}

function Grid:init()
    myTilePaths[1] = "content/models/Procedural_Pieces/tile_1_floor/tile_1_floor"
    myTilePaths[2] = "content/models/Procedural_Pieces/tile_2_corner/tile_2_corner"
    myTilePaths[3] = "content/models/Procedural_Pieces/tile_3_wall_straight/tile_3_wall_straight"
    myTilePaths[4] = "content/models/Procedural_Pieces/tile_4_corner_double/tile_4_corner_double"
    myTilePaths[5] = "content/models/Procedural_Pieces/tile_5_corner_inwards/tile_5_corner_inwards"
    myTilePaths[6] = "content/models/Procedural_Pieces/tile_6_column/tile_6_column"
    myTilePaths[7] = "content/models/Procedural_Pieces/tile_7_roof/tile_7_roof"
end

function Grid:CreateValues()
   for y = 0 , myHeight , 1 do
    local row = {}
    myGridNumbers[y] = row
        for x = 0 , myWidth , 1 do
            row[x] = math.random(0,1)
        end
    end 
end


function Grid:CreateTiles()
   for y = 0 , myHeight , 1 do
    local row = myGridNumbers[y]
        for x = 0 , myWidth , 1 do
            
            local xPos = (x * 2.1) - (myWidth / 2)
            local yPos = y * 2.1 - (myHeight / 2)
            
            --stingray.Level.set_flow_variable(SimpleProject.level, "in_test", "Derp")
            --stingray.Level.set_flow_variable(SimpleProject.level, "in_bool", true)
            --print("Tile: " .. row[x] .. " - " .. xPos .. ", " .. yPos)
            
            stingray.Level.set_flow_variable(SimpleProject.level, "in_position", stingray.Vector3(xPos, yPos, 0.01))
            
            if (row[x] == 0) then
                stingray.Level.set_flow_variable(SimpleProject.level, "in_tilepath", myTilePaths[1])
                --stingray.Level.set_flow_variable(SimpleProject.level, "in_bool", true)
            else
                stingray.Level.set_flow_variable(SimpleProject.level, "in_tilepath", myTilePaths[7])
                --stingray.Level.set_flow_variable(SimpleProject.level, "in_bool", false)
            end
            
            stingray.Level.trigger_event(SimpleProject.level, "in_spawnTile")
        end
    end 
end


function Grid:DetermineTile(aMarhingValue, aX, aY)

    
end


function Grid:CreateGrid(aWidth, aHeight)
    myWidth = aWidth
    myHeight = aHeight

    self.CreateValues()
    self.CreateTiles();
end