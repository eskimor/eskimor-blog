{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where
--------------------------------------------------------------------------------
import           Control.Monad.IO.Class (liftIO)
import           Data.Monoid (mconcat, (<>))
import           Control.Monad  (liftM)
import           Data.Foldable (foldr1)

--------------------------------------------------------------------------------
import           Hakyll
import           Hakyll.Web.Pandoc
import           Text.Pandoc.Options
import           System.IO.Unsafe (unsafePerformIO)

--------------------------------------------------------------------------------

main :: IO ()
main = hakyllWith config $ do

    match (anyOf [ "**.svg" , "**.png" , "**/*.js"
                 , "projects/**/*.elm" , "projects/**/*.html", "projects/**/*.json"
                 , "files/*", "favicon.ico"]) $ do
        route   idRoute
        compile copyFileCompiler

    match "**/*.css" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.md", "contact.md"]) $ do
        route   $ setExtension "html"
        compile $ fmap demoteHeaders <$> pandocCompiler
              >>= defaultCompiler "post" defaultContext
--------------------------------------------------------------------------------
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")

    tagsRules tags $ \tag pat -> do
        let title = "Posts tagged \"" ++ tag ++ "\""

        -- Copied from posts, need to refactor
        route idRoute
        compile $ do posts <- recentFirst =<< loadAll pat
                     let ctx = constField "title" title <>
                               listField "posts" (postCtx tags) (return posts) <>
                                 defaultContext
                     makePost ctx

        -- Create RSS feed as well
        version "rss" $ do
            route   $ setExtension "xml"
            compile $ loadAllSnapshots pat "content"
                >>= fmap (take 10) . recentFirst
                >>= renderRss (feedConfiguration title) feedCtx

-------------------------------------------------------------------------- INDEX

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- fmap (take 3) . recentFirst =<< loadAll ("posts/*"  .||. "slides/**/*.md")
            projects <- recentFirst =<< loadAll ("projects/**/*.md")
            let indexContext =
                    listField "posts" (postCtx tags) (return posts) <>
                    listField "projects" (postCtx tags) (return projects) <>
                    field "tags" (\_ -> renderTagList tags) <>
                    defaultContext

            getResourceBody >>= applyAsTemplate indexContext
                            >>= defaultCompiler "post" indexContext

--------------------------------------------------------------------------------
    match "templates/*.html" $ compile templateCompiler
----------------------------------------------------------------------- REVEALJS
    match "templates/default.revealjs" $ compile getResourceString
-------------------------------------------------------------------------- POSTS

    match "posts/*" $ do
        route   $ setExtension ".html"
        compile $ (fmap demoteHeaders <$> (pandocCompiler >>= saveSnapshot "content"))
                >>= defaultCompiler "post" (postCtx tags)

------------------------------------------------------------------------- SLIDES

    match "slides/**/*.md" $ do
        route   $ setExtension ".html"
        compile $ loadBody "templates/default.revealjs"
                  >>= pandocRevealJS
                  >>= saveSnapshot "content"
                  >>= relativizeUrls


    create ["posts.html"] $ do
        route idRoute
        compile $ do posts <- recentFirst =<< loadAll ("posts/*" .||. "slides/**/*.md")
                     let ctx = mconcat
                             [ constField "title" "Posts"
                             , listField "posts" (postCtx tags) (return posts)
                             , defaultContext]
                     makePost ctx

-------------------------------------------------------------------------- EXTRA

    match "projects/**/*.md" $ do
        route   $ setExtension ".html"
        compile $ (fmap demoteHeaders <$> (pandocCompiler >>= saveSnapshot "content"))
                >>= loadAndApplyTemplate "templates/post.html" (postCtx tags)
                >>= loadAndApplyTemplate "templates/default.html" (postCtx tags)
                >>= relativizeUrls

    create ["projects.html"] $ do
        route idRoute
        compile $ do posts <- recentFirst =<< loadAll "projects/**/*.md"
                     let ctx = constField "title" "Projects" <>
                               listField "posts" (postCtx tags) (return posts) <>
                               defaultContext
                     makePost ctx

--------------------------------------------------------------------------------

defaultCompiler :: String -> Context String -> Item String -> Compiler (Item String)
defaultCompiler tmpl ctx itm = relativizeUrls
                      =<< loadAndApplyTemplate "templates/default.html"      ctx
                      =<< loadAndApplyTemplate (fromFilePath $ "templates"</>tmpl<.>"html") ctx
                          itm

(</>) :: FilePath -> FilePath -> FilePath
a </> b = a <> "/" <> b

(<.>) :: FilePath -> String -> FilePath
a <.> b = a <> "." <> b

anyOf :: [Pattern] -> Pattern
anyOf = foldr (.||.) (complement mempty)

makePost :: Context String -> Compiler (Item String)
makePost ctx = makeItem "" >>= defaultCompiler "posts" ctx

--------------------------------------------------------------------------------

postCtx :: Tags -> Context String
postCtx tags = mconcat
    [ modificationTimeField "mtime" "%U"
    , tagsField "tags" tags
    , dateField "date" "%B %e, %Y"
    , dateField "Month" "%B"
    , dateField "day"   "%e"
    , dateField "year"  "%Y"
    , dateField "mon" "%b"
    , mapContext (drop 3) $ dateField "rest" "%B"
    , defaultContext]

otherCtx :: Tags -> Context String
otherCtx tags = tagsField "tags" tags <> defaultContext

--------------------------------------------------------------------------------
feedCtx :: Context String
feedCtx = mconcat
    [ bodyField "description"
    , defaultContext
    ]

--------------------------------------------------------------------------------
feedConfiguration :: String -> FeedConfiguration
feedConfiguration title = FeedConfiguration
    { feedTitle       = "eskimor's blog - " ++ title
    , feedDescription = "Personal blog of eskimor"
    , feedAuthorName  = "Robert Klotzner"
    , feedAuthorEmail = "robert@gonimo.com"
    , feedRoot        = "//eskimor.gonimo.com"
    }

config :: Configuration
config = defaultConfiguration
          { deployCommand = "rsync -avz ./_site/ /to/server"
          , previewHost = "0.0.0.0"
          }

pandocRevealJS :: String -> Compiler (Item String)
pandocRevealJS tmpl = let revealjsWriterOptions = defaultHakyllWriterOptions
                                                { writerIncremental = True
                                                , writerTemplate = Just tmpl
                                                , writerSectionDivs = False
                                                , writerSlideLevel = Just 2
                                                , writerSlideVariant = RevealJsSlides
                                                , writerIgnoreNotes = True
                                                , writerHtml5 = True }
                       in writePandocWith revealjsWriterOptions <$> (readPandoc =<< getResourceString)



