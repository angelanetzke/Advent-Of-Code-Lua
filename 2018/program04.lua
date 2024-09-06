local guardSummary = {}

local function part1(allLines)
	local log = {}
	for _, thisLine in ipairs(allLines) do
		local timestamp = string.match(thisLine, "%[(.+)%]")
		local activity = string.match(thisLine, "%] (.+)")
		log[#log + 1] = {timestamp, activity}
	end
	table.sort(log, function(a, b)
		return a[1] < b[1]
	end)
	local guardSleepCounts = {}
	local currentGuard = ""
	local i = 1
	while i <= #log do
		currentGuard = string.match(log[i][2], "Guard #(%d+)")
		if guardSleepCounts[currentGuard] == nil then
			guardSleepCounts[currentGuard] = {}
		end
		i = i + 1
		while i <= #log and not string.match(log[i][2], "Guard #(%d+)") do
			if string.match(log[i][2], "falls asleep") then
				local startMinute = tonumber(string.match(log[i][1], ":(%d+)$"))
				local endMinute = tonumber(string.match(log[i + 1][1], ":(%d+)$"))
				for j = startMinute, endMinute - 1 do
					if guardSleepCounts[currentGuard][j] == nil then
						guardSleepCounts[currentGuard][j] = 1
					else
						guardSleepCounts[currentGuard][j] = guardSleepCounts[currentGuard][j] + 1
					end
				end
			end
			i = i + 1
		end
	end
	for thisGuardID, thisGuardCount in pairs(guardSleepCounts) do
		local sleepSum = 0
		local sleepMaxMinute = -1
		local sleepMaxCount = 0
		for thisMinute, thisMinuteCount in pairs(thisGuardCount) do
			sleepSum = sleepSum + thisMinuteCount
			if thisMinuteCount > sleepMaxCount then
				sleepMaxCount = thisMinuteCount
				sleepMaxMinute = thisMinute
			end
		end
		guardSummary[#guardSummary + 1] = { sleepSum, sleepMaxMinute, tonumber(thisGuardID), sleepMaxCount}
	end
	table.sort(guardSummary, function(a, b)
		return a[1] > b[1]
	end)
	return guardSummary[1][2] * guardSummary[1][3]
end

local function part2(allLines)
	table.sort(guardSummary, function(a, b)
		return a[4] > b[4]
	end)
	return guardSummary[1][2] * guardSummary[1][3]
end

io.input("input/input04.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))