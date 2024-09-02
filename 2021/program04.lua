BingoCard = {}

function BingoCard:new(o, numberData)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.score = -1
	o.numbers = {}
	for i = 1, #numberData do
		o.numbers[i] = {}
		for x in string.gmatch(numberData[i], "%d+") do
			o.numbers[i][#o.numbers[i] + 1] = {tonumber(x), false}
		end
	end
	return o
end

function BingoCard:markNumber(number)
	for i = 1, #self.numbers do
		for j = 1, #self.numbers[i] do
			if self.numbers[i][j][1] == number then
				self.numbers[i][j][2] = true
			end
		end
	end
end

function BingoCard:getScore()
	if self.score >= 0 then
		return self.score
	end
	local totalScore = 0
	for i = 1, #self.numbers do
		for j = 1, #self.numbers[i] do
			if not self.numbers[i][j][2] then
				totalScore = totalScore + self.numbers[i][j][1]
			end
		end
	end
	for i = 1, #self.numbers do
		local markedCount = 0
		for j = 1, #self.numbers[i] do
			if self.numbers[i][j][2] then
				markedCount = markedCount + 1
			end
		end
		if markedCount == #self.numbers[i] then
			self.score = totalScore
			return self.score
		end
	end
	for j = 1, #self.numbers[1] do
		local markedCount = 0
		for i = 1, #self.numbers do
			if self.numbers[i][j][2] then
				markedCount = markedCount + 1
			end
		end
		if markedCount == #self.numbers then
			self.score = totalScore
			return self.score
		end
	end
	return self.score
end

local function part1(allLines)
	local cardSize = 5
	local bingoCards = {}
	for i = 3, #allLines - (cardSize - 1), cardSize + 1 do
		local thisCardData = {}
		for j = 0, cardSize - 1 do
			thisCardData[#thisCardData + 1] = allLines[i + j]
		end
		bingoCards[#bingoCards + 1] = BingoCard:new(nil, thisCardData)
	end
	local numbersToCall = {}
	for x in string.gmatch(allLines[1], "%d+") do
		numbersToCall[#numbersToCall + 1] = tonumber(x)
	end
	for _, numberCalled in ipairs(numbersToCall) do
		for _, thisCard in ipairs(bingoCards) do
			thisCard:markNumber(numberCalled)
			if thisCard:getScore() >= 0 then
				return thisCard:getScore() * numberCalled
			end
		end
	end
	return 0
end

local function part2(allLines)
	local cardSize = 5
	local bingoCards = {}
	for i = 3, #allLines - (cardSize - 1), cardSize + 1 do
		local thisCardData = {}
		for j = 0, cardSize - 1 do
			thisCardData[#thisCardData + 1] = allLines[i + j]
		end
		bingoCards[#bingoCards + 1] = BingoCard:new(nil, thisCardData)
	end
	local numbersToCall = {}
	for x in string.gmatch(allLines[1], "%d+") do
		numbersToCall[#numbersToCall + 1] = tonumber(x)
	end
	local winningCards = {}
	for _, numberCalled in ipairs(numbersToCall) do
		for i, thisCard in ipairs(bingoCards) do
			thisCard:markNumber(numberCalled)
			if thisCard:getScore() >= 0 then
				local isInTable = false
				for _, thisWinningCard in ipairs(winningCards) do
					if thisWinningCard == i then
						isInTable = true
					end
				end
				if not isInTable then
					winningCards[#winningCards + 1] = i
				end
				if #winningCards == #bingoCards then
					return thisCard:getScore() * numberCalled
				end
			end
		end
	end
	return 0
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