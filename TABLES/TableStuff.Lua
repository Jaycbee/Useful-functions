

local T = function(t,...) 
  setmetatable(t,t)
  t. __newindex = function(Table, index, value)
	rawset(Table, #Table + 1, {index, value})
   end
return t
end


local function OPairs(t)	
       local i = 0 
     return function()
         i = i + 1
         if t[i] then
	     if typeof(t[i]) == "number" then
		return i, t[i]
       	end
         return t[i][1] or i , t[i][2] or t[i]
        end
   end
end



local function RePairs(Table)
local FT = {}
 local function Re(t)
	for _, v in pairs(t) do
		if typeof(v) == "table" then
			Re(v)
			 else
		    table.insert(FT, {_, v} )	 		
		end
	  end
     end
Re(Table)
local i = 0
   return function()
	i = i + 1
	if FT[i] then
		if typeof(FT[i]) == 'table' then
		return FT[i][1], FT[i][2]
			else
		return i ,FT[i]
	  end
	end
   end
end

local t = {5,{test = 4}}



for _,v in RePairs(t) do
	print(_,v)
end
