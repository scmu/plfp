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
        compile $ pandocCompiler

    match "home/course-desc.markdown" $ do
        compile $ pandocCompiler
    
    create ["index.html"] $ do
        route idRoute
        compile $ do
            news <- loadBody "home/news.markdown" :: Compiler String
            body <- loadBody "home/course-desc.markdown" :: Compiler String
            let customCtx = 
                    field      "news"  (\x -> return news) `mappend`
                    field      "body"  (\x -> return body) `mappend`
                    constField "title" "課程資訊"           `mappend`
                    defaultContext
            makeItem ""
                >>= loadAndApplyTemplate "templates/default.html" customCtx

    match "menu/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
