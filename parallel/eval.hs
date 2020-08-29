import Control.Parallel.Strategies
import Control.Parallel
import System.Environment
import Control.Exception
import Control.DeepSeq

f :: Int -> Int
f x = x * 2

x :: Int
x = 3
y :: Int
y = 4

test1 :: Eval (Int, Int)
test1 = do
    a <- rpar (f x)
    b <- rpar (f y)
    return (a,b)

main :: IO ()
main = do 
    r <- evaluate (runEval test1)
    print $ show r
    
   