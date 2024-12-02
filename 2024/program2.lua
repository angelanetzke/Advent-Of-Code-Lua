local function reduceTable(t, skip)
	local reduced = {}
	for i = 1, #t do
		if i ~= skip then
			table.insert(reduced, t[i])
		end
	end
	return reduced
end

local function isSafe(report)
	local direction = 0
	for i = 2, #report do
		local delta = report[i] - report[i - 1]
		if delta == 0 then
			return false
		end
		if direction == 0 then
			direction = delta / math.abs(delta)
		end
		if delta / math.abs(delta) ~= direction then
			return false
		end
		if math.abs(delta) < 1 or math.abs(delta) > 3 then
			return false
		end
	end
	return true
end

local function part1(allLines, unsafeList)
	local safeCount = 0
	for i = 1, #allLines do
		local report = {}
		for j in string.gmatch(allLines[i], "%d+") do
			table.insert(report, tonumber(j))
		end
		if isSafe(report) then
			safeCount = safeCount + 1
		else
			table.insert(unsafeList, report)
		end
	end
	return safeCount
end

local function part2(unsafeList)
	local safeCount = 0
	for i = 1, #unsafeList do
		for j = 1, #unsafeList[i] do
			local reduced = reduceTable(unsafeList[i], j)
			if isSafe(reduced) then
				safeCount = safeCount + 1
				break
			end
		end
	end
	return safeCount
end

io.input("input/input2.txt")
local allLines = {}
local i = 1
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[i] = nextLine
	i = i + 1
	nextLine = io.read("*line")
end
local unsafeList = {}
local part1Result = part1(allLines, unsafeList)
print("Part 1: " .. part1Result)
print("Part 2: " .. part2(unsafeList) + part1Result)