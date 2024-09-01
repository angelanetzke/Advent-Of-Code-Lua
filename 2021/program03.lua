local function getBits(allLines, position)
	local zerosCount = 0
	local onesCount = 0
	for _, thisLine in ipairs(allLines) do
		if string.sub(thisLine, position, position) == "1" then
			onesCount = onesCount + 1
		else
			zerosCount = zerosCount + 1
		end
	end
	if zerosCount == onesCount then
		return "X", "X"
	elseif onesCount > zerosCount then
		return "1", "0"
	else
		return "0", "1"
	end
end

local function part1(allLines)
	local gammaString = ""
	local epsilonString = ""
	for i = 1, #allLines[1] do
		local mostCommon, leastCommon = getBits(allLines, i)
		gammaString = gammaString .. mostCommon
		epsilonString = epsilonString .. leastCommon
	end
	return tonumber(gammaString, 2) * tonumber(epsilonString, 2)
end

local function part2(allLines)
	local oxygenString = ""
	local co2String = ""
	local oxygenCandidates = {}
	local co2Candidates = {}
	for _, thisLine in ipairs(allLines) do
		oxygenCandidates[#oxygenCandidates + 1] = thisLine
		co2Candidates[#co2Candidates + 1] = thisLine
	end
	local oxygenTemp = {}
	local co2Temp = {}
	for i = 1, #allLines[1] do
		oxygenTemp = {}
		local mostCommon, _ = getBits(oxygenCandidates, i)
		for _, thisCandidate in ipairs(oxygenCandidates) do
			if mostCommon == "X" then
				if string.sub(thisCandidate, i, i) == "1" then
					oxygenTemp[#oxygenTemp + 1] = thisCandidate
				end
			elseif string.sub(thisCandidate, i, i) == mostCommon then
				oxygenTemp[#oxygenTemp + 1] = thisCandidate
			end
		end
		oxygenCandidates = {}
		for _, thisCandidate in ipairs(oxygenTemp) do
			oxygenCandidates[#oxygenCandidates + 1] = thisCandidate
		end
		if #oxygenCandidates == 1 then
			oxygenString = oxygenCandidates[1]
		end
		co2Temp = {}
		local _, leastCommon = getBits(co2Candidates, i)
		for _, thisCandidate in ipairs(co2Candidates) do
			if leastCommon == "X" then
				if string.sub(thisCandidate, i, i) == "0" then
					co2Temp[#co2Temp + 1] = thisCandidate
				end
			elseif string.sub(thisCandidate, i, i) == leastCommon then
				co2Temp[#co2Temp + 1] = thisCandidate
			end
		end
		co2Candidates = {}
		for _, thisCandidate in ipairs(co2Temp) do
			co2Candidates[#co2Candidates + 1] = thisCandidate
		end
		if #co2Candidates == 1 then
			co2String = co2Candidates[1]
		end
	end
	return tonumber(oxygenString, 2) * tonumber(co2String, 2)
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