<?php

function get_json($url) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    $output = curl_exec($ch);
    curl_close($ch);
    return json_decode($output);
}

function post_json($url, $post_data) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
    $output = curl_exec($ch);
    curl_close($ch);
    return json_decode($output);
}

$APP_ID = 'wx6bcdccdd8918f357';
$APP_SC = '14ddc63ca4beea033f67e4b894717735';

if ($code = $_GET('code')) {
  $json = get_json("https://api.weixin.qq.com/sns/oauth2/access_token?appid=$APP_ID&secret=$APP_SC&code=$code&grant_type=authorization_code");
  if ($json['openid']) {
    post_json("http://test.account.zhaomw.cn/login", array("weixin_id" => $json->openid, "_format" => "json"));
    http_redirect('index.html?r=register', array('weixin_id'=>$json['openid']), true, HTTP_REDIRECT_PERM);
  }
}
http_redirect('/');
