--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Withdraw Money', 'Invalid amount', 'CHAR_BANK_MAZE', 9)
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Deposit Money', 'Deposited ~g~$' .. amount .. '~s~', 'CHAR_BANK_MAZE', 9)	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('chatMessage', _source, "Invalid Amount")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Withdraw Money', 'Withdrawed ~r~$' .. amount .. '~s~', 'CHAR_BANK_MAZE', 9)
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)


RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	-- names instead of numbers
	local xName   = GetPlayerName(_source)
	local zName   = GetPlayerName(to)
	local balance = 0
	balance = xPlayer.getAccount('bank').money
	zbalance = zPlayer.getAccount('bank').money

	
	if tonumber(_source) == tonumber(to) then
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer Money', 'You cannot transfer to your self!', 'CHAR_BANK_MAZE', 9)
	else
		if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer Money', 'Not enough money to transfer!', 'CHAR_BANK_MAZE', 9)
		else
			xPlayer.removeAccountMoney('bank', amountt)
			zPlayer.addAccountMoney('bank', amountt)
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer Money', 'You transfered ~r~$' .. amountt .. '~s~ to ~r~' .. zName .. ' .', 'CHAR_BANK_MAZE', 9)
			TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank', 'Transfer Money', 'You received ~r~$' .. amountt .. '~s~ from ~r~ the bank by '.. xName ..' .', 'CHAR_BANK_MAZE', 9)
		end
		
	end
end)





