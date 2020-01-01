module Portfolio.Common exposing (definitionItem, link, menu)

import Html
import Html.Attributes


link : String -> String -> Html.Html msg
link url label =
    Html.a [ Html.Attributes.href url ] [ Html.text label ]


definitionItem : String -> String -> Html.Html msg
definitionItem term text =
    Html.div []
        [ Html.dl []
            [ Html.text term ]
        , Html.dd
            []
            [ Html.text text ]
        ]


menu : Html.Html msg
menu =
    Html.ul
        [ Html.Attributes.class "top-menu"
        ]
        [ Html.li [] [ link "/" "Top" ]
        , Html.li [] [ link "/products" "Products" ]
        ]
