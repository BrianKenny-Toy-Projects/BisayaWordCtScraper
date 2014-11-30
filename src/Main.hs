module Main where

import Text.XML.HXT.Core
import Text.HandsomeSoup

--import Network.HTTP
--import Text.HTML.TagSoup
--import Text.HTML.Download		-- tagsoup
--import Data.Char

--import Network.Curl.Download
--import Network.Curl

main1 = do
    let doc = fromUrl "http://www.sunstar.com.ph/bisaya-news?page=1001"
    rawlinks <- runX $ doc >>> css "h2 a" ! "href"
    let links = map (\ s -> "http://www.sunstar.com.ph" ++ s) rawlinks
    mapM_ putStrLn links



article = do
    let doc = fromUrl "http://www.sunstar.com.ph/superbalita-cebu/opinyon/2014/11/28/albor-salawayong-mga-balaod-379096"
    ps <- runX $ doc >>> css "p" >>> removeAllWhiteSpace >>> getChildren >>> getText
    let paras = filter (\s -> length s > 50) ps
    -- paragraphs <- runX . xshow $ doc >>> ( css "div[class~=base] " )
    mapM_ putStrLn paras



-- close runX $ doc >>> css "p" >>> removeAllWhiteSpace >>> getChildren >>> getText
-- thing <- runX  $ doc2 >>>   getChildren  >>>  getText
{-
haskellHitCount = do
    --src <- openURL "http://haskell.org/haskellwiki/Haskell"
    (code, src) <- curlGetString "http://www.haskell.org/haskellwiki/Haskell" []
    let count = fromFooter $ parseTags src
    putStrLn $ "haskell.org has been hit " ++ count ++ " times"
    where fromFooter = filter isDigit . innerText . take 2 . dropWhile (~/= "<li id=viewcount>")


mytst = do
    (code, src) <- curlGetString "http://www.sunstar.com.ph/superbalita-davao/balita/2012/01/27/mag-inahan-sikpaw-sa-ronda-202866" []
    let str = extract $ parseTags src
    putStrLn "hi"
    where extract = dropWhile (~/= "<div id=content>")
-}

main = main1