module Date exposing (Date(..), compareDates, dateToString)

type Date = 
  YearMonthDay Int Int Int

compareDates : Date -> Date -> Order
compareDates a b = 
  case ( a, b ) of
    ( YearMonthDay aY aM aD, YearMonthDay bY bM bD ) ->
      case compare aY bY of 
        EQ ->
          case compare aM bM of
            EQ ->
              compare aD bD
            _ ->
              compare aM bM
        _ ->
          compare aY bY

dateToString: Date -> String
dateToString date = 
  let
      padIfLessThan10 i = ( if i < 10 then "0" else "")
  in
  case date of 
    YearMonthDay y m d ->
      String.fromInt y 
        ++ "-"
        ++ padIfLessThan10 m 
        ++ String.fromInt m
        ++ "-"
        ++ padIfLessThan10 d 
        ++ String.fromInt d
