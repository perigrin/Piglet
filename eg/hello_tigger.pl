#!/usr/bin/perl
use lib;
use Tigger;

our $hello = sub { 'Hello ' . shift };
our $target = 'World';

get '/' => sub {
    our $message = $hello->($target);
    return qq[
    <html>
        <head><title>$message</title></head>
        <body>
            <h1>$message</h1>
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

put '/' => sub {
    my $req = shift;
    $hello = sub { $req->content . ' ' . shift };
    my $res = $req->new_response;
    $res->redirect('/');
    return $res->finalize;
};

run;

__DATA__
