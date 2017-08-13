Grid = Appkit.class(Grid)

Grid.myWidth = 1
Grid.myHeight = 1
Grid.myVertices = {}

Grid.myMarchingFaces = {}
Grid.myTilePaths = {}
Grid.myRecentMarchingValue = 5

function Grid:init()
    print("called grid init")
    self.myTilePaths[1] = "content/models/Procedural_Pieces/tile_1_floor/tile_1_floor"
    self.myTilePaths[2] = "content/models/Procedural_Pieces/tile_2_corner/tile_2_corner"
    self.myTilePaths[3] = "content/models/Procedural_Pieces/tile_3_wall_straight/tile_3_wall_straight"
    self.myTilePaths[4] = "content/models/Procedural_Pieces/tile_4_corner_double/tile_4_corner_double"
    self.myTilePaths[5] = "content/models/Procedural_Pieces/tile_5_corner_inwards/tile_5_corner_inwards"
    self.myTilePaths[6] = "content/models/Procedural_Pieces/tile_6_column/tile_6_column"
    self.myTilePaths[7] = "content/models/Procedural_Pieces/tile_7_roof/tile_7_roof"
    
    
    for i = 0, 15, 1 do
       self.myMarchingFaces[i] = {} 
    end
    
    self.myMarchingFaces[0]["path"] = self.myTilePaths[1]
    self.myMarchingFaces[0]["zRot"] = 0 
    self.myMarchingFaces[1]["path"] = self.myTilePaths[2]
    self.myMarchingFaces[1]["zRot"] = -90 
    self.myMarchingFaces[2]["path"] = self.myTilePaths[2]
    self.myMarchingFaces[2]["zRot"] = -180 
    self.myMarchingFaces[3]["path"] = self.myTilePaths[3]
    self.myMarchingFaces[3]["zRot"] = -180 
    self.myMarchingFaces[4]["path"] = self.myTilePaths[2]
    self.myMarchingFaces[4]["zRot"] = 0 
    self.myMarchingFaces[5]["path"] = self.myTilePaths[3]
    self.myMarchingFaces[5]["zRot"] = -90 
    self.myMarchingFaces[6]["path"] = self.myTilePaths[4]
    self.myMarchingFaces[6]["zRot"] = 0 
    self.myMarchingFaces[7]["path"] = self.myTilePaths[5]
    self.myMarchingFaces[7]["zRot"] = -90
    self.myMarchingFaces[8]["path"] = self.myTilePaths[2]
    self.myMarchingFaces[8]["zRot"] = 90 
    self.myMarchingFaces[9]["path"] = self.myTilePaths[4]
    self.myMarchingFaces[9]["zRot"] = 90 
    self.myMarchingFaces[10]["path"] = self.myTilePaths[3]
    self.myMarchingFaces[10]["zRot"] = 90 
    self.myMarchingFaces[11]["path"] = self.myTilePaths[5]
    self.myMarchingFaces[11]["zRot"] = 180
    self.myMarchingFaces[12]["path"] = self.myTilePaths[3]
    self.myMarchingFaces[12]["zRot"] = 0
    self.myMarchingFaces[13]["path"] = self.myTilePaths[5]
    self.myMarchingFaces[13]["zRot"] = 0
    self.myMarchingFaces[14]["path"] = self.myTilePaths[5]
    self.myMarchingFaces[14]["zRot"] = 90 
    self.myMarchingFaces[15]["path"] = self.myTilePaths[7]
    self.myMarchingFaces[15]["zRot"] = 0
end						 
						 
function Grid:PrintGrid()
    for y = self.myHeight, 0, -1 do
        local rowMsg = "-- "
        for x = 0 , self.myWidth, 1 do
            rowMsg = rowMsg .. self.myVertices[y][x] .. ", "
        end
        print(rowMsg)
    end 
end

function Grid:CreatePredeterminedValues()
   for y = 0 , self.myHeight, 1 do
    local row = {}
    self.myVertices[y] = row
        for x = 0 , self.myWidth, 1 do
            if (y % 2 == 0) then
                row[x] = 0--math.random(1)
            else
                row[x] = 1
            end
        end
    end 
    self:PrintGrid()
end

function Grid:CreateValues()
   for y = 0 , self.myHeight, 1 do
    local row = {}
    self.myVertices[y] = row
        for x = 0 , self.myWidth, 1 do
            row[x] = math.random(0,1)
        end
    end 
    self:PrintGrid()
end

function Grid:DetermineFaceValue(aX, aY)
    local value = 0
    if (self.myVertices[aY -1][aX -1] == 1) then
        value = value + 1
    end
    if (self.myVertices[aY -1][aX] == 1) then
        value = value + 2
    end
    if (self.myVertices[aY][aX -1] == 1) then
        value = value + 4
    end
    if (self.myVertices[aY][aX] == 1) then
        value = value + 8
    end
    return value 
end

function Grid:CreateTiles()
   for yi = self.myHeight,1, -1 do
    local printMsg = " <-- "
        for xi = 1 , self.myWidth, 1 do
            
            local xPos = (xi * 2) - (self.myWidth)
            local yPos = (self.myHeight - yi) * 2 - (self.myHeight)
            
            stingray.Level.set_flow_variable(SimpleProject.level, "in_tileposition", stingray.Vector3(xPos, yPos, 0.01))
            local marchingValue = self:DetermineFaceValue(xi, yi) -- THIS FAILS
            printMsg = printMsg .. marchingValue .. ", "
            
            stingray.Level.set_flow_variable(SimpleProject.level, "in_tilepath", self.myMarchingFaces[marchingValue]["path"])
            stingray.Level.set_flow_variable(SimpleProject.level, "in_tilezrotation", self.myMarchingFaces[marchingValue]["zRot"])

            stingray.Level.trigger_event(SimpleProject.level, "in_spawntile")
        end
        print(printMsg)
    end 
end

function Grid:TestDerp(msg)
   print(msg .. ", " .. self.myWidth) 
end


function Grid:CreateGrid(aWidth, aHeight)
    self.myWidth = aWidth 
    self.myHeight = aHeight
    
    --self:TestDerp("HERPADERP")
    
    self:CreateValues()
    self:CreateTiles()
end
