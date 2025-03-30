module Util exposing (..)
import Html exposing (a)

flip: (a -> b -> c) -> (b -> a -> c)
flip f a b = f b a

unique : (a -> a -> Bool) -> List a -> List a
unique comparator =
  let
      inList xs x = 
        List.filter (comparator x) xs 
        |> List.length 
        |> (<=) 1
  in
  List.foldl
    (\item acc -> 
      if inList acc item then
        acc
      else
        item :: acc
    ) []
