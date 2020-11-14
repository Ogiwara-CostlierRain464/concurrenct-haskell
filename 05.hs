main :: IO ()
main = print $ take 20 $ twin $ filter isprime [1..]

factors :: Int -> [Int]
factors n = filter divisible [1..n]
    where divisible m = n `mod` m == 0  

isprime :: Int -> Bool
isprime 1 = False
isprime n = [1, n] == factors n          

twin :: [Int] -> [(Int, Int)]
twin primes = filter (\p -> isprime $ snd p) $ map (\e -> (e, e + 2)) primes