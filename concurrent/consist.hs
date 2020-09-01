import Control.Concurrent
import qualified Data.Map as Map


type Name = String
type PhoneNumber = String
type PhoneBook = Map.Map Name PhoneNumber

newtype PhoneBookState = PhoneBookState (MVar PhoneBook)

new :: IO PhoneBookState
new = do
    m <- newMVar Map.empty
    return (PhoneBookState m)

insert :: PhoneBookState -> Name -> PhoneNumber -> IO ()
insert (PhoneBookState m) name number = do
    book <- takeMVar m
    putMVar m $! Map.insert name number book

lookup' :: PhoneBookState -> Name -> IO (Maybe PhoneNumber)
lookup' (PhoneBookState m) name = do
    book <- takeMVar m
    -- we need to put back the state.    
    putMVar m book 
    return (Map.lookup name book)

main = do
    s <- new 
    sequence_ [ insert s ("name" ++ show n)(show n) | n <- [1..10000] ]    
    lookup' s "name999" >>= print
    lookup' s "name1000" >>= print
    lookup' s "name99" >>= print
    lookup' s "name9" >>= print
    lookup' s "name999999" >>= print
    lookup' s "unknown" >>= print