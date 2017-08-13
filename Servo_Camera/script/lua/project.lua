-----------------------------------------------------------------------------------
-- This implementation uses the default SimpleProject and the Project extensions are 
-- used to extend the SimpleProject behavior.

-- This is the global table name used by Appkit Basic project to extend behavior
Project = Project or {}

require 'script/lua/flow_callbacks'
require 'script/lua/Grid'

Project.level_names = {
	empty = "content/levels/Servo_Camera"
}

-- Can provide a config for the basic project, or it will use a default if not.
local SimpleProject = require 'core/appkit/lua/simple_project'
SimpleProject.config = {
	standalone_init_level_name = Project.level_names.empty,
	camera_unit = "core/appkit/units/camera/camera",
	camera_index = 1,
	shading_environment = nil, -- Will override levels that have env set in editor.
	create_free_cam_player = true, -- Project will provide its own player.
	exit_standalone_with_esc_key = true
}

-- Optional function by SimpleProject after level, world and player is loaded 
-- but before lua trigger level loaded node is activated.
function Project.on_level_load_pre_flow()
    math.randomseed( os.time() )
    local labyrinthGid = Grid()
    labyrinthGid:CreateGrid(15, 20)
    
   -- stingray.Level.trigger_event(SimpleProject.level, "explosion")
    
end

-- Optional function by SimpleProject after loading of level, world and player and 
-- triggering of the level loaded flow node.
function Project.on_level_shutdown_post_flow()
end

-- Optional function called by SimpleProject after world update (we will probably want to split to pre/post appkit calls)
function Project.update(dt)
end

-- Optional function called by SimpleProject *before* appkit/world render
function Project.render()
end

-- Optional function called by SimpleProject *before* appkit/level/player/world shutdown
function Project.shutdown()
end

function Project.CallFromFlow(aFlowVar)
   print("I was called from flow") 
   
   --set
   local levelStuffs = SimpleProject.level
   stingray.Level.set_flow_variable(levelStuffs, "in_flowvariable", aFlowVar)
   
   --get
   local variableFromFlow = stingray.Level.flow_variable(levelStuffs, "out_flowvariable")
   
   --print
   print(variableFromFlow)
   
end

return Project
