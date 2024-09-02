local function isHorizonal(segmentData)
	local pointData = {}
	for x in string.gmatch(segmentData, "%d+") do
		pointData[#pointData + 1] = tonumber(x)
	end
	return pointData[2] == pointData[4]
end

local function isVertical(segmentData)
	local pointData = {}
	for x in string.gmatch(segmentData, "%d+") do
		pointData[#pointData + 1] = tonumber(x)
	end
	return pointData[1] == pointData[3]
end

local function addPoint(segmentData, points)
	local pointData = {}
	for x in string.gmatch(segmentData, "%d+") do
		pointData[#pointData + 1] = tonumber(x)
	end
	local x1 = pointData[1]
	local y1 = pointData[2]
	local x2 = pointData[3]
	local y2 = pointData[4]
	local thisX = x1
	local thisY = y1
	local isComplete = false
	while not isComplete do
		local pointString = thisX .. "," .. thisY
		if points[pointString] == nil then
			points[pointString] = 1
		else
			points[pointString] = points[pointString] + 1
		end
		isComplete = thisX == x2 and thisY == y2
		if x1 ~= x2 then
			thisX = thisX + (x2 - x1) / math.abs(x2 - x1)
		end
		if y1 ~= y2 then
			thisY = thisY + (y2 - y1) / math.abs(y2 - y1)
		end		
	end
end

local function part1(allLines)
	local points = {}
	for _, thisLine in ipairs(allLines) do
		if isHorizonal(thisLine) then
			addPoint(thisLine, points)
		end
		if isVertical(thisLine) then
			addPoint(thisLine, points)
		end
	end
	local intersectionCount = 0
	for _, value in pairs(points) do
		if value > 1 then
			intersectionCount = intersectionCount + 1
		end
	end
	return intersectionCount
end

local function part2(allLines)
	local points = {}
	for _, thisLine in ipairs(allLines) do
		addPoint(thisLine, points)
	end
	local intersectionCount = 0
	for _, value in pairs(points) do
		if value > 1 then
			intersectionCount = intersectionCount + 1
		end
	end
	return intersectionCount
end

io.input("input/input05.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))