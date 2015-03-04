module Count where


import qualified Data.Map as M
import Data.List
import System.IO
import Control.Monad
import Data.Char
import Text.Printf

--incWord :: (Ord k, Num a) => Data.Map.Base.Map k a -> k -> Data.Map.Base.Map k a
incWord m w = M.insert w newVal m where
    oldVal = M.lookup w m
    newVal = case oldVal of
                 Just i -> i+1
                 Nothing -> 1

parse :: String -> String
parse contents =
    let wds = words $ map toLower contents
        cts = M.toList $ foldl incWord M.empty wds
        sorted =  take 12000 $ sortBy (\ (k1 , v1) (k2, v2) -> v2 `compare` v1) cts
        longest = 1 + foldl (\ l (w,ct) -> max  l (length w)) 0 sorted
        fd = printf "%7d"
        fs = printf $ "%" ++ (show longest) ++ "s"
        makeLine = (\ (wd, ct) -> fd ct ++ "," ++ fs wd) :: (String, Int) -> String
        extended = map makeLine sorted
        csv = concat $ intersperse "\n" extended
    in "total words = " ++ (show (length wds)) ++ "\n" ++ csv





count ::  String -> String -> IO [Char]
count ifname ofname = do
    putStrLn ofname
    contents <- readFile ifname
    let str = parse contents
    writeFile ofname str
    return ""