{-# LANGUAGE CPP                      #-}
{-# LANGUAGE DataKinds                #-}
{-# LANGUAGE DeriveGeneric            #-}
{-# LANGUAGE TypeFamilies             #-}
{-# LANGUAGE TypeOperators            #-}
{-# LANGUAGE ForeignFunctionInterface #-}

-- leave exports public so that they are easy to play with in GHCI
module Lib where

import           Foreign.C
import           Servant
import           Language.Haskell.Liquid.Prelude

foreign import ccall unsafe calculate_discount :: CInt -> CInt -> CInt

calculateDiscount :: Int -> Int -> Int
calculateDiscount userId bookCount =
  fromIntegral $ calculate_discount (fromIntegral userId)
                                    (fromIntegral bookCount)

type BookStoreAPI = "user" :> Capture "userid" Int
                           :> "discount"
                           :> Capture "book-count" Int
                           :> Get '[JSON] Int

handleCalculateDiscount :: Monad m => Int -> Int -> m Int
handleCalculateDiscount id bookCount = return $ calculateDiscount id bookCount

bookStoreAPI :: Proxy BookStoreAPI
bookStoreAPI = Proxy

server :: Server BookStoreAPI
server = handleCalculateDiscount
