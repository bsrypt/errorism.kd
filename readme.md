
![Logo](https://cdn.errorism.cc/errorism_scripts_banner.png)


## Authors

- [@Errorismx](https://www.github.com/Errorismx)


# Kill/Death Utils

just a simple script that store kill/death and made it easy to access.


## Features

- Kill/Death tracker
- Exports for easy access
- Automatic skip setDeath from ambulancejob

## Requirement

- [oxmysql](https://github.com/overextended/oxmysql)
- [es_extended](https://github.com/esx-framework/esx_core)
- [esx_datastore](https://github.com/esx-framework/esx_datastore)
- [esx_ambulancejob](https://github.com/esx-framework/esx_ambulancejob)

## API Reference [Serverside]

#### Get both kill and death record.

```lua
exports['errorism.kd']:get(identifier)
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `identifier` | `string` | **Required**. Identifier of player |

#### Get kill record.

```lua
exports['errorism.kd']:getKill(identifier)
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `identifier`| `string` | **Required**. Identifier of player |

#### Get death record.

```lua
exports['errorism.kd']:getDeath(identifier)
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `identifier`| `string` | **Required**. Identifier of player |




## Usage/Examples

```lua
local xPlayer = ESX.GetPlayerFromId(source)
local identifier = xPlayer.getIdentifier()
local death = exports['errorism.kd']:get(identifier)

print(tostring(death) .. ' kill') 
-- Output : 0 kill

```


## Tech Stack

**Server:** lua

