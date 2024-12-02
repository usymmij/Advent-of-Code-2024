local file = io.open("./input.txt", 'r');

io.input(file);

local list1 = {}
local list2 = {}

do
    local i = 0
    for line in io.lines() do
        local spacePos = string.find(line, " ");

        i = i + 1
        list1[i] = tonumber(string.sub(line, 0, spacePos));
        list2[i] = tonumber(string.sub(line, spacePos + 1));
    end
end

io.close();

table.sort(list1)
table.sort(list2)

do
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

    print("total distance:")
    print(final)
end

do
    local sim = 0
    for i in pairs(list1) do
        local occurences = 0
        for j in pairs(list2) do
            if list1[i] == list2[j] then
                occurences = occurences + 1
            end
        end
        sim = sim + (list1[i] * occurences)
    end

    print("similarity score:")
    print(sim)
end
