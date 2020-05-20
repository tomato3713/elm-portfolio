module Portfolio.Common exposing (blackCat, definitionItem, footer, header, link, menu)

import Html
import Html.Attributes
import Svg
import Svg.Attributes


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
    Html.div
        [ Html.Attributes.class "top-menu" ]
        [ Html.div
            []
            [ link "/" "Home" ]
        , Html.div
            [ Html.Attributes.class "lastchild" ]
            [ link "/products" "Products" ]
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


footer : Html.Html msg
footer =
    Html.div
        [ Html.Attributes.class "footer" ]
        [ Html.hr
            []
            []
        , linklist
        ]


header : String -> Html.Html msg
header title =
    Html.div
        [ Html.Attributes.class "header" ]
        [ Html.h1
            []
            [ Html.text title ]
        , menu
        ]


blackCat : Html.Html msg
blackCat =
    Svg.g
        [ Svg.Attributes.id "blackCat"
        , Svg.Attributes.transform "scale(0.2, 0.2)"
        ]
        [ Svg.path
            [ Svg.Attributes.d
                """M49.35 30.36c-1.38 3.22-2.06 2.37-4.69 9.56-.76 2.1-4.32
            3.01-8.95 7.58-6.93 6.83-7.33 8.42-7.8 11.88-.17 1.26-1.16 7.77-.94
            9.23.37 2.41 5.9 4.56 7.9 5.2 1.22.38 12.32 4.15 13.58 4.77 1.27.63
            5.06 2.91 7.54 4.26 10.99 5.97-12.79 29.22-19.12 34.28-5.2
            4.16-16.5 10.01-14.7 11.65 2.08 1.88 9.3 1.04 13.84.2 3.2-.6
            21.57-12.06 25.72-14.26 10.5-5.6 28.79-10.23 12.73 12.05-1.22
            1.94-9.66 6.8-11.2 7.5-19.9 8.92-15.47 11.83-16.52 12 1.4.87 7.3
            5.49 29.13-4.26 15.1-9.93 44.38-12.13 46.6-13.32 23.2-.98 25.46
            2.44 25.46 2.44 6.5 7.72 6.74 18-2.97 25.72-2.42 4.64-19.96
            10.72-19.96 10.72l-13.28
            2.35c-6.6-.12-8.51.6-14.9.55l-12.93-1.78-12.15-1.9c-3.04 1.04-5.65
            5.83-.17 9.52 1.08.9 8.53 1.71 10.19 2.34 2.8 1.06 4.8 2.2 29.4
            2.22 27.85.03 15.23-.3 28.08-3.31 7.46-1.75 13.28-2.69 18.18-6.32
            8.7-3.03 21.32-19.27 24.06-24.4 5.75-13.3 2.9-5.3 4.55-17.16
            2.34-16.9
            2.88-21.31.17-35.78-.35-1.23-3.9-9.48-9.79-23.4-6.46-10.92-13.02-13.91-16.96-15.98-13.24-6.94-25.27-6.58-30.66-5.73-2.3.33-20.37
            2.23-24.82 2.75-3.36.28-24
            4.05-29.38-.36-6.13-5.04-5.74-7.3-8.82-9.4-5-2.68-6.1-2.34-7.74-5.36a21.85
            21.85 0 00-4.18-5.12c-1.4-1.23-2.7-3.6-4.5-.93z"""
            , Svg.Attributes.fill "#1b1d21"
            ]
            []
        ]
