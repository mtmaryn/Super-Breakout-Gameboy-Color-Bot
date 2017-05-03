
-- Compatibility of the memory read/write functions
local u8 =  mainmemory.read_u8
local s8 =  mainmemory.read_s8
local w8 =  mainmemory.write_u8
local u16 = mainmemory.read_u16_le
local s16 = mainmemory.read_s16_le
local w16 = mainmemory.write_u16_le
local u24 = mainmemory.read_u24_le
local s24 = mainmemory.read_s24_le
local w24 = mainmemory.write_u32_le

-- Others
local screen_x = 160.0
local screen_y = 144.0


WRAM = {
	--PADDLE STUFF
	paddle_left = 0x0001,
	paddle_center = 0x0005,
	paddle_right = 0x0009,
	paddle_velo = 0x1FE2,
	
	ball_y = 0x0018,
	ball_x = 0x0019,
	
	is_there_a_ball = 0x0127
}
local WRAM = WRAM

function getStuff()
	pl = u8(WRAM.paddle_left)-8
    pm = u8(WRAM.paddle_center)
	pr = u8(WRAM.paddle_right)-1
	ps = u8(WRAM.paddle_velo)
	
	by = u8(WRAM.ball_y) - 16
	by2 = by + 8
	bx = u8(WRAM.ball_x) - 8
	bx2 = bx + 8
	
	yesNo = u8(WRAM.is_there_a_ball)
	
	gui.text(0,0,"Z: ".. by2)
end

function movement()
	t=joypad.get()
	
	t["A"] = true
	if by > 60  then
		theLine = true
	else
		theLine = false
	end	
	
	if yesNo == 1 then
		t["B"] = true
	else
		t["B"] = false
	end
	
	if bx < pl and theLine then
		t["Left"] = true
	elseif bx > pm then
		t["Left"] = false
	end
		
	if bx2 > pr and theLine then
		t["Right"] = true
	elseif bx2 < pm then
		t["Right"] = false
	end
	
	joypad.set(t)
end

while true do
	getStuff()
	movement()
	gui.drawBox(pl, screen_y-8, pr, screen_y, 0xFF000000, 0x80808080)
	--gui.drawBox(0, by, screen_x, by+8, 0xFF000000, 0x80808080)
	gui.drawBox(bx, by, bx2, by2, 0xFF000000, 0x80808080)
	emu.frameadvance()
end