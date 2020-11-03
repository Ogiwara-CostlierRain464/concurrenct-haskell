main :: IO ()
main = do cs <- getContents
          putStr $ firstNlines 5 cs
          putStrLn "..."
          putStr $ lastNlines 5 cs

{-|
  Hi <br/> 
  This is doc comment test.
-}
firstNlines :: Int -> String -> String
firstNlines n cs = unlines $ take n $ lines cs

lastNlines :: Int -> String -> String
lastNlines n cs = unlines $ takeLast n $ lines cs

takeLast :: Int -> [a] -> [a]
takeLast n ss = reverse $ take n $ reverse ss


ba :: (Show a) => a -> String
ba w = show w 