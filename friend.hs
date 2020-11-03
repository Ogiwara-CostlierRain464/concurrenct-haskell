main :: IO ()
main = do 
       putStrLn $ show $ hi 2 4
          
hi :: Int -> Int -> Int
hi a b = a + b          
