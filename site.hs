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
    
    match "home/*" $ do
        compile pandocCompiler

    match "menu/*" $ version "firstVer" $ do
        route $ setExtension "html"
        compile pandocCompiler
    
    create ["index.html"] $ do
        route   idRoute
        compile $ do
            menu <- loadAll ("menu/*" .&&. hasVersion "firstVer") :: Compiler [Item String]
            news <- loadBody "home/news.markdown" :: Compiler String
            body <- loadBody "home/course-desc.markdown" :: Compiler String
            let customCtx = 
                    constField "title" "課程資訊"                   `mappend`
                    field      "news"  (\x -> return news)          `mappend`
                    field      "body"  (\x -> return body)          `mappend`
                    listField  "menu"  defaultContext (return menu) `mappend`
                    defaultContext
            makeItem ""
                >>= loadAndApplyTemplate "templates/default.html" customCtx

    match "menu/*" $ do
        route $ setExtension "html"
        compile $ do 
            menu <- loadAll ("menu/*" .&&. hasVersion "firstVer") :: Compiler [Item String]
            let customCtx = 
                    listField  "menu"  defaultContext (return menu) `mappend`
                    defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" customCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
