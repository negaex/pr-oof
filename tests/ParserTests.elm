module ParserTests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Parser exposing (parseString)
import SemiFormal exposing (Expression(..))
import Test exposing (..)


suite : Test
suite =
    describe "Parser"
        [ describe "Parser.parseString"
            [ -- Expect.equal is designed to be used in pipeline style, like this.
              test "p ⇒ p" <|
                \_ ->
                    "p ⇒ p"
                        |> parseString
                        |> Expect.equal (Ok (Implies (Sentence "p") (Sentence "p")))
            , test "p ∧ p" <|
                \_ ->
                    "p ∧ p"
                        |> parseString
                        |> Expect.equal (Ok (And (Sentence "p") (Sentence "p")))

            -- fuzz runs the test 100 times with randomly-generated inputs!
            , fuzz string "restores the original string if you run it again" <|
                \randomlyGeneratedString ->
                    randomlyGeneratedString
                        |> parseString
                        |> Expect.equal (parseString randomlyGeneratedString)
            ]
        ]
