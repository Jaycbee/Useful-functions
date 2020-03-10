
local Character = game.Players.LocalPlayer.Character
local TouchThreadActive = {}
local TestTable = {}



local function ConnectTouched(Subject, TrackParts,TouchingParts )
	for _,v in ipairs(Subject:GetChildren()) do
		if v:IsA("BasePart") then
			table.insert(TrackParts,v )
			v.Touched:Connect(function(part)
				if not part:IsDescendantOf(Subject) then
				 	TouchingParts[part] = tick()
				 end
			end)	
		end
	end
end

local function Track(Subject, TouchingParts, TrackParts)
	local TempTable = {}
	for _, Tpart in ipairs(TrackParts) do
		local GetTouchingParts = Tpart:GetTouchingParts()
		for  part, _ in pairs(TouchingParts) do
			local Part = GetTouchingParts[table.find(GetTouchingParts, part)]
			 if Part then
			 TempTable[Part] = tick()
		  end
	    end
	end
  return TempTable
end


local function TouchedEnded(Subject,CallBack, thresh)
 TouchThreadActive[Subject] = true
    coroutine.resume(coroutine.create(function()
	local TouchingParts = {}
     local TrackParts = {}
       ConnectTouched(Subject, TrackParts, TouchingParts)
	      while TouchThreadActive[Subject] do
	   	wait()
		  local CurrTouchingParts = Track(Subject,TouchingParts,TrackParts )
		  local TouchedEndedParts = {}
		    for Prevpart, _ in pairs(TouchingParts) do
	          if not CurrTouchingParts[Prevpart]  then
		       if math.abs((tick()  - TouchingParts[Prevpart])) > (thresh or .3) then
	         	table.insert(TouchedEndedParts,Prevpart )
	           TouchingParts[Prevpart] = nil
		    end
		  end
		end
		CallBack(TouchedEndedParts, TouchingParts)
	  end
  end))
end


local function test(NotTouchingparts, Parts) 
  for _, Parts in pairs(Parts) do
	if _ ~= game.Workspace.Baseplate then 
		if TestTable[_] == nil then
	        _.CanCollide = false
	      TestTable[_] = true
	      end
	  end
   end

  for _, v in ipairs(NotTouchingparts ) do
	  v.CanCollide = true
   end
end

TouchedEnded(Character, test)
