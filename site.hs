--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler
    
    match "home/news.markdown" $ do
        compile pandocCompiler

    match "menu/*" $ version "firstVer" $ do
        route $ setExtension "html"
        compile pandocCompiler
    
    match "templates/*" $ do 
        compile templateBodyCompiler
    
    match "home/course-desc.markdown" $ do
        route $ constRoute "index.html"
        compile $ do
            menu <- loadAll ("menu/*" .&&. hasVersion "firstVer") :: Compiler [Item String]
            news <- loadBody "home/news.markdown" :: Compiler String
            iden <- getUnderlying
            let menuCtx = 
                    constField    "outpath" (toFilePath iden)     `mappend`
                    functionField "active"  setActive             `mappend`
                    defaultContext
            let customCtx = 
                    field         "news"    (\x -> return news)   `mappend`
                    listField     "menu"    menuCtx (return menu) `mappend`
                    defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" customCtx

    match "menu/*" $ do
        route $ setExtension "html"
        compile $ do 
            menu <- loadAll ("menu/*" .&&. hasVersion "firstVer") :: Compiler [Item String]
            iden <- getUnderlying
            let menuCtx = 
                    constField    "outpath" (toFilePath iden)     `mappend`
                    functionField "active"  setActive             `mappend`
                    defaultContext
            let customCtx = 
                    listField     "menu"    menuCtx (return menu) `mappend`
                    defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" customCtx
                >>= relativizeUrls

setActive :: [String] -> Item String -> Compiler String
setActive args (Item i x) 
    | path == outPath = return "class=\"active\""
    | otherwise       = return ""
    where path    = head args
          outPath = last args