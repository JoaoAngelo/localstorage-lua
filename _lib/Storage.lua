--[[
    Projeto: Local Storage em Lua
    Autor: João Ângelo
    Email: joaoangelo92@gmail.com
    Descrição: Este script implementa um sistema de armazenamento local em Lua,
               permitindo adicionar, remover e acessar itens armazenados em um arquivo JSON.
    Inspiração: Localstorage
]]

-- Definição da classe Storage
Storage = {}
Storage.__index = Storage

-- Função construtora para criar uma nova instância de Storage
function Storage.new(storageFileName)
  local self = setmetatable({}, Storage)
  self.storageFileName = storageFileName or
      "store" -- Define o nome do arquivo de armazenamento
  self.storageFilePath = Engine.getScriptsDirectory() ..
      "/_lib/" ..
      self.storageFileName ..
      ".json" -- Define o caminho completo do arquivo
  return self
end

-- Função para carregar os dados do arquivo JSON
function Storage:loadStorage()
  local file = io.open(self.storageFilePath, "r") -- Abre o arquivo para leitura
  if file then
    local content = file:read("*a")               -- Lê todo o conteúdo do arquivo
    file:close()                                  -- Fecha o arquivo
    return JSON.decode(content) or {}             -- Decodifica o conteúdo JSON para uma tabela Lua
  else
    return {}                                     -- Retorna uma tabela vazia se o arquivo não existir
  end
end

-- Função para salvar os dados no arquivo JSON
function Storage:saveStorage(data)
  local file = io.open(self.storageFilePath, "w") -- Abre o arquivo para escrita
  if file then
    file:write(JSON.encode(data))                 -- Codifica os dados para JSON e escreve no arquivo
    file:close()                                  -- Fecha o arquivo
  else
    print("Erro ao salvar o arquivo " .. self.storageFileName .. ".json")
  end
end

-- Função para obter o número de itens armazenados
function Storage:getStorageLength()
  local data = self:loadStorage() -- Carrega os dados do arquivo
  local count = 0                 -- Inicializa o contador de itens
  for _ in pairs(data) do
    count = count + 1             -- Incrementa o contador para cada item no armazenamento
  end
  return count                    -- Retorna o número de itens no armazenamento
end

-- Função para obter a chave pelo índice
function Storage:getStorageKey(index)
  local data = self:loadStorage() -- Carrega os dados do arquivo
  local keys = {}                 -- Inicializa uma tabela para armazenar as chaves
  for key, _ in pairs(data) do
    table.insert(keys, key)       -- Adiciona as chaves na tabela
  end
  return keys[index]              -- Retorna a chave pelo índice
end

-- Função para obter um item pelo nome da chave
function Storage:getItem(key)
  local data = self:loadStorage() -- Carrega os dados do arquivo
  return data[key]                -- Retorna o valor correspondente à chave
end

-- Função para adicionar ou atualizar um item
function Storage:setItem(key, value)
  local data = self:loadStorage() -- Carrega os dados do arquivo
  data[key] = value               -- Adiciona ou atualiza o valor correspondente à chave
  self:saveStorage(data)          -- Salva os dados atualizados no arquivo
end

-- Função para remover um item pelo nome da chave
function Storage:removeItem(key)
  local data = self:loadStorage() -- Carrega os dados do arquivo
  data[key] = nil                 -- Remove o item correspondente à chave
  self:saveStorage(data)          -- Salva os dados atualizados no arquivo
end

-- Função para limpar todos os itens do armazenamento
function Storage:clearStorage()
  self:saveStorage({}) -- Salva uma tabela vazia no arquivo
end
