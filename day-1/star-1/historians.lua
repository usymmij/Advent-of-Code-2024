local file = io.open("./input.txt", 'r');

io.input(file);

local list1 = {}
local list2 = {}

local i = 0
for line in io.lines() do
    local spacePos = string.find(line, " ");

    i = i + 1
    list1[i] = tonumber(string.sub(line, 0, spacePos));
    list2[i] = tonumber(string.sub(line, spacePos + 1));
end

table.sort(list1)
table.sort(list2)

local final = 0

local j = 0
while true do
    j = j + 1
    local val1 = list1[j];

    if val1 == nil then
        break
    end

    final = final + math.abs(val1 - list2[j]);
end

print(final)

io.close();
