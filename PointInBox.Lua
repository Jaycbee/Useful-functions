
--//Ported to lua from https://stackoverflow.com/questions/21037241/how-to-determine-a-point-is-inside-or-outside-a-cube
--//Returns if given vector is within the cube/box
local function PointInBox(Point,Cube)
	local Size = Cube.Size * .5
	local CF = Cube.CFrame
	local B1 = CF * Vector3.new(Size.X, -Size.Y, -Size.Z)
  local B2 = CF * -Size
  local B3 = CF *  Vector3.new(-Size.X, -Size.Y, Size.Z)
  local T1 = CF * Vector3.new(Size.X, Size.Y, -Size.Z)
 	
	Point = CFrame.new(Cube.Position):VectorToObjectSpace(Point)

	local DirX = B1 - B2
  local SizeX = DirX.Magnitude 
	DirX = DirX/DirX.Magnitude 

	local DirY = B3 - B2
	local SizeY = DirY.Magnitude 
	DirY= DirY/SizeY
	
	local  DirZ = T1 - B1
	local SizeZ = DirZ.Magnitude
	DirZ = DirZ/SizeZ
	
	local DirVec = Point - Cube.Position

	local X = math.abs(DirVec:Dot(DirX) * 2) <= SizeX
	local Y = math.abs(DirVec:Dot(DirY) * 2) <= SizeY
	local Z = math.abs(DirVec:Dot(DirZ) * 2) <= SizeZ
  return  X and Y and Z
end
