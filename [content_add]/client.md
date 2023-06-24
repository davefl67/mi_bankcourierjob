-- add these to your modules/items/client.lua in the bottom of the file

make sure it is between:

line 48 - local ox_inventory = exports[shared.resource] & return Items

```
Item('phone_g6s', function(data, slot) 
	ox_inventory:useItem(data, function(data)
		exports['mi_bankcourierjob']:g6sworkphonemenu()
	end)
end)
