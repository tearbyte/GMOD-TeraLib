TeraLib = TeraLib or {}

TeraLib.util = {}

function TeraLib.util.switch_knv(table)
    local new_table = {}
    for k, v in pairs(table) do
        new_table[v] = k
    end
    return new_table
end