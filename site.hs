--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    
    match "assets/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "home/course-desc.markdown" $ do
        route   $ customRoute $ (\x -> "../templates/Info.html") . toFilePath
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/home.html" defaultContext
            >>= relativizeUrls

    match "home/news.markdown" $ do
        route   $ customRoute $ (\x -> "index.html") . toFilePath
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/Info.html" defaultContext
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "menu/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

    -- <a href="/assets/...pdf" download=".pdf">Click to Download</a>
