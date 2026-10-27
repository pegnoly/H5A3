consoleCmd("setvar console_size = 10000")

doFile("/scripts/common.lua")
doFile("libs/3rdparty/lualib.lua")

sleep(20)

__difficulty = GetDifficulty();
__defaultResources = { 20, 20, 10, 10, 10, 10, 20000 };
__difficultyResModifiers = { 2.5, 1.5, 1.0, 0.5 };
function SetPlayerStartResource( nPlayer, nRes, nAmount )
    local resbonus = GetPlayerResource( nPlayer, nRes ) - __defaultResources[nRes + 1] * __difficultyResModifiers[__difficulty + 1];
    SetPlayerResource( nPlayer, nRes, nAmount + resbonus );
end;

function GiveExp( heroName, exp )
    ChangeHeroStat( heroName, STAT_EXPERIENCE, exp )
end

function IsInDungeon( objectName )
    local x
    local y
    local floor
    x, y, floor = GetObjectPosition( objectName )
    return floor == UNDERGROUND
end

function IsPlayerHeroesInRegion( playerID, regionName )
    local heroes = GetObjectsInRegion( regionName, OBJECT_HERO )
    for index,hero in heroes do
        if GetObjectOwner( hero ) == playerID then
            return true
        end
    end
    return nil
end

function ResetObjectFlashlight( objectName )
    SetObjectFlashlight( objectName, '' )
end

function GetObjectCreaturesCount( objectName )
    local types
    local count

    types = {}
    types[0],types[1],types[2],types[3],types[4],types[5],types[6] = GetObjectCreaturesTypes( objectName )

    count = 0
    for index,type in types do
        if ( type ~= 0 ) then
            count = count + GetObjectCreatures( objectName, type )
        end
    end

    return count
end

function GetHeroCreaturesCount( heroName )
    local count
    count = GetObjectCreaturesCount( heroName )
    return count
end

function GetPlayerFilter( player )
  if player == PLAYER_1 then return PLAYERFLT_1; end;
  if player == PLAYER_2 then return PLAYERFLT_2; end;
  if player == PLAYER_3 then return PLAYERFLT_3; end;
  if player == PLAYER_4 then return PLAYERFLT_4; end;
  if player == PLAYER_5 then return PLAYERFLT_5; end;
  if player == PLAYER_6 then return PLAYERFLT_6; end;
  if player == PLAYER_7 then return PLAYERFLT_7; end;
  if player == PLAYER_8 then return PLAYERFLT_8; end;
  return 0;
end;

function pcall(func, ...)
  local ans = {[1] = -1}
  startThread(
  function()
    local ans = %ans
    errorHook(
    function()
      %ans[1] = 0
      print('<color=blue>This error makes no sense')
    end)
    ans[2] = %func(table.unpack(%arg))
    ans[1] = 1
  end)
  while ans[1] == -1 do sleep() end
  if ans[1] == 1 then
    return 1, ans[2]
  else
    return nil
  end
end

__LOADED_MODULES   = {}
__ERROR_MODULES    = {}
__imports_n        = 0
__prev_import      = 0 -- only for pretty formating
__timeout          = 25
__error_type       = 0
__TIMEOUT_ERROR    = 1
__FILE_ERROR       = 2
__end_import       = function()
                       __prev_import = __imports_n; __imports_n = __imports_n - 1
                     end

function import(rel_path)
  local s = string.spread(rel_path)
  local base_path
  local restored_path = ""
  if s[1] == '@' then
	base_path = "libs/"
  else 
    base_path = GetMapDataPath()
  end
  
  for i = 2, length(s) do
    if not s[i] then
	   break
	end
	restored_path = restored_path..s[i]
  end
  
  local abs_path = base_path..restored_path..[[.lua]]

  local tab = '<color=white>'
  local node_tab = '<color=white>'
  for i=1, __imports_n do
    if i == __imports_n then
      node_tab = node_tab..'+--'
      tab      = tab..'|  '
    else
      node_tab = node_tab..'|  '
      tab      = tab..'|  '
    end
  end

  if __prev_import == __imports_n then
    print(tab)
  end
  print(node_tab.."+ <color=yellow>Importing "..abs_path)


  if not __LOADED_MODULES[abs_path] then

    __imports_n   = __imports_n + 1
    __prev_import = __imports_n

    local __imports_before = __imports_n
    local timeout          = __timeout
    local error_msg        = ''
    local result, state    = pcall(doFile, abs_path)

    -- inner imports timeouts MUST come earlier then any outer
    while (__imports_n >= __imports_before) do

      -- module not found
      if state == 2 then

        error_msg  = "^ <color=red>Module '"..abs_path.."' not found"
        __error_type = __FILE_ERROR

      -- self timeout
      elseif timeout < 0 then

        error_msg  = "^ <color=red>Timeout on import of '"..abs_path.."'"
        __error_type = __TIMEOUT_ERROR

        print(tab..error_msg); print(tab)
        __end_import()
        table.insert(__ERROR_MODULES, abs_path)

        --hideerror(1)
        return -nil;

      end

      if __error_type > 0 then

      end

      if __error_type > 0 then
        if __imports_n == __imports_before then
          if __error_type == __TIMEOUT_ERROR and timeout > 0 then
            print(tab.."^ <color=orange>Interrupted. Failed importing dependencies"); print(tab)
            local lock = __imports_n
            __end_import()
            repeat
              sleep(5)
            until __imports_n == lock or __imports_n < 1
            return nil
          end
        end
      else
        -- timer works only if all nested imports ended without errors
        if __imports_n == __imports_before then
          timeout = timeout - 1
        end
      end

      sleep(5)

    end



    if __imports_n < __imports_before and (timeout > 0) and __error_type == 0 then
      print(tab.."^ <color=yellow>Imported module '"..abs_path.."' in ~"..((__timeout - timeout)*200).." ms", ' ', __imports_n, ' | ', __imports_before)
      print(tab)
      __LOADED_MODULES[abs_path] = not nil
      return not nil;
    end

  else
    print(tab.."^ <color=yellow>Module '"..abs_path.."' already imported")
    print(tab)
    return not nil;
  end
end