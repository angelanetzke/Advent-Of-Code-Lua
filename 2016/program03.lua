local function isTriangle (side1, side2, side3)
	return side1 < side2 + side3 and side2 < side1 + side3 and side3 < side1 + side2
end

local function part1(allLines)
	local triangleCount = 0
	for _, thisLine in ipairs(allLines) do
		local sides = {}
		for token in string.gmatch(thisLine, "%d+") do
			sides[#sides + 1] = tonumber(token)
		end
		if isTriangle(sides[1], sides[2], sides[3]) then
			triangleCount = triangleCount + 1
		end
	end
	return triangleCount
end

local function part2(allLines)
	local triangleCount = 0
	for i = 1, #allLines - 2, 3 do
		local sides = {}
		for j = 0, 2 do
			sides[j] = {}
			local column = 0
			for token in string.gmatch(allLines[i + j], "%d+") do
				sides[j][column] = tonumber(token)
				column = column + 1
			end
		end
		for j = 0, 2 do
			if isTriangle(sides[0][j], sides[1][j], sides[2][j]) then
				triangleCount = triangleCount + 1
			end
		end
	end
	return triangleCount
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