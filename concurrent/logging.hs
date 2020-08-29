import Control.Concurrent
import Control.Monad 
import System.IO 
import Text.Printf

data Logger = Logger (MVar LogCommnad)
data LogCommnad = Message String | Stop (MVar ())

initLogger :: IO Logger
initLogger = do
    m <- newEmptyMVar
    let l = Logger m
    forkIO (logger l)
    return l

logger :: Logger -> IO()
logger (Logger m) = loop
    where
        loop = do
            cmd <- takeMVar m
            case cmd of
                Message msg -> do
                    putStrLn msg
                    loop
                Stop s -> do
                    putStrLn "logger: stop"
                    putMVar s ()   

logMessage :: Logger -> String -> IO ()
logMessage (Logger m) s = putMVar m (Message s)

logStop :: Logger -> IO ()
logStop (Logger m) = do
    s <- newEmptyMVar
    putMVar m (Stop s)
    takeMVar s




main = do
    -- Problem: logger's beffer-size is only 1.
    l <- initLogger
    logMessage l "hello"
    --logMessage l "bye"
    logStop l
