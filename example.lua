dofile('_lib/Storage.lua')

-- Exemplo de uso
local storage = Storage.new("store") -- Criando uma instância de Storage com nome de arquivo personalizado
storage:setItem("nome", "João")
storage:setItem("idade", 30)
storage:setItem("objeto",
  JSON.encode({ x = 32471, y = 31715, z = 6, type = 'NODE', wait = 1000, direction = 8, action = nil, label = '' }))

print(storage:getItem("nome"))                                         -- Saída: João
print(storage:getItem("idade"))                                        -- Saída: 30
print(storage:getItem("objeto"))                                       -- Saída: {...}

print("Número de itens no armazenamento:", storage:getStorageLength()) -- Saída: 2

print("Chave pelo índice 1:", storage:getStorageKey(1))                -- Saída: nome
print("Chave pelo índice 2:", storage:getStorageKey(2))                -- Saída: idade

storage:removeItem("nome")
print(storage:getItem("nome")) -- Saída: nil

storage:clearStorage()
print(storage:getStorageLength()) -- Saída: 0
