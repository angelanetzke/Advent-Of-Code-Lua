local function part1(allLines)
	local scoreForRound = {}
	scoreForRound["A X"] = 1 + 3 -- I choose rock and draw
	scoreForRound["B X"] = 1 + 0 -- I choose rock and lose
	scoreForRound["C X"] = 1 + 6 -- I choose rock and win
	scoreForRound["A Y"] = 2 + 6 -- I choose paper and win
	scoreForRound["B Y"] = 2 + 3 -- I choose paper and draw
	scoreForRound["C Y"] = 2 + 0 -- I choose paper and lose
	scoreForRound["A Z"] = 3 + 0 -- I choose scissors and lose
	scoreForRound["B Z"] = 3 + 6 -- I choose scissors and win
	scoreForRound["C Z"] = 3 + 3 -- I choose scissors and draw
	local totalScore = 0;
	for i = 1, #allLines do
		totalScore = totalScore + scoreForRound[allLines[i]]
	end
	return totalScore
end

local function part2(allLines)
	local scoreForRound = {}
	scoreForRound["A X"] = 3 + 0 -- I choose scissors to lose
	scoreForRound["B X"] = 1 + 0 -- I choose rock to lose
	scoreForRound["C X"] = 2 + 0 -- I choose paper to lose
	scoreForRound["A Y"] = 1 + 3 -- I choose rock to draw
	scoreForRound["B Y"] = 2 + 3 -- I choose paper to draw
	scoreForRound["C Y"] = 3 + 3 -- I choose scissors to draw
	scoreForRound["A Z"] = 2 + 6 -- I choose paper to win
	scoreForRound["B Z"] = 3 + 6 -- I choose scissors to win
	scoreForRound["C Z"] = 1 + 6 -- I choose rock to win
	local totalScore = 0;
	for i = 1, #allLines do
		totalScore = totalScore + scoreForRound[allLines[i]]
	end
	return totalScore
end

io.input("input/input02.txt")
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
