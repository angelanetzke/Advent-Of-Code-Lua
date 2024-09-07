local function getLocationString(x, y)
	return x .. "," .. y
end

local function part1(allLines)
	local visited = {}
	visited[getLocationString(0, 0)] = true
	local directions = allLines[1]
	local x = 0
	local y = 0
	for i = 1, #directions do
		local thisDirection = string.sub(directions, i, i)
		if thisDirection == "^" then
			y = y - 1
		elseif thisDirection == "v" then
			y = y + 1
		elseif thisDirection == "<" then
			x = x - 1
		elseif thisDirection == ">" then
			x = x + 1
		end
		if visited[getLocationString(x, y)] == nil then
			visited[getLocationString(x, y)] = true
		end
	end
	local count = 0
	for _, _ in pairs(visited) do
		count = count + 1
	end
	return count
end

local function part2(allLines)
	local visited = {}
	visited[getLocationString(0, 0)] = true
	local directions = allLines[1]
	local santaX = 0
	local santaY = 0
	local robotX = 0
	local robotY = 0
	for i = 1, #directions - 1, 2 do
		local thisDirection = string.sub(directions, i, i)
		if thisDirection == "^" then
			santaY = santaY - 1
		elseif thisDirection == "v" then
			santaY = santaY + 1
		elseif thisDirection == "<" then
			santaX = santaX - 1
		elseif thisDirection == ">" then
			santaX = santaX + 1
		end
		if visited[getLocationString(santaX, santaY)] == nil then
			visited[getLocationString(santaX, santaY)] = true
		end
		thisDirection = string.sub(directions, i + 1, i + 1)
		if thisDirection == "^" then
			robotY = robotY - 1
		elseif thisDirection == "v" then
			robotY = robotY + 1
		elseif thisDirection == "<" then
			robotX = robotX - 1
		elseif thisDirection == ">" then
			robotX = robotX + 1
		end
		if visited[getLocationString(robotX, robotY)] == nil then
			visited[getLocationString(robotX, robotY)] = true
		end
	end
	local count = 0
	for _, _ in pairs(visited) do
		count = count + 1
	end
	return count
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