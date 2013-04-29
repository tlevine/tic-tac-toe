
-- Types
data Side = X | O | Empty deriving (Enum, Eq)
data Board = Board {
  zero :: Side,
  one :: Side,
  two :: Side,
  three :: Side,
  four :: Side,
  five :: Side,
  six :: Side,
  seven :: Side,
  eight :: Side
}

fromSide :: Side -> Char
fromSide X = 'x'
fromSide O = 'o'
fromSide Empty = '_'

toSide :: Char -> Maybe Side
toSide 'x' = X
toSide 'o' = O
toSide '_' = Empty
toSide _ = Nothing

fromBoard :: Board -> String
fromBoard b = [ fromSide (zero b),
                fromSide (one b),
                fromSide (two b),
                fromSide (three b),
                fromSide (four b),
                fromSide (five b),
                fromSide (six b),
                fromSide (seven b),
                fromSide (eight b) ]

toBoard :: String -> Maybe Board
toBoard s
  | ((length s) /= 9) = Nothing
  | otherwise = b
    where
      b = Board { zero = toSide (s !! 0)
                , one = toSide (s !! 1)
                , two = toSide (s !! 2)
                , three = toSide (s !! 3)
                , four = toSide (s !! 4)
                , five = toSide (s !! 5)
                , six = toSide (s !! 6)
                , seven = toSide (s !! 7)
                , eight = toSide (s !! 8) }
  

-- Properties
winner :: Board -> Side
winner b 
  | length combinationWinners == 0 = Empty
  | otherwise = head combinationWinners
    where
      possibilities = [ (zero, one, two),
                        (three, four, five),
                        (six, seven, eight),
                        (zero, three, six),
                        (one, four, seven),
                        (two, five, eight),
                        (zero, four, eight),
                        (three, four, six) ]
      combinationWinner (x,y,z)
        | x b == y b && x b == z b = x b
        | otherwise = Empty
      combinationWinners = dropWhile (== Empty) (map combinationWinner possibilities)

turn :: Board -> Side
turn b
  | winner b /= Empty = Empty
  | winner b == Empty && (length $ filter (== 'x') uglyBoard) > (length $ filter (== 'o') uglyBoard) = O
  | otherwise = X
  where
    uglyBoard = fromBoard b

-- CSS
cssBoard :: Board -> String
cssBoard b = unlines $ map cell cellFuncs
  where
    cellFuncs = [(zero, "zero"),
                 (one, "one"),
                 (two, "two"),
                 (three, "three"),
                 (four, "four"),
                 (five, "five"),
                 (six, "six"),
                 (seven, "seven"),
                 (eight, "eight") ]
    cell (cellFunc,cellWordNumber) = "#board." ++ (fromBoard b) ++ " ." ++ cellWordNumber ++ ":after { content: '"++ (fromSide $ cellFunc b):"'; }"

cssTurn :: Board -> String
cssTurn b
  | winner b /= Empty = "#board." ++ (fromBoard b) ++ " #turn:after { content: \"" ++ (fromSide $ winner b):" wins!\"; }"
  | otherwise = "#board." ++ (fromBoard b) ++ " #turn:after { content: \"" ++ (fromSide $ turn b):"'s turn\"; }"

bb = Board { zero = Empty,
             one = X,
             two = X,
             three = O,
             four = O,
             five = X,
             six = Empty,
             seven = Empty,
             eight = Empty }

allBoards :: [Maybe Board]
allBoards = map toBoard $ filter balanced $ mapM (const "xo_") [1..9]
  where
    balanced uglyBoard = abs $ (length $ filter (== 'x') uglyBoard) - (length $ filter (== 'o') uglyBoard) <= 1

main = do
  putStrLn $ cssBoard bb
  putStrLn $ cssTurn bb
