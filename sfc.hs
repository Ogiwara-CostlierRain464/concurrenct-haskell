main :: IO ()
main = do cs <- getContents
          putStr $ replace cs

replace :: [Char] -> [Char]
replace cs = concatMap replaceSFC cs

replaceSFC :: Char -> [Char]
replaceSFC 'S' = "Shounan"   
replaceSFC 'F' = "Fujisawa"   
replaceSFC 'C' = "Campus"   
replaceSFC c = [c]  