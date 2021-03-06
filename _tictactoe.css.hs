
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

toBoard :: [Side] -> Board
toBoard s = Board { zero = s !! 0
                  , one = s !! 1
                  , two = s !! 2
                  , three = s !! 3
                  , four = s !! 4
                  , five = s !! 5
                  , six = s !! 6
                  , seven = s !! 7
                  , eight = s !! 8 }
  

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
    cell (cellFunc,cellWordNumber)
      | cellFunc b == Empty = ""
      | otherwise = "#board." ++ (fromBoard b) ++ " .cell." ++ cellWordNumber ++ ":before { content: '"++ (fromSide $ cellFunc b):"'; }\n" ++ "#board." ++ (fromBoard b) ++ " .clicker." ++ cellWordNumber ++ " { display: none; }\n"

cssTurn :: Board -> String
cssTurn b
  | winner b /= Empty = "#board." ++ (fromBoard b) ++ " #turn:before { content: \"" ++ (fromSide $ winner b):" wins!\"; }\n" ++ "#board." ++ (fromBoard b) ++ " .clicker { display: none; }"
  | otherwise = "#board." ++ (fromBoard b) ++ " #turn:before { content: \"" ++ (fromSide $ turn b):"'s turn\"; }"

allBoards :: [Board]
allBoards = map toBoard $ filter balanced $ mapM (const [X,O,Empty]) [1..9]
  where
    balanced b = (abs $ (length $ filter (== X) b) - (length $ filter (== O) b)) <= 1

css b = (cssTurn b) ++ '\n':(cssBoard b)

main = do
  putStrLn $ unlines $ map css allBoards
