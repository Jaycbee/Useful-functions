
  local function Find(Table, Value, cacheresult )
    if  cache[Table]== nil  then
		cache[Table]  = {}
    end
 if  cacheresult and cache[Table][Value] then
		if table.find(cache[Table][Value], Value )then 
	return cache[Table][Value] 	
		else
		cache[Table][Value] 	= nil
	  end
  end
 local FoundTable
   local function Recurse (t, val)
		for index, v in pairs(t) do
			if v == val then
				cache[Table][val] = t
				  FoundTable = t
				      break
			  elseif typeof(v) == "table" then
			if table.find(v, val) then
			cache[Table][val] = v
			        FoundTable = v
					break
				  elseif FoundTable == nil then
				Recurse(v,val )
					else
				break
			end
		 end
		end
	 end
      Recurse(Table,Value)	
   return FoundTable
end
