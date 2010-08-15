package Gloom::Doc;

1;

=encoding utf-8

=head1 NAME

Gloom::Doc - All About Gloom (the Great Little OO Module)

=head1 SYNOPSIS

In your C<Makefile.PL>:

    use inc::Module::Install;
    name 'MyMod';
    use_gloom 'MyMod::OO';

NOTE: Module::Install is not required to use Gloom. It just makes it a
      trivial process. If you don't use Module::Install, you can
      manually copy/symlink Gloom.pm to your C<lib/MyMod/OO.pm>.

then in C<lib/MyMod/Foo.pm>:

    package MyMod::Foo;
    use MyMod::OO -base;

    has 'foo';

and:

    package MyMod::Foo::Bar;
    use MyMod::Foo -base;

    has 'bar';

=head1 DESCRIPTION

L<Gloom> is a simple, clean and small OO base module. It can be used by
CPAN modules that need to be OO, but don't want to require a dependency
module to do it.

Gloom provides the OO basics like single inheritance, standard C<new>
and C<init> constructor methods, and C<has> attribute accessors. It also
turns on C<strict> and C<warnings> automatically.

Gloom is cascading. Using Gloom as a base class for class C<Foo>,
enables C<Foo> to later be used as a Gloomy base class. Using the C<-base>
syntax invokes all the Gloom functionality.

=head1 WHENCE GLOOM?

Using basic idiomatic OO in Perl is problematic. Perl provides the
lowest level mechanisms, but this is not even the bare minimum that you
would find useable. You'd want at least an object constructor and
attribute accessors.

L<Moose> and friends is the way to do serious OO right, but Moose has
issues too. Imagine you want to write a very simple CPAN module, and
want to do it in the OO style. Adding a Moose prerequisite feels like
adding an army tank to a flower arrangement. It's a huge installation
pain for your users if its not already installed, and it still carries a
startup performance penalty.

This is where Gloom comes in. Gloom is a CPAN module author's friend. It
provides Perl OO basics with B<No Dependency Prerequisites>. You simply
copy or symlink C<Gloom.pm> as your module's OO base module, then Gloom
will figure out the rest.

The great lesson of C<Module::Install> is that you can fix deficiencies
in standard things like L<ExtUtils::MakeMaker> or even C<perl> itself,
by shipping a little extra code with each module. With Gloom, you always
ship Gloom.pm, renamed as your OO base module.

If you use L<Module::Install>, all you need to do is add a line to your
C<Makefile.PL> file. It will create a Gloom based OO module for you and
keep it up to date. Just imagine, all your Perl OO needs resolved with
one line in a Makefile.PL! See L<Module::Install::Gloom> for details.

The great lesson of L<Spiffy> was OO feature propagation/cascading. When
a module is a Gloom subclass, it can be used as a first-rate Gloom base
class.

Spiffy was not well received by some people because it used source
filtering for a couple unrelated things. Just for the record, Gloom uses
no source filtering or any other fancy magics.

Gloom has nothing except the OO primitives that everyone wants. Gloom
simply makes basic Perl OO something that you don't need to worry
about any more.

=head1 FEATURES

Gloom provides the following features:

=head2 Usage, Inheritance and Cascading

When you use a Gloom subclass module, you can pass it the C<-base>
option to establish single inheritance to that module. In other words,
that module becomes your module's base or parent class.

    package My::Foo;
    use My::OO -base;

Now you are free to use My::Foo as a base class for some other class:

    package Your::Foo;
    use My::Foo -base;
    
    has 'what_you_want';

My::Foo has all the exact same powers of OO cascading as Gloom itself.

Note that My::OO is an exact copy of Gloom.pm. You don't change anything
in the file. The code sees how it was called and adapts the package name
on the fly.

=head2 Constructor

Gloom has a C<new()> class method. It creates an object and calls
C<<$self->init(@_)>>.

The default C<init()> method expects its arguments to be a list of
attribute name/value pairs. You can easily subclass C<init()> to do
things differently.

=head2 Attribute Accessor Generators

Gloom provides C<has> accessors that work exactly like the C<field>
accessors from C<Class::Field>. (C<has> is the Perl standard name for
attribute generators). The attributes are always read/write. They
provide an optional default value as well as an optional initialization
code snippet.

    package Foo;
    use Bar -base;

    has 'this';
    has 'that' => {};    # Defaults to a hash;
    has 'thus', -init => '$self->set_thus';

You can also mark them to support method chaining:

    has 'this', -chain;
    has 'that';

    $self->this('one')->that('two');

NOTE: Gloom C<has()> is completely different in usage from Moose C<has()>.

=head2 Exporting

Gloom and all its subclasses export the C<has()> function. You can have
your base class export more things by simply defining the L<Exporter>
variables, like:

    our @EXPORT = qw(foo bar);
    our @EXPORT_OK = qw(baz);

=head2 Other Stuff

Since the C<has> generators always return a true value, you usually
don't need the annoying:

    1;

line at the bottom of your Gloom based modules. The true value they
return is the Perl source code of the accessor. You can see this by
doing something like:

    print has 'foo' -init => '$self->init_foo';

Like Moose, using Gloom (or any subclass of Gloom) as a base class, will
automagically do the equivalent of:

    use strict;
    use warnings;

=head1 REPOSITORY AND COMMUNITY

The Gloom module can be found on CPAN and on GitHub:
L<http://github.com/ingydotnet/gloom-pm>.

Please join #gloom on irc.perl.org to discuss the new Gloom of Perl.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2010. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut