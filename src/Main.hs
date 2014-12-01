module Main where

import Text.XML.HXT.Core
import Text.HandsomeSoup
import Data.List
import Control.Monad
import Data.Char

--import Network.HTTP
--import Text.HTML.TagSoup
--import Text.HTML.Download		-- tagsoup
--import Data.Char

--import Network.Curl.Download
--import Network.Curl

linksForPg :: Show a => a -> IO [String]
linksForPg pg = do
    let doc = fromUrl $ "http://www.sunstar.com.ph/bisaya-news?page=" ++ (show pg)
    rawlinks <- runX $ doc >>> css "h2 a" ! "href"
    let links = map (\ s -> "http://www.sunstar.com.ph" ++ s) rawlinks
    return links

linksForPgs :: Show a => [a] -> IO [String]
linksForPgs pgs = do
    links <- mapM linksForPg pgs
    let links2 = foldr (++) [] links
    return links2


article :: Show a => (String, a) -> IO [Char]
article (url, num) = do
    putStrLn $ show num
    let doc = fromUrl url--"http://www.sunstar.com.ph/superbalita-cebu/opinyon/2014/11/28/albor-salawayong-mga-balaod-379096"
    ps <- runX $ doc >>> css "p" >>> removeAllWhiteSpace >>> getChildren >>> getText
    let paras = filter (\s -> length s > 50) ps
    let str1 = concat $ intersperse " "  paras
    let minusPunctation = map (\c -> if isAlpha c || isSpace c || (c == '-') then c else ' ') str1
    -- paragraphs <- runX . xshow $ doc >>> ( css "div[class~=base] " )
    return minusPunctation

main = do
    links <- linksForPgs [0..0]
    let indexed = zip links [0..]
    articles <- mapM article indexed
    -- todo sanitize "?
    --let text = foldr (++) [] articles
    let text = concat $ intersperse "\n\n\n" articles
    putStr text
    return ""