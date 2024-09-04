local Claim = {}

function Claim:new(o, claimData)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	local temp = {}
	for token in string.gmatch(claimData, "%d+") do
		temp[#temp + 1] = tonumber(token)
	end
	o.id = temp[1]
	o.x1 = temp[2]
	o.y1 = temp[3]
	o.x2 = temp[2] + temp[4] - 1
	o.y2 = temp[3] + temp[5] - 1
	return o
end

function Claim:doesOverlap(other)
	return math.max(self.x1, other.x1) <= math.min(self.x2, other.x2)
		and math.max(self.y1, other.y1) <= math.min(self.y2, other.y2)
end

local function getLocationString(x, y)
	return string.format("%05d", x) .. string.format("%05d", y)
end

local function part1(allLines)
	local claimList = {}
	for _, thisLine in ipairs(allLines) do
		claimList[#claimList + 1] = Claim:new(nil, thisLine)
	end
	local points = {}
	for _, thisClaim in ipairs(claimList) do
		for x = thisClaim.x1, thisClaim.x2 do
			for y = thisClaim.y1, thisClaim.y2 do
				if points[getLocationString(x, y)] == nil then
					points[getLocationString(x, y)] = 1
				else
					points[getLocationString(x, y)] = points[getLocationString(x, y)] + 1
				end
			end
		end
	end
	local overlapCount = 0
	for _, value in pairs(points) do
		if value > 1 then
			overlapCount = overlapCount + 1
		end
	end
	return overlapCount
end

local function part2(allLines)
	local claimList = {}
	for _, thisLine in ipairs(allLines) do
		claimList[#claimList + 1] = Claim:new(nil, thisLine)
	end
	local overlapCount = 0
	for i = 1, #claimList do
		overlapCount = 0
		for j = 1, #claimList do
			if i ~= j and claimList[i]:doesOverlap(claimList[j]) then
				overlapCount = overlapCount + 1
			end
		end
		if overlapCount == 0 then
			return claimList[i].id
		end
	end
	return -1
end

io.input("input/input03.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))