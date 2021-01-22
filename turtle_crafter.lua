--[[early game autocrafting using turtles]]--

local crafter = {
  rec = {},
  newRec = function (self,name,id,dmg,qty,rec)
    self.rec[name].name = name
    self.rec[name].id = id
    self.rec[name].dmg = dmg
    self.rec[name].qty = qty
    self.rec[name].rec = rec
  end,
  
  craft = function (self,name,count)
    for _,tab in pairs(rec) do
      if tab.name == name then
        
      end
    end
  end
}
