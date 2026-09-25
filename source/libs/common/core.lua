function len(t)
  local answer = 0
  for k, v in t do
    if v then
      answer = answer + 1
    end
  end
  return answer
end

function keys(t)
  local answer, n = {}, 0
  for k, v in t do
	if v then
	  answer[n] = k
	  n = n + 1
	end
  end
  return answer
end

---@param message string
---@param as_string 1|nil
---@return table
function rtext(message, as_string)
  as_string = as_string or nil
  local t = string.spread(message)
  local answer = {'Text/rawtext/message.txt'}
  for i = 1, length(t) - 1 do
    answer['l'.. i] = as_string and '"/Text/rawtext/'..string.bytes[t[i]]..'.txt"' or '/Text/rawtext/'..string.bytes[t[i]]..'.txt'
  end
  return answer
end

__end_import()