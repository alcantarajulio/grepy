-- Função para encontrar o padrão em uma linha
findPattern :: String -> String -> Maybe (String, String)
findPattern line pattern =
  case line =~ pattern :: (String, String, String) of
    (, , "") -> Nothing
    (, matched, ) -> Just (line, matched)

-- Função para processar o texto linha por linha e encontrar padrões
processText :: String -> String -> [(String, String)]
processText text pattern =
  let linesList = lines text  -- Divide o texto em linhas
      -- Função auxiliar para processar uma linha e adicionar à lista se um padrão for encontrado
      processLine acc line = case findPattern line pattern of
                                Nothing -> acc
                                Just match -> match : acc
  in foldl' processLine [] linesList  -- Itera sobre as linhas e acumula os resultados
main :: IO ()
main = do
  let text = "oi eu gosto de bolo\nbolo de chocolate\nnão tem bolo aqui"
      pattern = "bo.*"
      matches = processText text pattern
  putStrLn "Padrões encontrados:"
  mapM_ ((line, matched) -> putStrLn $ "Linha: "" ++ line ++ "" Padrão: "" ++ matched ++ """) matches