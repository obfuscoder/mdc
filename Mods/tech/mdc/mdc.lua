dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV)

local WHITE = MakeMaterial(nil, { 255, 255, 255, 255 })
local BLACK = MakeMaterial(nil, { 0, 0, 0, 255 })
local GREY = MakeMaterial(nil, { 200, 200, 200, 255 })
local FONT = MakeFont({ used_DXUnicodeFontData = "font_dejavu_lgc_sans_condensed_17" }, { 0, 0, 0, 255 })
local BOLD_FONT = MakeFont({ used_DXUnicodeFontData = "font_dejavu_lgc_sans_condensed_Bold_17" }, { 0, 0, 0, 255 })

local WIDTH = 1
local HEIGHT = WIDTH * GetAspect()

local AREA = 0.95

local ROWS = 30

columns = 12

function frame(top, left, bottom, right)
	local frame  = CreateElement("ceMeshPoly")
	frame.material = BLACK
	frame.primitivetype = "lines"
	frame.vertices = {{ left, top }, { right, top }, { right, bottom }, { left, bottom }}
	frame.indices = { 0, 1, 1, 2, 2, 3, 3, 0 }
	frame.level = DEFAULT_LEVEL
	frame.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	frame.blend_mode = blend_mode.IBM_REGULAR
	frame.use_mipfilter = true
	Add(frame)
end

function text(v_center, h_center, text, font)
	local txt = CreateElement "ceStringPoly"
	txt.value = text
	txt.material = font or FONT
	txt.init_pos = { h_center, v_center }
	txt.alignment = "CenterCenter"
	txt.stringdefs = { 0.005, 0.0013, 0, 0 }
	txt.use_mipfilter = true
	txt.h_clip_relation = h_clip_relations.COMPARE
	txt.level = DEFAULT_LEVEL
	Add(txt)
end	

function bg(top, left, bottom, right, color)
	local background = CreateElement "ceMeshPoly"
	background.material = color
	background.vertices = {{ left, top }, { right, top }, { right, bottom }, { left, bottom }}
	background.indices = { 0, 1, 2; 0, 2, 3 }
	background.level = DEFAULT_LEVEL
	background.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	background.blend_mode = blend_mode.IBM_REGULAR
	background.use_mipfilter = true
	Add(background)
end

function multicell(top_row, left_column, bottom_row, right_column, txt, font, background)
	local top = (top_row/ROWS - 0.5) * -2 * HEIGHT * AREA
	local bottom = ((bottom_row+1)/ROWS - 0.5) * -2 * HEIGHT * AREA
	local left = (left_column/columns - 0.5) * 2 * WIDTH * AREA
	local right = ((right_column+1)/columns - 0.5) * 2 * WIDTH * AREA

	if background ~= nil then
		bg(top, left, bottom, right, background)
	end

	frame(top, left, bottom, right)

	local v_center = (((bottom_row+top_row)/2+0.5)/ROWS - 0.5) * -2 * HEIGHT * AREA
	local h_center = (((left_column+right_column)/2+0.5)/columns - 0.5) * 2 * WIDTH * AREA

	text(v_center, h_center, txt, font)
end

function cell(row, column, text, font, background)
	multicell(row, column, row, column, text, font, background)
end

function head(row, column, text)
	cell(row, column, text, BOLD_FONT, GREY)
end

function multihead(top_row, left_column, bottom_row, right_column, text)
	multicell(top_row, left_column, bottom_row, right_column, text, BOLD_FONT, GREY)
end

function headline(row, text)
	multicell(row, 0, row, columns-1, text, BOLD_FONT, GREY)
end

function texture_box(UL_X, UL_Y, W, H)
	local UL_X = UL_X or 0
	local UL_Y = UL_Y or 0
	local W = W or 1
	local H = H or 1
	return  {
		{ UL_X, UL_Y },
		{ UL_X + W, UL_Y },
		{ UL_X + W, UL_Y + H },
		{ UL_X, UL_Y + H }
	}
end

function image(path, UL_X, UL_Y, W, H, tx_ULX, tx_ULY, tx_W, tx_H)
	local USER_PICTURE = MakeMaterial(path, { 255, 255, 255, 255 })
	local width = W
	local height = H

	if width == nil then
   		width = 2
	end

	if height == nil then
   		height =  2 * GetAspect()
	end

	local UL_X = UL_X or 0
	local UL_Y = UL_Y or 0

	local back = CreateElement "ceTexPoly"
	back.name = create_guid_string()
	back.material = USER_PICTURE
	back.init_pos = { UL_X - 1, GetAspect() - UL_Y }
	back.vertices = {
		{ 0, 0 },
		{ width, 0 },
		{ width, -height },
		{ 0, -height }
	}
	back.indices = { 0, 1, 2; 0, 2, 3 }
	back.tex_coords = texture_box(tx_ULX, tx_ULY, tx_W, tx_H)
	back.h_clip_relation = h_clip_relations.COMPARE
	back.level = DEFAULT_LEVEL
	Add(back)
end

function plate(path)
	image(path, 0, 0,
	1.35 * GetAspect(), -- horizontal size
	2 * GetAspect(), --vertical size
	0, 0, 1, 1)
end

bg(-HEIGHT, -WIDTH, HEIGHT, WIDTH, WHITE)
