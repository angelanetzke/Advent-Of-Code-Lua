local function mapToNewValues(oldValues, mapper)
	local newValues = {}
	for _, v in ipairs(oldValues) do
		newValues[#newValues + 1] = v
		for _, m in ipairs(mapper) do
			if m[2] <= v and v <= m[2] + m[3] - 1 then
				newValues[#newValues] = m[1] + v - m[2]
			end
		end
	end
	return newValues
end

local function mapToNewRanges(oldRanges, mapper)
	table.sort(mapper, function(a, b)
		return a[2] < b[2]
	end)
	local newRanges = {}
	for _, r in ipairs(oldRanges) do
		local rangeStart = r[1]
		local rangeEnd = r[2]
		for _, m in ipairs(mapper) do
			if rangeStart <= rangeEnd and rangeStart < m[2] then
				newRanges[#newRanges + 1] = {rangeStart, math.min(rangeEnd, m[2] - 1)}
				rangeStart = math.min(rangeEnd, m[2] - 1) + 1
			end
			if rangeStart <= rangeEnd and m[2] <= rangeStart and rangeStart <= m[2] + m[3] - 1 then
				newRanges[#newRanges + 1] = {m[1] + math.max(rangeStart, m[2]) - m[2], m[1] + math.min(rangeEnd, m[2] + m[3] - 1) - m[2]}
				rangeStart = math.min(rangeEnd, m[2] + m[3] - 1) + 1
			end
		end
		if rangeStart <= rangeEnd then
			newRanges[#newRanges + 1] = {rangeStart, rangeEnd}
		end
	end
	return newRanges
end

local function part1(allLines)
	local values = {}
	local mapper = {}
	for num in string.gmatch(allLines[1], "%d+") do
    values[#values + 1] = tonumber(num)
	end
	for _, thisLine in ipairs(allLines) do
		if string.find(thisLine, "map:") then
			mapper = {}
		elseif string.match(thisLine, "^%d+ %d+ %d+$") then
			mapper[#mapper + 1] = {}
			for num in string.gmatch(thisLine, "%d+") do
				table.insert(mapper[#mapper], tonumber(num))
			end
		elseif #thisLine == 0 and #mapper > 0 then
			values = mapToNewValues(values, mapper)
		end
	end
	values = mapToNewValues(values, mapper)
	table.sort(values)
	return values[1]
end

local function part2(allLines)
	local ranges = {}
	local mapper = {}
	local temp = {}
	for num in string.gmatch(allLines[1], "%d+") do
    temp[#temp + 1] = tonumber(num)
	end
	for i = 1, #temp - 1, 2 do
		ranges[math.floor(i / 2) + 1] = {temp[i], temp[i] + temp[i + 1] - 1}
	end
	for _, thisLine in ipairs(allLines) do
		if string.find(thisLine, "map:") then
			mapper = {}
		elseif string.match(thisLine, "^%d+ %d+ %d+$") then
			mapper[#mapper + 1] = {}
			for num in string.gmatch(thisLine, "%d+") do
				table.insert(mapper[#mapper], tonumber(num))
			end
		elseif #thisLine == 0 and #mapper > 0 then
			ranges = mapToNewRanges(ranges, mapper)
		end
	end
	ranges = mapToNewRanges(ranges, mapper)
	table.sort(ranges, function(a, b)
		return a[1] < b[1]
	end)
	return ranges[1][1]
end

io.input("input/input05.txt")
local allLines = {}
local i = 1
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[i] = nextLine
	i = i + 1
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))

