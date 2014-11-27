{-
import Text.XML.HXT.Core
import Text.HandsomeSoup


main = do
    let doc = fromUrl "http://www.sunstar.com.ph/bisaya-news?page=1000"
    links <- runX $ doc >>> css "h2 a" ! "href"
    mapM_ putStrLn links


main = do
    let doc = fromUrl "http://www.sunstar.com.ph/superbalita-davao/balita/2012/01/27/mag-inahan-sikpaw-sa-ronda-202866"
    paragraphs <- runX $ doc >>> css ".content .base p"
     smapM_ putStrLn paragraphs
-}


main = putStrLn "hello"