---@class Date: DefaultClassBody
---@field absolute_day number
---@field day_of_week number
---@field absolute_week number
---@field week_of_month number
---@field absolute_month number
---@field month_of_year number

---@return Date
function Date()
    ---@type Date
    local _date = Class {
        typename = "Date"
    }

    _date.absolute_day = GetDate(DAY)
    _date.day_of_week = GetDate(DAY_OF_WEEK)
    _date.absolute_week = floor((GetDate(DAY) - 1) / 7) + 1
    _date.week_of_month = GetDate(WEEK)
    _date.absolute_month = floor((GetDate(DAY) - 1) / 28) + 1
    _date.month_of_year = GetDate(MONTH)

    return _date
end

__end_import()