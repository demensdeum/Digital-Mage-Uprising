cd src
elm make Main.elm --output=../build/Elm-main.js
cd ..

xcopy /s /y "external-libs" "build"
