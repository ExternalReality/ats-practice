module QuickCheckProp where

import Test.QuickCheck
import Foreign.C

boundedNatural :: Gen Integer
boundedNatural = choose (0, 100)

prop_fact_mult = forAll boundedNatural prop_fact_mult'

prop_fact_mult' n | n == 0    = r == 1
                  | otherwise = n * r1 == r
  where
    r  = ifact2(n)
    r1 = ifact2(n-1)
    
ifact2 :: Integer -> Integer
ifact2 n = product [1..n]
