
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

-- Proerties
winner :: Board -> Side
winner = undefined

turn :: Board -> Side
turn = undefined

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
  | turn b == Empty = "#board." ++ (fromBoard b) ++ " #turn:after { content: \"" ++ (fromSide $ winner b):" wins!\"; }"
  | otherwise = "#board." ++ (fromBoard b) ++ " #turn:after { content: \"" ++ (fromSide $ turn b):"'s turn\"; }"

main = do
  print "Hi"
