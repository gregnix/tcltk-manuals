---
CommandName: oauth
title: oauth
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: oauth
Keywords:
 - RFC 2718
 - RFC 5849
 - oauth
 - twitter
Copyright:
 - Copyright (c) 2014 Javi P. <hxm@eggdrop.es>
---

# Name

oauth - oauth API base signature

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [oauth]{.lit} [1.0.4]{.optlit}
[::oauth::config]{.cmd}
[::oauth::config]{.cmd} [options...]{.optarg}
[::oauth::header]{.cmd} [baseURL]{.arg} [postQuery]{.optarg}
[::oauth::query]{.cmd} [baseURL]{.arg} [postQuery]{.optarg}
:::

# Description

The **oauth** package provides a simple Tcl-only library for communication with [oauth](http://oauth.net) APIs. This current version of the package supports the Oauth 1.0 Protocol, as specified in [RFC 5849](http://tools.ietf.org/rfc/rfc5849.txt).

# TLS security considerations

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Commands

**::oauth::config**
: When this command is invoked without arguments it returns a dictionary containing the current values of all options.

**::oauth::config** ?*options*...?
: When invoked with arguments, options followed by their values, it is used to set and query various parameters of application and client, like proxy host and user agent for the HTTP requests. The detailed list of options is below:

    **-accesstoken** *string*
    : This is the user's token.

    **-accesstokensecret** *string*
    : This is the user's secret token.

    **-consumerkey** *string*
    : This is the public token of your app.

    **-consumersecret** *string*
    : This is the private token of your app.

    **-debug** *bool*
    : The default value is **off**. If you change this option to **on**, the basic signature just created will be printed to stdout, among other debug output.

    **-oauthversion** *version*
    : This is the version of the OAuth protocol to use. At the moment only **1.0** is supported, the default.

    **-proxyhost** *hostname*
    : You can set up a proxy host for send contact the oauth's api server.

    **-proxyport** *port-number*
    : Port number of your proxy.

    **-signmethod** *method*
    : The signature method to use. OAuth 1.0 only supports **HMAC-SHA1**, the default.

    **-timeout** *milliseconds*
    : Timeout in milliseconds for your query. The default value is **6000**, i.e. 6 seconds.

    **-urlencoding** *encoding*
    : The encoding used for creating the x-url-encoded URLs with **::http::formatQuery**. The default is **utf-8**, as specified by [RFC 2718](http://tools.ietf.org/rfc/rfc2718.txt).


**::oauth::header** *baseURL* ?*postQuery*?
: This command is the base signature creator. With proper settings for various tokens and secrets (See **::oauth::config**) the result is the base authentication string to send to the server.

    You do not need to call this procedure to create the query because **::oauth::query** (see below) will do for it for you. Doing so is useful for debugging purposes, though.

    url *baseURL*
    : This argument is the URI path to the OAuth API server. If you plan send a GET query, you should provide a full path.

        ```
        HTTP GET
        ::oauth::header {https://api.twitter.com/1.1/users/lookup.json?screen_name=AbiertaMente}
        ```

    url-encoded-string *postQuery*
    : When you have to send a header in POST format, you have to put the query string into this argument.

        ```
        ::oauth::header {https://api.twitter.com/1.1/friendships/create.json} {user_id=158812437&follow=true}
        ```


**::oauth::query** *baseURL* ?*postQuery*?
: This procedure will use the settings made with **::oauth::config** to create the basic authentication and then send the command to the server API. It takes the same arguments as **::oauth::header**.

    The returned result will be a list containing 2 elements. The first element will be a dictionary containing the HTTP header data response. This allows you, for example, to check the X-Rate-Limit from OAuth. The second element will be the raw data returned from API server. This string is usually a json object which can be further decoded with the functions of package **json**, or any other json-parser for Tcl.

    Here is an example of how it would work in Twitter. Do not forget to replace the placeholder tokens and keys of the example with your own tokens and keys when trying it out.

    ```
    % package require oauth
    % package require json
    % oauth::config -consumerkey {your_consumer_key} -consumersecret {your_consumer_key_secret} -accesstoken {your_access_token} -accesstokensecret {your_access_token_secret}

    % set response [oauth::query https://api.twitter.com/1.1/users/lookup.json?screen_name=AbiertaMente]
    % set jsondata [lindex $response 1]
    % set data [json::json2dict $jsondata]
    $ set data [lindex $data 0]
    % dict for {key val} $data {puts "$key => $val"}
    id => 158812437
    id_str => 158812437
    name => Un Librepensador
    screen_name => AbiertaMente
    location => Explico mis tuits ahí →
    description => 160Caracteres para un SMS y contaba mi vida entera sin recortar vocales. Ahora en Twitter, podemos usar hasta 140 y a mí me sobrarían 20 para contaros todo lo q
    url => http://t.co/SGs3k9odBn
    entities => url {urls {{url http://t.co/SGs3k9odBn expanded_url http://librepensamiento.es display_url librepensamiento.es indices {0 22}}}} description {urls {}}
    protected => false
    followers_count => 72705
    friends_count => 53099
    listed_count => 258
    created_at => Wed Jun 23 18:29:58 +0000 2010
    favourites_count => 297
    utc_offset => 7200
    time_zone => Madrid
    geo_enabled => false
    verified => false
    statuses_count => 8996
    lang => es
    status => created_at {Sun Oct 12 08:02:38 +0000 2014} id 521209314087018496 id_str 521209314087018496 text {@thesamethanhim http://t.co/WFoXOAofCt} source {<a href="http://twitter.com" rel="nofollow">Twitter Web Client</a>} truncated false in_reply_to_status_id 521076457490350081 in_reply_to_status_id_str 521076457490350081 in_reply_to_user_id 2282730867 in_reply_to_user_id_str 2282730867 in_reply_to_screen_name thesamethanhim geo null coordinates null place null contributors null retweet_count 0 favorite_count 0 entities {hashtags {} symbols {} urls {{url http://t.co/WFoXOAofCt expanded_url http://www.elmundo.es/internacional/2014/03/05/53173dc1268e3e3f238b458a.html display_url elmundo.es/internacional/… indices {16 38}}} user_mentions {{screen_name thesamethanhim name Ἑλένη id 2282730867 id_str 2282730867 indices {0 15}}}} favorited false retweeted false possibly_sensitive false lang und
    contributors_enabled => false
    is_translator => true
    is_translation_enabled => false
    profile_background_color => 709397
    profile_background_image_url => http://pbs.twimg.com/profile_background_images/704065051/9309c02aa2728bdf543505ddbd408e2e.jpeg
    profile_background_image_url_https => https://pbs.twimg.com/profile_background_images/704065051/9309c02aa2728bdf543505ddbd408e2e.jpeg
    profile_background_tile => true
    profile_image_url => http://pbs.twimg.com/profile_images/2629816665/8035fb81919b840c5cc149755d3d7b0b_normal.jpeg
    profile_image_url_https => https://pbs.twimg.com/profile_images/2629816665/8035fb81919b840c5cc149755d3d7b0b_normal.jpeg
    profile_banner_url => https://pbs.twimg.com/profile_banners/158812437/1400828874
    profile_link_color => FF3300
    profile_sidebar_border_color => FFFFFF
    profile_sidebar_fill_color => A0C5C7
    profile_text_color => 333333
    profile_use_background_image => true
    default_profile => false
    default_profile_image => false
    following => true
    follow_request_sent => false
    notifications => false
    ```


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *oauth* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2014 Javi P. <hxm@eggdrop.es>
```
