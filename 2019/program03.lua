Intersections = {}

local function getPointString(x, y)
	return string.format("%05d", x) .. "," .. string.format("%05d", y)
end

local function part1(allLines)
	local wire1 = {}
	local wire2 = {}
	for token in string.gmatch(allLines[1], "[^,]+") do
		wire1[#wire1 + 1] = token
	end
	for token in string.gmatch(allLines[2], "[^,]+") do
		wire2[#wire2 + 1] = token
	end
	local points = {}
	local x = 0
	local y = 0
	for _, thisStep in ipairs(wire1) do
		local direction = string.sub(thisStep, 1, 1)
		local distance = tonumber(string.sub(thisStep, 2))
		for i = 1, distance do
			if direction == "U" then
				y = y + 1
			elseif direction == "D" then
				y = y - 1
			elseif direction == "L" then
				x = x - 1
			elseif direction == "R" then
				x = x + 1
			end
			points[getPointString(x, y)] = 1
		end
	end
	x = 0
	y = 0
	for _, thisStep in ipairs(wire2) do
		local direction = string.sub(thisStep, 1, 1)
		local distance = tonumber(string.sub(thisStep, 2))
		for i = 1, distance do
			if direction == "U" then
				y = y + 1
			elseif direction == "D" then
				y = y - 1
			elseif direction == "L" then
				x = x - 1
			elseif direction == "R" then
				x = x + 1
			end
			if points[getPointString(x, y)] == 1 then
				points[getPointString(x, y)] = 2
			end
		end
	end
	for key, value in pairs(points) do
		if value == 2 then
			Intersections[#Intersections + 1] = key
		end
	end
	local closestDistance = -1
	for _, thisPoint in ipairs(Intersections) do
		local temp = {}
		for token in string.gmatch(thisPoint, "[^,]+") do
			temp[#temp + 1] = token
		end
		local pointX = tonumber(temp[1]) or 0
		local pointY = tonumber(temp[2]) or 0
		local distanceToPoint = math.abs(pointX) + math.abs(pointY)
		if closestDistance == -1 or distanceToPoint < closestDistance then
			closestDistance = distanceToPoint
		end
	end
	return closestDistance
end

local function part2(allLines)
	local wire1 = {}
	local wire2 = {}
	for token in string.gmatch(allLines[1], "[^,]+") do
		wire1[#wire1 + 1] = token
	end
	for token in string.gmatch(allLines[2], "[^,]+") do
		wire2[#wire2 + 1] = token
	end
	local distances = {}
	local x = 0
	local y = 0
	local stepCount = 0
	for _, thisStep in ipairs(wire1) do
		local direction = string.sub(thisStep, 1, 1)
		local distance = tonumber(string.sub(thisStep, 2))
		for i = 1, distance do
			if direction == "U" then
				y = y + 1
			elseif direction == "D" then
				y = y - 1
			elseif direction == "L" then
				x = x - 1
			elseif direction == "R" then
				x = x + 1
			end
			stepCount = stepCount + 1
			for _, thisPoint in ipairs(Intersections) do
				if thisPoint == getPointString(x, y) then
					distances[thisPoint] = {stepCount, 0}
				end
			end
		end
	end
	x = 0
	y = 0
	stepCount = 0
	for _, thisStep in ipairs(wire2) do
		local direction = string.sub(thisStep, 1, 1)
		local distance = tonumber(string.sub(thisStep, 2))
		for i = 1, distance do
			if direction == "U" then
				y = y + 1
			elseif direction == "D" then
				y = y - 1
			elseif direction == "L" then
				x = x - 1
			elseif direction == "R" then
				x = x + 1
			end
			stepCount = stepCount + 1
			for _, thisPoint in ipairs(Intersections) do
				if thisPoint == getPointString(x, y) then
					distances[thisPoint][2] = stepCount
				end
			end
		end
	end
	local closestDistance = -1
	for _, value in pairs(distances) do
		if closestDistance == -1 or value[1] + value[2] < closestDistance then
			closestDistance = value[1] + value[2]
		end
	end
	return closestDistance
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