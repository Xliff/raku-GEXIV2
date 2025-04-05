use v6.c;

use GEXIV2::Raw::Types;

class GEXIV2::Main {

  method init {
    gexiv2_initialize;
  }

}

INIT {
  GEXIV2::Main.init unless $GEXIV2_INIT_ON_STARTUP
}

sub gexiv2_initialize
  returns gboolean
  is      native(gexiv2)
  is      export
{ * }
