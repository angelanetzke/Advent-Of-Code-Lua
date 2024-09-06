local function getLocationString(x, y)
	return x .. "," .. y
end

local function part1(allLines)
	local directions = {}
	for token in string.gmatch(allLines[1], "[^ ,]+") do
		directions[#directions + 1] = token
	end
	local turns = {}
	turns["NL"] = "W"
	turns["NR"] = "E"
	turns["SL"] = "E"
	turns["SR"] = "W"
	turns["WL"] = "S"
	turns["WR"] = "N"
	turns["EL"] = "N"
	turns["ER"] = "S"
	local facing = "N"
	local x = 0
	local y = 0
	for _, thisDirection in ipairs(directions) do
		facing = turns[facing .. string.sub(thisDirection, 1, 1)]
		local distance =  tonumber(string.sub(thisDirection, 2))
		if facing == "N" then
			y = y - distance
		elseif facing == "S" then
			y = y + distance
		elseif facing == "W" then
			x = x - distance
		elseif facing == "E" then
			x = x + distance
		end
	end
	return math.abs(x) + math.abs(y)
end

local function part2(allLines)
	local directions = {}
	for token in string.gmatch(allLines[1], "[^ ,]+") do
		directions[#directions + 1] = token
	end
	local visited = {}
	visited[getLocationString(0, 0)] = true
	local turns = {}
	turns["NL"] = "W"
	turns["NR"] = "E"
	turns["SL"] = "E"
	turns["SR"] = "W"
	turns["WL"] = "S"
	turns["WR"] = "N"
	turns["EL"] = "N"
	turns["ER"] = "S"
	local facing = "N"
	local x = 0
	local y = 0
	for _, thisDirection in ipairs(directions) do
		facing = turns[facing .. string.sub(thisDirection, 1, 1)]
		local distance =  tonumber(string.sub(thisDirection, 2))
		for _ = 1, distance do
			if facing == "N" then
				y = y - 1
			elseif facing == "S" then
				y = y + 1
			elseif facing == "W" then
				x = x - 1
			elseif facing == "E" then
				x = x + 1
			end
			if visited[getLocationString(x, y)] ~= nil then
				return math.abs(x) + math.abs(y)
			end
			visited[getLocationString(x, y)] = true
		end
	end
	return -1
end

io.input("input/input01.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))