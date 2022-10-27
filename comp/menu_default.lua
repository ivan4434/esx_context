local GUI, MenuType, OpenedMenus = {}, 'default', 0
GUI.Time = 0

local function openMenu(namespace, name, data)
  OpenedMenus += 1
  local elements = {
    {
      unselectable = true,
      title = data.title
    }
  }

  for k,v in pairs(data.elements) do
    
    elements[k+1] = v

    elements[k+1].title = v.label
  end

  ESX.OpenContext("right", elements, 
  function(menu2, element)
    local menu = ESX.UI.Menu.GetOpened(MenuType, namespace, name)
    if menu and menu.submit ~= nil then
      data.current = element
      data.current.label = element.title
      menu.submit(data, menu)
    end

  end, function(menu2)
    local menu = ESX.UI.Menu.GetOpened(MenuType, namespace, name)

    if menu and menu.cancel ~= nil then
      OpenedMenus -= 1
      ESX.UI.Menu.CloseAll()
      menu.cancel(data, menu)
    end

  end)
end

local function closeMenu(namespace, name)
  OpenedMenus -= 1
  ESX.CloseContext()
end

ESX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)