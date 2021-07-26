--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Control.Monad (liftM)
import           System.FilePath               (takeBaseName)


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    mkAssets
    mkCSS
    mkError
    mkPages
    {- mkPosts; mkArchive; mkPaginate -}
    mkIndex
    mkTemplate
    mkAtomXML

config :: Configuration
config = defaultConfiguration
  { destinationDirectory = "docs"
  }

mkAssets, mkCSS, mkError, mkPages, mkIndex,
 mkTemplate, mkAtomXML :: Rules ()

mkAssets = match ("images/*" .||. "js/*") $ do
      route   idRoute
      compile copyFileCompiler

mkCSS = match "css/*" $ do
      route   idRoute
      compile compressCssCompiler

mkError = match "error/*" $ do
      route $ (gsubRoute "error/" (const "") `composeRoutes` setExtension "html")
      compile $ pandocCompiler
          >>= applyAsTemplate siteCtx
          >>= loadAndApplyTemplate "templates/default.html" (baseSidebarCtx <> siteCtx)

mkPages = match "pages/*" $ do
      route $ setExtension "html"
      compile $ do
          pageName <- takeBaseName . toFilePath <$> getUnderlying
          let pageCtx = constField pageName "" `mappend`
                        baseNodeCtx
          let evalCtx = functionField "get-meta" getMetadataKey `mappend`
                        functionField "eval" (evalCtxKey pageCtx)
          let activeSidebarCtx = sidebarCtx (evalCtx <> pageCtx)

          pandocCompiler
              >>= saveSnapshot "page-content"
              >>= loadAndApplyTemplate "templates/page.html"    siteCtx
              >>= loadAndApplyTemplate "templates/default.html" (activeSidebarCtx <> siteCtx)
              >>= relativizeUrls

mkIndex = match "home.markdown" $ do
      route $ constRoute "index.html"
      compile $ do
          pageName <- takeBaseName . toFilePath <$> getUnderlying
          let homeCtx = constField "home" "" `mappend`
                        siteCtx
          let pageCtx = constField pageName "" `mappend`
                        baseNodeCtx
          let evalCtx = functionField "get-meta" getMetadataKey `mappend`
                        functionField "eval" (evalCtxKey pageCtx)
          let activeSidebarCtx = sidebarCtx (evalCtx <> pageCtx)

          pandocCompiler
              >>= saveSnapshot "page-content"
              >>= loadAndApplyTemplate "templates/page.html"    homeCtx
              >>= loadAndApplyTemplate "templates/default.html" (activeSidebarCtx <> homeCtx)
              >>= relativizeUrls

mkTemplate = match "templates/*" $ compile templateBodyCompiler

mkAtomXML = create ["atom.xml"] $ do
    route idRoute
    compile $ do
        let feedCtx = postCtx `mappend`
                bodyField "description"
        posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "content"
        renderAtom feedConfig feedCtx posts

{-
mkPosts = match "posts/*" $ do
      route $ setExtension "html"
      compile $ pandocCompiler
          >>= saveSnapshot "content"
          >>= loadAndApplyTemplate "templates/post.html"    postCtx
          >>= loadAndApplyTemplate "templates/default.html" (baseSidebarCtx <> siteCtx)
          >>= relativizeUrls

mkArchive = create ["archive.html"] $ do
      route idRoute
      compile $ do
          posts <- recentFirst =<< loadAll "posts/*"
          let archiveCtx =
                  listField "posts" postCtx (return posts) `mappend`
                  constField "title" "Archives"            `mappend`
                  constField "archive" "" `mappend`
                  siteCtx

          makeItem ""
              >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
              >>= loadAndApplyTemplate "templates/default.html" (baseSidebarCtx <> archiveCtx)
              >>= relativizeUrls

mkPaginate = do
  paginate <- buildPaginateWith postsGrouper "posts/*" postsPageId
  paginateRules paginate $ \page pattern -> do
    route idRoute
    compile $ do
        posts <- recentFirst =<< loadAllSnapshots pattern "content"
        let indexCtx =
                constField "title" (if page == 1 then "Home"
                                                 else "Blog posts, page " ++ show page) `mappend`
                listField "posts" postCtx (return posts) `mappend`
                constField "home" "" `mappend`
                paginateContext paginate page `mappend`
                siteCtx

        makeItem ""
            >>= applyAsTemplate indexCtx
            >>= loadAndApplyTemplate "templates/index.html" indexCtx
            >>= loadAndApplyTemplate "templates/default.html" (baseSidebarCtx <> indexCtx)
            >>= relativizeUrls
--------------------------------------------------------------------------------

postsGrouper :: (MonadFail m, MonadMetadata m) => [Identifier] -> m [[Identifier]]
postsGrouper = liftM (paginateEvery 3) . sortRecentFirst

postsPageId :: PageNumber -> Identifier
postsPageId n = fromFilePath $ if (n == 1) then "index.html" else show n ++ "/index.html"
-}
--------------------------------------------------------------------------------

feedConfig :: FeedConfiguration
feedConfig = FeedConfiguration
    { feedTitle       = "Programming Languages: Functional Programming"
    , feedDescription = "IM, NTU"
    , feedAuthorName  = "Shin-Cheng Mu"
    , feedAuthorEmail = "scm@iis.sinica.edu.tw"
    , feedRoot        = "https://github.com/hahey/lanyon-hakyll"
    }

--------------------------------------------------------------------------------

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

siteCtx :: Context String
siteCtx =
    baseCtx `mappend`
    constField "site_description"
               "Programming Languages: Functional Programming" `mappend`
    constField "site-url" "https://scmu.github.io/plfp" `mappend`
    constField "tagline" "National Taiwan University, 2020" `mappend`
    constField "site-title" "程式語言：函數程式設計" `mappend`
    constField "copy-year" "2020" `mappend`
    constField "github-repo" "https://github.com/hahey/lanyon-hakyll" `mappend`
    defaultContext

baseCtx =
    constField "baseurl" "https://scmu.github.io/plfp"
               -- "http://localhost:8000"

--------------------------------------------------------------------------------

sidebarCtx :: Context String -> Context String
sidebarCtx nodeCtx =
    listField "list_pages" nodeCtx (loadAllSnapshots "pages/*" "page-content") `mappend`
    defaultContext

baseNodeCtx :: Context String
baseNodeCtx =
    urlField "node-url" `mappend`
    titleField "page-name" `mappend`
    baseCtx `mappend`
    defaultContext

baseSidebarCtx = sidebarCtx baseNodeCtx

evalCtxKey :: Context String -> [String] -> Item String -> Compiler String
evalCtxKey context [key] item = (unContext context key [] item) >>= \cf ->
        case cf of
            StringField s -> return s
            _             -> error $ "Internal error: StringField expected"

getMetadataKey :: [String] -> Item String -> Compiler String
getMetadataKey [key] item = getMetadataField' (itemIdentifier item) key
