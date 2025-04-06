module Date exposing (Date(..), compareDates, dateToString, dateFromString)
import Maybe.Extra

type Date = 
  YearMonthDay Int Int Int


dateFromString : String -> Result String Date
dateFromString s =
  let
    ( year, month, dayWithTrailing ) = 
      case String.split "-" s of 
        [ y, m, d ] -> (Just y, Just m, Just d)
        _ -> ( Nothing, Nothing, Nothing )

    simpleDay = 
      dayWithTrailing
        |> Maybe.andThen (List.head << (String.split ("T")))

    maybeDecoded = 
      [ year, month, simpleDay ]
        |> List.map (Maybe.andThen (String.toInt))
        |> Maybe.Extra.combine
  in
  case maybeDecoded of
    Just [ yearDecoded, monthDecoded, dayDecoded ] ->
      Ok (YearMonthDay yearDecoded monthDecoded dayDecoded)
    Nothing ->
      Err ("Failed to decode " ++ s ++ " into Date")
    Just _ ->
      Err ("Failed to decode " ++ s ++ " into Date")



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
