data Point = Point { x :: Int , y :: Int,  z :: Int} deriving Show
data Rect = Rect { base :: Point, box :: Point } deriving Show

contains :: Rect -> Point -> Bool  
contains (Rect base box) (Point px py pz) =
    x base <= px && px < x base + x box

inlet = do
    putStrLn "in-let"
    return 5

tryMe = do
    let x = inlet
    putStrLn "begin tryMe"
    y <- x
    putStrLn "Here?"
    putStrLn $ show (1+y)
    putStrLn "finish tryMe"



main :: IO () 
main = do
    tryMe  