module Portfolio.Common exposing (definitionItem, link, linklist, menu)

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


linklist : Html.Html msg
linklist =
    Html.div
        [ Html.Attributes.class "linklist" ]
        [ Html.h1
            []
            [ Html.text "Links" ]
        , Html.ul
            []
            [ Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Html.Attributes.href "https://twitter.com/tomato3713"
                        , Html.Attributes.class "contacts-item"
                        ]
                        [ Html.text "Twitter" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Html.Attributes.href "https://github.com/tomato3713"
                        , Html.Attributes.class "contacts-item"
                        ]
                        [ Html.text "GitHub" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Html.Attributes.href "https://tomato3713.hatenablog.com/"
                        , Html.Attributes.class "contacts-item"
                        ]
                        [ Html.text "Hatena Blog" ]
                    ]
                ]
            , Html.li
                []
                [ Html.span
                    []
                    [ Html.a
                        [ Html.Attributes.href "https://qiita.com/tomato3713"
                        , Html.Attributes.class "contacts-item"
                        ]
                        [ Html.text "Qiita" ]
                    ]
                ]
            ]
        ]
