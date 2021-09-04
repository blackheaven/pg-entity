module Main where

import Processing.Entity
import Database.PostgreSQL.Entity.DBT
import Control.Monad.Except

main :: IO ()
main = do
  pool <- makePool
  let e1 = E 1 True True
  let e2 = E 2 False True
  let e3 = E 3 False False
  result <- runExceptT @EntityError $ do
    runDB pool $ insertEntity e1
    runDB pool $ insertEntity e2
    runDB pool $ insertEntity e3

    -- runDB pool $ markForProcessing 1
    runDB pool $ markForProcessing 2
    -- runDB pool $ markForProcessing 3
  case result of
    Left err -> print err
    Right _  -> putStrLn "Everything went well"