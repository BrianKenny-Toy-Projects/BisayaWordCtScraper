module Main where

import System.Environment

import Count
import Scrape


main :: IO (String)
main = do
    args <- getArgs
    case args of
        ["scrape", path, firstS, lastS]  ->
            scrape path (read firstS :: Int) (read lastS :: Int)
        ["count", path, outPath]  ->
            count path outPath
        _ -> do
            putStrLn "Bad input"
            return "done"