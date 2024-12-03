local function part1(allLines)
	local productSum = 0
	for i = 1, #allLines do
		for m in string.gmatch(allLines[i], "mul%(%d%d?%d?,%d%d?%d?%)") do
			local thisProduct = 1
			for x in string.gmatch(m, "%d+") do
				thisProduct = thisProduct * tonumber(x)
			end
			productSum = productSum + thisProduct
		end
	end
	return productSum
end

local function part2(allLines)
	local productSum = 0
	local mulPattern = "mul%(%d%d?%d?,%d%d?%d?%)"
	local doPattern = "do%(%)"
	local dontPattern = "don't%(%)"
	local isEnabled = true
	for i = 1, #allLines do
		local reduced = {}
		local lastEndPosition = 0
		while true do
			local startPosition, endPosition = string.find(allLines[i], mulPattern, lastEndPosition + 1)
			if not startPosition or not endPosition then
				break
			end
			local thisProduct = 1
			for x in string.gmatch(string.sub(allLines[i], startPosition, endPosition), "%d+") do
				thisProduct = thisProduct * tonumber(x)
			end
			reduced[#reduced + 1] = {startPosition, thisProduct}
			lastEndPosition = endPosition
		end
		lastEndPosition = 0
		while true do
			local startPosition, endPosition = string.find(allLines[i], doPattern, lastEndPosition + 1)
			if not startPosition or not endPosition then
				break
			end
			reduced[#reduced + 1] = {startPosition, "true"}
			lastEndPosition = endPosition
		end
		lastEndPosition = 0
		while true do
			local startPosition, endPosition = string.find(allLines[i], dontPattern, lastEndPosition + 1)
			if not startPosition or not endPosition then
				break
			end
			reduced[#reduced + 1] = {startPosition, "false"}
			lastEndPosition = endPosition
		end
		table.sort(reduced, function(a, b) return a[1] < b[1] end)
		for j = 1, #reduced do
			if reduced[j][2] == "true" then
				isEnabled = true
			elseif reduced[j][2] == "false" then
				isEnabled = false
			elseif type(reduced[j][2]) == "number" and isEnabled then
				productSum = productSum + reduced[j][2]
			end
		end
	end
	return productSum
end

io.input("input/input3.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))