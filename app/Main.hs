module Main where

import Data.Time (defaultTimeLocale, getCurrentTime, parseTimeM, toGregorian, utctDay, UTCTime)

main :: IO ()
main = do
  putStrLn "Hello, what is your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name ++ "!")

  putStrLn "Birthday (format: dd/mm/yyyy, e.g.: 21/06/1985)"
  birthdayStr <- getLine
  birthday <- (parseTimeM
               False                        -- Don't accept leading and trailing whitespace.
               defaultTimeLocale
               "%d/%m/%Y"                   -- Format: dd/mm/yyyy
               birthdayStr :: IO UTCTime)   -- Result in IO context
  let (by, bm, bd) = toGregorian (utctDay birthday)  -- Get (year, month, day)

  nowUTC <- getCurrentTime
  let (ny, nm, nd) = toGregorian (utctDay nowUTC)    -- Get (year, month, day)

  let age = if (nm >= bm) && (nd >= bd)
            then
              (ny - by)      -- Pass birthday in current year.
            else
              (ny - by - 1)  -- Don't pass birthday in current year.

  putStrLn ("You are " ++ (show age) ++ " years old.")
