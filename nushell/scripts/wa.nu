# simple script that lets you query things with the wolframalpha api.
export def-env main [...input: string] {
    let APPID = "7QR55X-LW9ATWWG9K" # Get one at https://products.wolframalpha.com/api/
    let question_string = ([($input | str join ' ')] | url encode | str join)
    let url = (["https://api.wolframalpha.com/v1/result?appid=", $APPID, "&i=", $question_string] | str join)
    curl -s $url
}
