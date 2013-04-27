
-- Types
data Side = X | O | Empty deriving (Enum)
type Board = Board {
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
                fromSide (eight) ]

-- Proerties
winner :: Board -> Side
winner = undefined

turn :: Board -> Side
turn = undefined

-- CSS
cssTurn :: Board -> String
cssTurn b = "#board." ++ (fromBoard b) ++ " .five:after { content: '" ++ x ++ "'; }"

