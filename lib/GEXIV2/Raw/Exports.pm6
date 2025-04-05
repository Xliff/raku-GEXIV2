use v6.c;

unit package GEXIV2::Raw::Exports;

our @gexiv2-exports is export;

BEGIN {
  @gexiv2-exports = <
    GEXIV2::Raw::Definitions
  >;
}
