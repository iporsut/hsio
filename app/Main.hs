module Main where

import Data.Time

main :: IO ()
main = do
  putStrLn "Hello, what is your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name ++ "!")

  putStrLn "Birthday (format: dd/mm/yyyy, e.g.: 21/06/1985)"
  birthdayStr <- getLine
  birthday <- (parseTimeM
               False
               defaultTimeLocale
               "%d/%m/%Y"
               birthdayStr :: IO UTCTime)
  let (by, bm, bd) = toGregorian (utctDay birthday)

  nowUTC <- getCurrentTime
  let (ny, nm, nd) = toGregorian (utctDay nowUTC)

  let age = if (nm >= bm) && (nd >= bd) then (ny - by) else (ny - by - 1)
  putStrLn ("You are " ++ (show age) ++ " years old.")
