--[[
-- This is basically just a copy of !BeatyCase by someone. I forgot who.
-- Whoever it was, he/she wrote this thanks to Phanx;
-- Thanks to Phanx (http://www.wowinterface.com/list.php?skinnerid=28751) for the idea and help.
]]

local textureNormal = "Interface\\AddOns\\RabbitCommon\\media\\textureNormal"
local textureShadow = "Interface\\AddOns\\RabbitCommon\\media\\textureShadow"

local function createBorder(self, size, r, g, b)
	local border = self:CreateTexture(nil, "BORDER")
	border:SetTexture(textureNormal)
	border:SetWidth(size)
	border:SetHeight(size)
	border:SetVertexColor(r or 1, g or 1, b or 1)
	return border
end

local function createShadow(self, size)
	local shadow = self:CreateTexture(nil, "BORDER")
	shadow:SetTexture(textureShadow)
	shadow:SetWidth(size)
	shadow:SetHeight(size)
	shadow:SetVertexColor(0, 0, 0, 1)
	return shadow
end

local borders = {}
local shadows = {}

function CreateBorder(self, borderSize, R, G, B, ...)
	local uL1, uL2, uR1, uR2, bL1, bL2, bR1, bR2 = ...

	for i = 1, 8 do
		local border = createBorder(self, borderSize, R, G, B)
		borders[i] = border
		if i == 1 then
			border:SetTexCoord(0, 1/3, 0, 1/3) 
			border:SetPoint("TOPLEFT", self, -(uL1 or 0), uL2 or 0)
		elseif i == 2 then
			border:SetTexCoord(2/3, 1, 0, 1/3)
			border:SetPoint("TOPRIGHT", self, uR1 or 0, uR2 or 0)
		elseif i == 3 then
			border:SetTexCoord(0, 1/3, 2/3, 1)
			border:SetPoint("BOTTOMLEFT", self, -(bL1 or 0), -(bL2 or 0))
		elseif i == 4 then
			border:SetTexCoord(2/3, 1, 2/3, 1)
			border:SetPoint("BOTTOMRIGHT", self, bR1 or 0, -(bR2 or 0))
		elseif i == 5 then
			border:SetTexCoord(1/3, 2/3, 0, 1/3)
			border:SetPoint("TOPLEFT", borders[1], "TOPRIGHT")
			border:SetPoint("TOPRIGHT", borders[2], "TOPLEFT")
		elseif i == 6 then
			border:SetTexCoord(1/3, 2/3, 2/3, 1)
			border:SetPoint("BOTTOMLEFT", borders[3], "BOTTOMRIGHT")
			border:SetPoint("BOTTOMRIGHT", borders[4], "BOTTOMLEFT")
		elseif i == 7 then
			border:SetTexCoord(0, 1/3, 1/3, 2/3)
			border:SetPoint("TOPLEFT", borders[1], "BOTTOMLEFT")
			border:SetPoint("BOTTOMLEFT", borders[3], "TOPLEFT")
		elseif i == 8 then
			border:SetTexCoord(2/3, 1, 1/3, 2/3)
			border:SetPoint("TOPRIGHT", borders[2], "BOTTOMRIGHT")
			border:SetPoint("BOTTOMRIGHT", borders[4], "TOPRIGHT")
		end
	end
	wipe(borders)

	local space
	if borderSize >= 10 then
		space = 3
	else
		space = borderSize / 3.5
	end

	for i = 1, 8 do
		local shadow = createShadow(self, borderSize)
		shadows[i] = shadow

		if i == 1 then
			shadow:SetTexCoord(0, 1/3, 0, 1/3) 
			shadow:SetPoint("TOPLEFT", self, -(uL1 or 0)-space, (uL2 or 0)+space)
		elseif i == 2 then
			shadow:SetTexCoord(2/3, 1, 0, 1/3)
			shadow:SetPoint("TOPRIGHT", self, (uR1 or 0)+space, (uR2 or 0)+space)
		elseif i == 3 then
			shadow:SetTexCoord(0, 1/3, 2/3, 1)
			shadow:SetPoint("BOTTOMLEFT", self, -(bL1 or 0)-space, -(bL2 or 0)-space)
		elseif i == 4 then
			shadow:SetTexCoord(2/3, 1, 2/3, 1)
			shadow:SetPoint("BOTTOMRIGHT", self, (bR1 or 0)+space, -(bR2 or 0)-space)
		elseif i == 5 then
			shadow:SetTexCoord(1/3, 2/3, 0, 1/3)
			shadow:SetPoint("TOPLEFT", shadows[1], "TOPRIGHT")
			shadow:SetPoint("TOPRIGHT", shadows[2], "TOPLEFT")
		elseif i == 6 then
			shadow:SetTexCoord(1/3, 2/3, 2/3, 1)
			shadow:SetPoint("BOTTOMLEFT", shadows[3], "BOTTOMRIGHT")
			shadow:SetPoint("BOTTOMRIGHT", shadows[4], "BOTTOMLEFT")
		elseif i == 7 then
			shadow:SetTexCoord(0, 1/3, 1/3, 2/3)
			shadow:SetPoint("TOPLEFT", shadows[1], "BOTTOMLEFT")
			shadow:SetPoint("BOTTOMLEFT", shadows[3], "TOPLEFT")
		elseif i == 8 then
			shadow:SetTexCoord(2/3, 1, 1/3, 2/3)
			shadow:SetPoint("TOPRIGHT", shadows[2], "BOTTOMRIGHT")
			shadow:SetPoint("BOTTOMRIGHT", shadows[4], "TOPRIGHT")
		end
	end
	wipe(shadows)
end

