module Portfolio.Common exposing (link)

import Html
import Html.Attributes


link : String -> String -> Html.Html msg
link url label =
    Html.a [ Html.Attributes.href url ] [ Html.text label ]
