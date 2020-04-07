local function LocalMousePos(MousePos,Viewport)
	local MouseX = MousePos.X - Viewport.AbsolutePosition.X
	local MouseY = MousePos.Y - Viewport.AbsolutePosition.Y
	return Vector2.new(MouseX, MouseY)
end
