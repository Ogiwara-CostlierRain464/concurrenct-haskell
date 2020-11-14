import System.Environment ( getArgs )

main :: IO ()
main = do {
         args <- getArgs;
         print $ foldr (+) 0 $ map read args;
       }       