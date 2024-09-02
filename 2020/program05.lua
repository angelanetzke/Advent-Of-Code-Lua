local function decode(seatString)
	local lower = 0
	local upper = 127
	for i = 1, 7 do
		if string.sub(seatString, i, i) == "F" then
			upper = (lower + upper + 1) / 2 - 1
		else
			lower = (lower + upper + 1) / 2
		end
	end
	local row = lower
	lower = 0
	upper = 7
	for i = 8, 10 do
		if string.sub(seatString, i, i) == "L" then
			upper = (lower + upper + 1) / 2 - 1
		else
			lower = (lower + upper + 1) / 2
		end
	end
	local seat = lower
	return row * 8 + seat
end

local function part1(allLines)
	local maxSeat = -1
	for _, thisLine in ipairs(allLines) do
		local thisSeat = decode(thisLine)
		maxSeat = math.max(maxSeat, thisSeat)
	end
	return maxSeat
end

local function part2(allLines)
	local minSeat = 1024
	local maxSeat = -1
	local seatsTaken = {}
	for _, thisLine in ipairs(allLines) do
		local thisSeat = decode(thisLine)
		seatsTaken[thisSeat] = true
		minSeat = math.min(minSeat, thisSeat)
		maxSeat = math.max(maxSeat, thisSeat)
	end
	for i = minSeat, maxSeat do
		if seatsTaken[i] == nil then
			return i
		end
	end
	return -1
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