data Point = Point { x :: Int , y :: Int,  z :: Int} deriving Show
data Rect = Rect { base :: Point, box :: Point } deriving Show

contains :: Rect -> Point -> Bool  
contains (Rect base box) (Point px py pz) =
    x base <= px && px < x base + x box

main :: IO ()
main = do
    let r = Rect{ base = Point 1 1 1, box = Point 3 3 3 }
        p = Point 2 2 2
    print $ show(contains r p)    