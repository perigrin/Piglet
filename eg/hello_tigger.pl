#!/usr/bin/perl
use lib;
use Tigger;

our $target = 'World';

get '/' => sub {
    return qq[
    <html>
        <head><title>Hello $target</title></head>
        <body>
            <h1>Hello $target</h1>
            <form action="/" method="POST">
            <input type="text" name="who" value="$target" />
            <input type="submit"/>
            </form>
        </body>
    </html>
    ];
};

post '/' => sub {
    my $req = shift;
    $target = $req->param('who');
    warn "Target is $target";
    my $res = $req->new_response;
    $res->redirect('/');
    return $res->finalize;
};

run;

__DATA__
