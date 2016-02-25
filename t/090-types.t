#!perl6

use v6;

use Test;
use XML::Class;

my Bool $DEBUG;

class Test::Bool does XML::Class {
    has Bool $.attribute;
    has Bool $.element is xml-element;
}

my $obj = Test::Bool.new(attribute => True, element => True);

my $out;

lives-ok { 
    $out = $obj.to-xml(:element);
}, "boolean types - true values to xml";

diag $out if $DEBUG;

is $out<attribute>, 'true', "representation value of attribute is correct";
is $out[0][0].text, 'true', 'representation value of element is correct';

my $in;

lives-ok {
    $in = Test::Bool.from-xml($out);
}, "boolean types - true values from xml";

# these will almost certainly pass in the true case
# irrespective of the actual values
is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";

$obj = Test::Bool.new(attribute => False, element => False);


lives-ok { 
    $out = $obj.to-xml(:element);
}, "boolean types - false values to xml";

diag $out if $DEBUG;

is $out<attribute>, 'false', "representation value of attribute is correct";
is $out[0][0].text, 'false', 'representation value of element is correct';

lives-ok {
    $in = Test::Bool.from-xml($out);
}, "boolean types - false values from xml";

# these will almost certainly pass in the true case
# irrespective of the actual values
is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";



class Test::DateTime does XML::Class {
    has DateTime $.attribute;
    has DateTime $.element is xml-element;
}

my $d = DateTime.now;

$obj = Test::DateTime.new(attribute => $d, element => $d);


lives-ok { 
    $out = $obj.to-xml(:element);
}, "DateTime types";

diag $out if $DEBUG;

is $out<attribute>, $d.Str, "representation value of attribute is correct";
is $out[0][0].text, $d.Str, 'representation value of element is correct';


lives-ok {
    $in = Test::DateTime.from-xml($out);
}, "DateTime types - from xml";

is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";

class Test::Date does XML::Class {
    has Date $.attribute;
    has Date $.element is xml-element;
}

$d = Date.today;

$obj = Test::Date.new(attribute => $d, element => $d);


lives-ok { 
    $out = $obj.to-xml(:element);
}, "Date types";

diag $out if $DEBUG;

is $out<attribute>, $d.Str, "representation value of attribute is correct";
is $out[0][0].text, $d.Str, 'representation value of element is correct';


lives-ok {
    $in = Test::Date.from-xml($out);
}, "Date types - from xml";

is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";

class Test::Int does XML::Class {
    has Int $.attribute;
    has Int $.element is xml-element;
}


$obj = Test::Int.new(attribute => 99, element => 99);


lives-ok { 
    $out = $obj.to-xml(:element);
}, "Integer types";

diag $out if $DEBUG;

is $out<attribute>, "99", "representation value of attribute is correct";
is $out[0][0].text, "99", 'representation value of element is correct';


lives-ok {
    $in = Test::Int.from-xml($out);
}, "Integer types - from xml";

is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";


class Test::Rat does XML::Class {
    has Rat $.attribute;
    has Rat $.element is xml-element;
}


$obj = Test::Rat.new(attribute => 99.47, element => 99.47);


lives-ok { 
    $out = $obj.to-xml(:element);
}, "Rat types - to- xml";

diag $out if $DEBUG;

is $out<attribute>, "99.47", "representation value of attribute is correct";
is $out[0][0].text, "99.47", 'representation value of element is correct';


lives-ok {
    $in = Test::Rat.from-xml($out);
}, "Rat types - from xml";

is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";

class Test::Num does XML::Class {
    has Num $.attribute;
    has Num $.element is xml-element;
}


$obj = Test::Num.new(attribute => Num(99.47), element => Num(99.47));


lives-ok { 
    $out = $obj.to-xml(:element);
}, "Num types - to- xml";

diag $out if $DEBUG;

is $out<attribute>, "99.47", "representation value of attribute is correct";
is $out[0][0].text, "99.47", 'representation value of element is correct';


lives-ok {
    $in = Test::Num.from-xml($out);
}, "Num types - from xml";

is $in.attribute, $obj.attribute, "attribute values match";
is $in.element, $obj.element, "element values match";

done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
